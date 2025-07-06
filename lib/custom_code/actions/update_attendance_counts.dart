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

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Cache constants
const String ATTENDANCE_CACHE_KEY = 'attendance_cache_';
const int CACHE_DURATION_MINUTES = 5;

/// Updates attendance counts for enrolled courses with simple caching
Future<String> updateAttendanceCounts(DocumentReference userDocRef) async {
  try {
    // Get user data
    final userDoc = await userDocRef.get();
    if (!userDoc.exists) return 'User document not found';

    final userData = userDoc.data() as Map<String, dynamic>;
    final userID = userData['uid']?.toString();
    final coursesRaw = userData['coursesEnrolled'] as List?;

    // Validate input parameters
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

    // Check cache first
    final cacheKey = '$ATTENDANCE_CACHE_KEY$userID';
    final shouldUpdate = await _shouldUpdateCache(cacheKey, enrolledCourses);

    if (!shouldUpdate) {
      // Update only the timestamp to show we checked
      await userDocRef
          .update({'lastDataFetchTime': FieldValue.serverTimestamp()});
      return 'Data is current (cached)';
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
        isEditable: course.isEditable,
        credits: course.credits,
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

    // Update cache
    await _updateCache(cacheKey, updatedCourses);

    return hasChanges
        ? 'Updated ${updatedCourses.length} courses'
        : 'No changes detected';
  } catch (e) {
    debugPrint('FlutterFlow: Update failed: $e');
    return 'Update failed: $e';
  }
}

/// Check if cache should be updated based on time and data changes
Future<bool> _shouldUpdateCache(
    String cacheKey, List<CoursesEnrolledStruct> currentCourses) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = prefs.getString(cacheKey);

    if (cacheData == null) return true; // No cache, need to update

    final cached = jsonDecode(cacheData);
    final cacheTimestamp = cached['timestamp'] as int? ?? 0;
    final cachedHash = cached['hash'] as String? ?? '';

    // Check if cache is expired (older than CACHE_DURATION_MINUTES)
    final now = DateTime.now().millisecondsSinceEpoch;
    final cacheAge = now - cacheTimestamp;
    final maxAge =
        CACHE_DURATION_MINUTES * 60 * 1000; // Convert to milliseconds

    if (cacheAge > maxAge) return true; // Cache expired

    // Check if data has changed
    final currentHash = _computeHash(currentCourses);
    return cachedHash != currentHash; // Update if data changed
  } catch (e) {
    debugPrint('FlutterFlow: Cache check failed: $e');
    return true; // On error, update to be safe
  }
}

/// Update cache with new data
Future<void> _updateCache(
    String cacheKey, List<CoursesEnrolledStruct> courses) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'hash': _computeHash(courses),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    await prefs.setString(cacheKey, jsonEncode(cacheData));
    debugPrint('FlutterFlow: Cache updated successfully');
  } catch (e) {
    debugPrint('FlutterFlow: Cache update failed: $e');
    // Continue without caching if it fails
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
