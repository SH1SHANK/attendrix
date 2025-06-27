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

import 'package:hive_ce/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<bool> clearAllClassAttendanceCache() async {
  try {
    // Get the attendance cache box
    Box<bool>? attendanceBox;

    try {
      if (Hive.isBoxOpen('attendance_cache')) {
        attendanceBox = Hive.box<bool>('attendance_cache');
      } else {
        attendanceBox = await Hive.openBox<bool>('attendance_cache');
      }
    } catch (e) {
      debugPrint('FlutterFlow: Failed to open attendance cache box: $e');
      return false;
    }

    if (attendanceBox != null) {
      // Get count of entries before clearing
      final entryCount = attendanceBox.length;

      // Clear all entries from the cache
      await attendanceBox.clear();

      debugPrint('FlutterFlow: Cleared $entryCount attendance cache entries');
      return true;
    }

    return false;
  } catch (e) {
    debugPrint('FlutterFlow: Error clearing attendance cache: $e');
    return false;
  }
}
