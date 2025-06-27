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

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'dart:convert';

// Box name constants
const String COURSE_ATTENDANCE_BOX = 'course_attendance_cache';

/// Updates attendance counts for enrolled courses with Hive caching
Future<String> updateAttendanceCounts(DocumentReference userDocRef) async {
  try {
    // Get user data
    final userDoc = await userDocRef.get();
    if (!userDoc.exists) return 'User document not found';

    final userData = userDoc.data() as Map<String, dynamic>;
    final userID = userData['uid']?.toString();
    final coursesRaw = userData['coursesEnrolled'] as List?;

    // Validate input parameters first
    if (userID == null ||
        userID.isEmpty ||
        coursesRaw == null ||
        coursesRaw.isEmpty) {
      debugPrint('FlutterFlow: Invalid user data parameters');
      return 'Invalid user data';
    }

    final enrolledCourses = coursesRaw
        .whereType<Map<String, dynamic>>()
        .map((e) => CoursesEnrolledStruct.fromMap(e))
        .toList();

    // Initialize Hive system using the separate action
    await initializeHiveSystem();

    // Create optimized cache key
    final String cacheKey = 'user_$userID';

    // Use dynamic type for the box instead of Map<String, dynamic>
    Box? cacheBox;

    try {
      cacheBox = Hive.isBoxOpen(COURSE_ATTENDANCE_BOX)
          ? Hive.box(COURSE_ATTENDANCE_BOX)
          : await Hive.openBox(COURSE_ATTENDANCE_BOX);
    } catch (hiveError) {
      debugPrint('FlutterFlow: Hive box error: $hiveError');
      // Continue without cache if Hive fails - force update
      return await _forceUpdateAttendanceCounts(
          userDocRef, userID, enrolledCourses);
    }

    final cachedData = cacheBox?.get(cacheKey);
    final currentHash = _computeHash(enrolledCourses);

    // Skip if data unchanged and recent (only if cache is available)
    if (cacheBox != null && cachedData != null) {
      final cachedHash = cachedData['hash'];
      final lastUpdate = cachedData['timestamp'] ?? 0;
      final timeDiff = DateTime.now().millisecondsSinceEpoch - lastUpdate;

      if (cachedHash == currentHash && timeDiff < 300000) {
        // 5 minutes
        await userDocRef
            .update({'lastDataFetchTime': FieldValue.serverTimestamp()});
        return 'Data is current';
      }
    }

    // Get course IDs
    final courseIDs = enrolledCourses
        .map((c) => c.courseID)
        .where((id) => id != null && id.isNotEmpty)
        .cast<String>()
        .toList();

    if (courseIDs.isEmpty) return 'No valid courses found';

    // Fetch from Supabase
    final response =
        await SupaFlow.client.rpc('batch_attendance_counts', params: {
      'course_ids': courseIDs,
      'user_id': userID,
    });

    if (response == null) return 'Failed to fetch attendance data';

    // Process response
    final attendanceMap = <String, Map<String, int>>{};
    for (final entry in response as List) {
      if (entry is Map<String, dynamic>) {
        final courseID = entry['course_id'] as String?;
        final total = entry['total_classes'] as int? ?? 0;
        final attended = entry['attended_classes'] as int? ?? 0;

        if (courseID != null) {
          attendanceMap[courseID] = {'total': total, 'attended': attended};
        }
      }
    }

    // Update courses
    final updatedCourses = enrolledCourses.map((course) {
      final courseID = course.courseID;
      if (courseID == null || !attendanceMap.containsKey(courseID)) {
        return course;
      }

      final data = attendanceMap[courseID]!;
      return CoursesEnrolledStruct(
        courseID: course.courseID,
        courseName: course.courseName,
        totalClasses: data['total'],
        attendedClasses: data['attended'],
        courseType: course.courseType,
      );
    }).toList();

    // Check for changes
    final hasChanges = _hasAttendanceChanges(enrolledCourses, updatedCourses);

    // Update Firestore if needed
    final Map<String, dynamic> updateData = {
      'lastDataFetchTime': FieldValue.serverTimestamp()
    };
    if (hasChanges) {
      updateData['coursesEnrolled'] =
          updatedCourses.map((c) => c.toMap()).toList();
    }

    await userDocRef.update(updateData);

    // Update cache (only if cache is available)
    if (cacheBox != null) {
      try {
        await cacheBox.put(cacheKey, {
          'hash': _computeHash(updatedCourses),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      } catch (cacheError) {
        debugPrint('FlutterFlow: Cache update failed: $cacheError');
        // Continue without caching if cache fails
      }
    }

    return hasChanges
        ? 'Updated ${updatedCourses.length} courses'
        : 'No changes detected';
  } catch (e) {
    debugPrint('FlutterFlow: Update failed: $e');
    return 'Update failed: $e';
  }
}

/// Force updates attendance counts without caching when Hive fails
Future<String> _forceUpdateAttendanceCounts(DocumentReference userDocRef,
    String userID, List<CoursesEnrolledStruct> enrolledCourses) async {
  try {
    debugPrint('FlutterFlow: Force updating attendance counts without cache');

    // Get course IDs
    final courseIDs = enrolledCourses
        .map((c) => c.courseID)
        .where((id) => id != null && id.isNotEmpty)
        .cast<String>()
        .toList();

    if (courseIDs.isEmpty) return 'No valid courses found';

    // Fetch from Supabase
    final response =
        await SupaFlow.client.rpc('batch_attendance_counts', params: {
      'course_ids': courseIDs,
      'user_id': userID,
    });

    if (response == null) return 'Failed to fetch attendance data';

    // Process response
    final attendanceMap = <String, Map<String, int>>{};
    for (final entry in response as List) {
      if (entry is Map<String, dynamic>) {
        final courseID = entry['course_id'] as String?;
        final total = entry['total_classes'] as int? ?? 0;
        final attended = entry['attended_classes'] as int? ?? 0;

        if (courseID != null) {
          attendanceMap[courseID] = {'total': total, 'attended': attended};
        }
      }
    }

    // Update courses
    final updatedCourses = enrolledCourses.map((course) {
      final courseID = course.courseID;
      if (courseID == null || !attendanceMap.containsKey(courseID)) {
        return course;
      }

      final data = attendanceMap[courseID]!;
      return CoursesEnrolledStruct(
        courseID: course.courseID,
        courseName: course.courseName,
        totalClasses: data['total'],
        attendedClasses: data['attended'],
        courseType: course.courseType,
      );
    }).toList();

    // Check for changes
    final hasChanges = _hasAttendanceChanges(enrolledCourses, updatedCourses);

    // Update Firestore
    final Map<String, dynamic> updateData = {
      'lastDataFetchTime': FieldValue.serverTimestamp()
    };
    if (hasChanges) {
      updateData['coursesEnrolled'] =
          updatedCourses.map((c) => c.toMap()).toList();
    }

    await userDocRef.update(updateData);

    return hasChanges
        ? 'Force updated ${updatedCourses.length} courses (no cache)'
        : 'No changes detected (no cache)';
  } catch (e) {
    debugPrint('FlutterFlow: Force update failed: $e');
    return 'Force update failed: $e';
  }
}

/// Compute simple hash for course data
String _computeHash(List<CoursesEnrolledStruct> courses) {
  final data = courses
      .map((c) => '${c.courseID}-${c.totalClasses}-${c.attendedClasses}')
      .join('|');
  return data.hashCode.toString();
}

/// Check if attendance data has changed
bool _hasAttendanceChanges(
    List<CoursesEnrolledStruct> original, List<CoursesEnrolledStruct> updated) {
  if (original.length != updated.length) return true;

  for (int i = 0; i < original.length; i++) {
    final orig = original[i];
    final upd = updated[i];

    if (orig.courseID != upd.courseID ||
        orig.totalClasses != upd.totalClasses ||
        orig.attendedClasses != upd.attendedClasses) {
      return true;
    }
  }

  return false;
}
