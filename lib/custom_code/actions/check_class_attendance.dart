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
import 'package:flutter/foundation.dart';
import '/custom_code/actions/initialize_hive_system.dart';

Future<bool> checkClassAttendance(
  String courseID,
  DateTime classStartTime,
  String userID,
  bool isCustomClass,
  DocumentReference usersRef,
  String classID,
) async {
  try {
    // Validate input parameters first
    if (courseID.isEmpty || userID.isEmpty || classID.isEmpty) {
      debugPrint('FlutterFlow: Invalid input parameters');
      return false;
    }

    // Initialize Hive system using the separate action
    await initializeHiveSystem();

    // Create optimized cache key
    final String cacheKey = isCustomClass
        ? "custom_${courseID}_${classStartTime.millisecondsSinceEpoch}"
        : "regular_${userID}_${classID}";

    // Use dynamic type for the box instead of Map<String, dynamic>
    Box? attendanceBox;

    try {
      attendanceBox = Hive.isBoxOpen('attendance_cache')
          ? Hive.box('attendance_cache')
          : await Hive.openBox('attendance_cache');
    } catch (hiveError) {
      debugPrint('FlutterFlow: Hive box error: $hiveError');
      // Continue without cache if Hive fails
    }

    // Check cache with timestamp validation (24 hours)
    if (attendanceBox != null) {
      try {
        final cachedData = attendanceBox.get(cacheKey);
        if (cachedData != null && cachedData is Map) {
          // Safer casting with null checks
          final Map<String, dynamic> cacheMap =
              Map<String, dynamic>.from(cachedData);
          final timestamp = cacheMap['timestamp'] as int?;
          final isAttended = cacheMap['attended'] as bool? ?? false;

          if (timestamp != null &&
              DateTime.now().millisecondsSinceEpoch - timestamp < 86400000) {
            debugPrint('FlutterFlow: Returning cached result: $isAttended');
            return isAttended;
          }
        }
      } catch (cacheError) {
        debugPrint('FlutterFlow: Cache read error: $cacheError');
        // Continue to database query if cache fails
      }
    }

    bool isAttended = false;

    if (isCustomClass) {
      try {
        // Firestore query for custom classes with null checks
        final querySnapshot = await usersRef
            .collection('customClasses')
            .where('courseID', isEqualTo: courseID)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final docData = querySnapshot.docs.first.data();
          if (docData != null) {
            final attendedClasses =
                docData['attendedClasses'] as List<dynamic>?;

            if (attendedClasses != null && attendedClasses.isNotEmpty) {
              final targetTime = classStartTime.millisecondsSinceEpoch;
              isAttended = attendedClasses.any((timestamp) {
                if (timestamp is Timestamp) {
                  return (timestamp.toDate().millisecondsSinceEpoch -
                              targetTime)
                          .abs() <
                      60000; // 1 minute tolerance
                }
                return false;
              });
            }
          }
        }
      } catch (firestoreError) {
        debugPrint('FlutterFlow: Firestore query error: $firestoreError');
        // Return false if Firestore query fails
      }
    } else {
      try {
        // Corrected Supabase query with better error handling
        final response = await SupaFlow.client
            .from('attendanceRecords')
            .select()
            .eq('userID', userID)
            .eq('classID', classID)
            .limit(1)
            .maybeSingle();

        isAttended = response != null;
      } catch (supabaseError) {
        debugPrint('FlutterFlow: Supabase query error: $supabaseError');
        // Return false if Supabase query fails
      }
    }

    // Cache result with timestamp (only if box is available)
    if (attendanceBox != null) {
      try {
        await attendanceBox.put(cacheKey, {
          'attended': isAttended,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      } catch (cacheWriteError) {
        debugPrint('FlutterFlow: Cache write error: $cacheWriteError');
        // Continue even if caching fails
      }
    }

    debugPrint('FlutterFlow: Attendance check result: $isAttended');
    return isAttended;
  } catch (e) {
    debugPrint('FlutterFlow: Error checking attendance: $e');
    return false;
  }
}
