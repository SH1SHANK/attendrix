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

/// Updates attendance for a single course with optimized performance
Future<String> updateAttendanceForCourse(
  CoursesEnrolledStruct course,
  DocumentReference userDocRef,
) async {
  if (course.courseID.isEmpty) {
    return 'Error: Invalid course ID';
  }

  try {
    // Fetch attendance data with single optimized call
    final attendanceData =
        await _fetchAttendanceData(course.courseID, userDocRef.id);
    if (attendanceData == null) {
      return 'Failed to fetch attendance data';
    }

    final (totalClasses, attendedClasses) = attendanceData;

    // Skip update if no changes
    if (course.totalClasses == totalClasses &&
        course.attendedClasses == attendedClasses) {
      return 'No update needed';
    }

    // Update Firestore atomically
    final success = await _updateCourseInFirestore(
        userDocRef, course.courseID, totalClasses, attendedClasses);

    return success
        ? 'Successfully updated ${course.courseID}'
        : 'Update failed';
  } catch (e) {
    return 'Error: ${e.toString()}';
  }
}

/// Fetches attendance data with parallel RPC calls and simple retry
Future<(int, int)?> _fetchAttendanceData(String courseID, String userID) async {
  try {
    // Single timeout for both calls
    final results = await Future.wait([
      SupaFlow.client.rpc('counttimetable', params: {'course_id': courseID}),
      SupaFlow.client.rpc('countattendance',
          params: {'course_id': courseID, 'user_id': userID}),
    ]).timeout(const Duration(seconds: 10));

    final totalClasses = (results[0] as int?) ?? 0;
    final attendedClasses = (results[1] as int?) ?? 0;

    // Simple validation
    if (totalClasses < 0 ||
        attendedClasses < 0 ||
        attendedClasses > totalClasses) {
      return null;
    }

    return (totalClasses, attendedClasses);
  } catch (e) {
    // Single retry on failure
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final results = await Future.wait([
        SupaFlow.client.rpc('counttimetable', params: {'course_id': courseID}),
        SupaFlow.client.rpc('countattendance',
            params: {'course_id': courseID, 'user_id': userID}),
      ]).timeout(const Duration(seconds: 10));

      final totalClasses = (results[0] as int?) ?? 0;
      final attendedClasses = (results[1] as int?) ?? 0;

      return (totalClasses >= 0 &&
              attendedClasses >= 0 &&
              attendedClasses <= totalClasses)
          ? (totalClasses, attendedClasses)
          : null;
    } catch (_) {
      return null;
    }
  }
}

/// Updates course data in Firestore with transaction
Future<bool> _updateCourseInFirestore(
  DocumentReference userDocRef,
  String courseID,
  int totalClasses,
  int attendedClasses,
) async {
  try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(userDocRef);

      if (!docSnapshot.exists) {
        throw Exception('User document not found');
      }

      final data = docSnapshot.data() as Map<String, dynamic>;
      final courses = ((data['coursesEnrolled'] as List<dynamic>?) ?? [])
          .whereType<Map<String, dynamic>>()
          .toList();

      // Find and update the course
      bool courseFound = false;
      for (final course in courses) {
        if (course['courseID'] == courseID) {
          course['totalClasses'] = totalClasses;
          course['attendedClasses'] = attendedClasses;
          courseFound = true;
          break;
        }
      }

      // Add course if not found (shouldn't happen in normal flow)
      if (!courseFound) {
        courses.add({
          'courseID': courseID,
          'totalClasses': totalClasses,
          'attendedClasses': attendedClasses,
        });
      }

      // Single update with minimal fields
      transaction.update(userDocRef, {
        'coursesEnrolled': courses,
        'lastDataFetchTime': FieldValue.serverTimestamp(),
      });
    });

    return true;
  } catch (e) {
    // Single retry for transaction failures
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return await _updateCourseInFirestore(
          userDocRef, courseID, totalClasses, attendedClasses);
    } catch (_) {
      return false;
    }
  }
}
