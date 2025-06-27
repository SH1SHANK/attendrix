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
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<bool> markClassAttendance(
  String courseID,
  DateTime classStartTime,
  String userID,
  bool isCustomClass,
  String classID,
) async {
  try {
    // Initialize Hive system using the separate action
    await initializeHiveSystem();

    // Create cache key using same logic as checkClassAttendance
    final String cacheKey = isCustomClass
        ? "custom_${courseID}_${classStartTime.millisecondsSinceEpoch}"
        : "regular_${userID}_${classID}";

    // Use the same box name and type as checkClassAttendance
    final Box attendanceBox = Hive.isBoxOpen('attendance_cache')
        ? Hive.box('attendance_cache')
        : await Hive.openBox('attendance_cache');

    // Remove existing cache entry if it exists
    if (attendanceBox.containsKey(cacheKey)) {
      await attendanceBox.delete(cacheKey);
    }

    // Mark as attended with timestamp (consistent with checkClassAttendance)
    await attendanceBox.put(cacheKey, {
      'attended': true,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    debugPrint('FlutterFlow: Marked attendance for key: $cacheKey');
    return true;
  } catch (e) {
    debugPrint('FlutterFlow: Error marking class attendance: $e');
    return false;
  }
}
