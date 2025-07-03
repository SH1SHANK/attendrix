// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/initialize_hive_system.dart';
import 'package:hive_ce/hive.dart';

Future<bool> removeMissedClass(
  String userID,
  String classID,
) async {
  try {
    // Initialize Hive
    final initialized = await initializeHiveSystem();
    if (!initialized) {
      debugPrint('FlutterFlow: Hive initialization failed');
      return false;
    }

    // Open cache box
    final Box cacheBox = Hive.isBoxOpen('missed_classes')
        ? Hive.box('missed_classes')
        : await Hive.openBox('missed_classes');

    final String cacheKey = userID;

    // Get cached data
    Map<String, dynamic>? cachedData = cacheBox.get(cacheKey);
    if (cachedData == null) {
      debugPrint('FlutterFlow: No cached data found for user $userID');
      return false;
    }

    // Get current classes list
    List<dynamic> currentClasses =
        List<dynamic>.from(cachedData['classes'] ?? []);

    // Find and remove the class
    final initialCount = currentClasses.length;
    currentClasses.removeWhere((classData) => classData['classID'] == classID);

    if (currentClasses.length < initialCount) {
      // Update cache with modified list
      cachedData['classes'] = currentClasses;
      cachedData['lastUpdate'] = DateTime.now().millisecondsSinceEpoch;

      await cacheBox.put(cacheKey, cachedData);

      debugPrint(
          'FlutterFlow: Removed class $classID from cache. Remaining: ${currentClasses.length}');
      return true;
    } else {
      debugPrint('FlutterFlow: Class $classID not found in cache');
      return false;
    }
  } catch (e) {
    debugPrint('FlutterFlow: Error removing missed class: $e');
    return false;
  }
}
