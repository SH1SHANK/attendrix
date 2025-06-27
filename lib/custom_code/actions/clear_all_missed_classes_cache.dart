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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import '/custom_code/actions/initialize_hive_system.dart';
import 'package:hive_ce/hive.dart';

Future<bool> clearAllMissedClassesCache(
  bool clearMetadata,
  bool clearAttendanceCache,
) async {
  try {
    final initialized = await initializeHiveSystem();
    if (!initialized) {
      debugPrint('FlutterFlow: Hive initialization failed');
      return false;
    }

    // Open cache boxes
    final Box missedClassesBox = Hive.isBoxOpen("missed_classes_cache")
        ? Hive.box("missed_classes_cache")
        : await Hive.openBox("missed_classes_cache");

    final Box metadataBox = Hive.isBoxOpen('cache_metadata')
        ? Hive.box('cache_metadata')
        : await Hive.openBox('cache_metadata');

    int clearedEntries = 0;

    // Clear all missed classes data
    final missedClassesKeys = missedClassesBox.keys
        .where((key) => key.toString().startsWith('missed_classes_'))
        .toList();

    for (final key in missedClassesKeys) {
      await missedClassesBox.delete(key);
      clearedEntries++;
    }

    debugPrint(
        'FlutterFlow: Cleared ${missedClassesKeys.length} missed classes entries');

    // Clear all metadata if requested
    if (clearMetadata) {
      final metadataKeys = metadataBox.keys
          .where((key) => key.toString().startsWith('missed_classes_meta_'))
          .toList();

      for (final key in metadataKeys) {
        await metadataBox.delete(key);
        clearedEntries++;
      }

      debugPrint(
          'FlutterFlow: Cleared ${metadataKeys.length} metadata entries');
    }

    // Clear all attendance cache if requested
    if (clearAttendanceCache) {
      final Box attendanceBox = Hive.isBoxOpen('attendance_cache')
          ? Hive.box('attendance_cache')
          : await Hive.openBox('attendance_cache');

      final attendanceKeys = attendanceBox.keys.toList();

      for (final key in attendanceKeys) {
        await attendanceBox.delete(key);
        clearedEntries++;
      }

      debugPrint(
          'FlutterFlow: Cleared ${attendanceKeys.length} attendance cache entries');
    }

    debugPrint(
        'FlutterFlow: Successfully cleared $clearedEntries total cache entries');
    return clearedEntries > 0;
  } catch (e) {
    debugPrint('FlutterFlow: Error clearing all missed classes cache: $e');
    return false;
  }
}
