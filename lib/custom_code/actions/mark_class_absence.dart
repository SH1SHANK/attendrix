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

Future<bool> markClassAbsence(
  String courseID,
  DateTime classStartTime,
  String userID,
  bool isCustomClass,
  String classID,
) async {
  if (courseID.isEmpty || userID.isEmpty || classID.isEmpty) return false;

  try {
    // Initialize Hive
    await initializeHiveSystem();

    // Create cache key (same logic as checkClassAttendance)
    final cacheKey = isCustomClass
        ? "c_${courseID}_${classStartTime.millisecondsSinceEpoch ~/ 60000}"
        : "r_${userID}_$classID";

    // Open attendance box
    final box = Hive.isBoxOpen('attendance_cache')
        ? Hive.box('attendance_cache')
        : await Hive.openBox('attendance_cache');

    // Update cache immediately - mark as ABSENT (false)
    await box.put(cacheKey,
        {'attended': false, 'time': DateTime.now().millisecondsSinceEpoch});

    debugPrint('Marked attendance as ABSENT for: $courseID');
    return true;
  } catch (e) {
    debugPrint('Mark absence error: $e');
    return false;
  }
}
