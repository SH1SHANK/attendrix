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

Future<bool> checkClassAttendance(
    String courseID,
    DateTime classStartTime,
    String userID,
    bool isCustomClass,
    DocumentReference usersRef,
    String classID,
    bool forceRefresh) async {
  if (courseID.isEmpty || userID.isEmpty || classID.isEmpty) return false;

  // Initialize Hive
  try {
    await initializeHiveSystem();
  } catch (e) {
    debugPrint('Hive init error: $e');
  }

  // Create cache key
  final cacheKey = isCustomClass
      ? "c_${courseID}_${classStartTime.millisecondsSinceEpoch ~/ 60000}"
      : "r_${userID}_$classID";

  // Check cache first (skip if forceRefresh is true)
  if (!forceRefresh) {
    try {
      final box = Hive.isBoxOpen('attendance_cache')
          ? Hive.box('attendance_cache')
          : await Hive.openBox('attendance_cache');

      final cached = box.get(cacheKey);
      if (cached is Map) {
        final data = Map<String, dynamic>.from(cached);
        final age =
            DateTime.now().millisecondsSinceEpoch - (data['time'] as int);
        if (age < 900000) {
          // 30 minutes
          return data['attended'] as bool;
        }
        box.delete(cacheKey); // Remove expired
      }
    } catch (e) {
      debugPrint('Cache check error: $e');
    }
  }

  bool attended = false;

  try {
    if (isCustomClass) {
      // Check custom class attendance
      final query = await usersRef
          .collection('customClasses')
          .where('courseID', isEqualTo: courseID)
          .limit(1)
          .get()
          .timeout(Duration(seconds: 5));

      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        if (data != null) {
          final attendedList = data['attendedClasses'] as List<dynamic>?;
          if (attendedList != null && attendedList.isNotEmpty) {
            final targetTime = classStartTime.millisecondsSinceEpoch;
            attended = attendedList.any((ts) {
              if (ts is Timestamp) {
                return (ts.toDate().millisecondsSinceEpoch - targetTime).abs() <
                    60000;
              }
              return false;
            });
          }
        }
      }
    } else {
      // Check regular class attendance
      final result = await SupaFlow.client
          .from('attendanceRecords')
          .select('id')
          .eq('userID', userID)
          .eq('classID', classID)
          .limit(1)
          .maybeSingle()
          .timeout(Duration(seconds: 5));

      attended = result != null;
    }

    // Cache the result (always update cache after fresh query)
    try {
      final box = Hive.isBoxOpen('attendance_cache')
          ? Hive.box('attendance_cache')
          : await Hive.openBox('attendance_cache');

      await box.put(cacheKey, {
        'attended': attended,
        'time': DateTime.now().millisecondsSinceEpoch
      });
    } catch (e) {
      debugPrint('Cache save error: $e');
    }
  } catch (e) {
    debugPrint('Check attendance error: $e');
  }

  return attended;
}
