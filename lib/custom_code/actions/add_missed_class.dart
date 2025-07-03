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

Future<bool> addMissedClass(
  String userID,
  String classID,
  String courseID,
  String courseName,
  String classStartTime,
  String classEndTime,
  bool isCustomClass,
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

    // Get cached data or create new
    Map<String, dynamic> cachedData = cacheBox.get(cacheKey) ??
        {
          'classes': <dynamic>[],
          'lastFetchDate': DateTime.now().toIso8601String().split('T')[0],
          'lastUpdate': DateTime.now().millisecondsSinceEpoch,
        };

    // Get current classes list
    List<dynamic> currentClasses =
        List<dynamic>.from(cachedData['classes'] ?? []);

    // Check if class already exists
    if (!currentClasses.any((c) => c['classID'] == classID)) {
      // Create new class data
      final Map<String, dynamic> newClassData = {
        'classID': classID,
        'courseID': courseID,
        'courseName': courseName,
        'classStartTime': classStartTime,
        'classEndTime': classEndTime,
        'isCustomClass': isCustomClass,
      };

      // Add new class and sort
      currentClasses.add(newClassData);
      currentClasses.sort((a, b) {
        try {
          final timeA = DateTime.parse(a['classStartTime']);
          final timeB = DateTime.parse(b['classStartTime']);
          return timeB.compareTo(timeA);
        } catch (e) {
          return 0;
        }
      });

      // Update cache
      cachedData['classes'] = currentClasses;
      cachedData['lastUpdate'] = DateTime.now().millisecondsSinceEpoch;

      await cacheBox.put(cacheKey, cachedData);

      debugPrint(
          'FlutterFlow: Added class $classID to cache. Total: ${currentClasses.length}');
      return true;
    } else {
      debugPrint('FlutterFlow: Class $classID already exists in cache');
      return false;
    }
  } catch (e) {
    debugPrint('FlutterFlow: Error adding missed class: $e');
    return false;
  }
}
