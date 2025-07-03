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

Future<bool> clearMissedClassesCache(String userID) async {
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

    // Clear the cache for this user
    await cacheBox.delete(cacheKey);

    debugPrint('FlutterFlow: Cleared missed classes cache for user $userID');
    return true;
  } catch (e) {
    debugPrint('FlutterFlow: Error clearing missed classes cache: $e');
    return false;
  }
}
