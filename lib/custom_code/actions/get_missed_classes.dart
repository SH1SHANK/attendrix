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

Future<List<ClassRowStruct>> getMissedClasses(
  String userID,
  List<String> enrolledCourseIDs,
  bool forceRefresh, // New parameter to force refresh
) async {
  try {
    final initialized = await initializeHiveSystem();
    if (!initialized) {
      debugPrint('FlutterFlow: Hive initialization failed');
      return [];
    }

    final String cacheKey = "missed_classes_${userID}";
    final String metaKey = "missed_classes_meta_${userID}";

    // Open cache boxes directly using Hive
    final Box missedClassesBox = Hive.isBoxOpen("missed_classes_cache")
        ? Hive.box("missed_classes_cache")
        : await Hive.openBox("missed_classes_cache");

    final Box metadataBox = Hive.isBoxOpen('cache_metadata')
        ? Hive.box('cache_metadata')
        : await Hive.openBox('cache_metadata');

    final Box attendanceBox = Hive.isBoxOpen('attendance_cache')
        ? Hive.box('attendance_cache')
        : await Hive.openBox('attendance_cache');

    final DateTime today = DateTime.now();
    final String todayStr = today.toIso8601String().split('T')[0];

    // Initialize variables
    String? lastFetchDate;
    DateTime? enrollmentStartDate;
    List<dynamic> cachedClasses = [];

    if (forceRefresh) {
      // Force refresh: Clear existing cache and fetch all data
      debugPrint('FlutterFlow: Force refresh triggered - clearing cache');

      // Clear existing cache
      await missedClassesBox.delete(cacheKey);
      await metadataBox.delete(metaKey);

      // Set enrollment start date (fallback to 1 year ago if not found)
      final cachedMeta = metadataBox.get(metaKey);
      if (cachedMeta != null && cachedMeta is Map) {
        final meta = Map<String, dynamic>.from(cachedMeta);
        final enrollmentStart = meta['enrollment_start_date'] as String?;
        if (enrollmentStart != null) {
          enrollmentStartDate = DateTime.parse(enrollmentStart);
        }
      }
      enrollmentStartDate ??= today.subtract(Duration(days: 365));

      // Fetch all data from enrollment start
      await _fetchMissedClassesForDateRange(
          userID,
          enrolledCourseIDs,
          enrollmentStartDate,
          today,
          cachedClasses,
          missedClassesBox,
          cacheKey);

      // Update metadata
      await metadataBox.put(metaKey, {
        'last_fetch_date': todayStr,
        'enrollment_start_date':
            enrollmentStartDate.toIso8601String().split('T')[0],
        'last_update': DateTime.now().millisecondsSinceEpoch,
        'total_count': cachedClasses.length,
        'force_refresh_timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      debugPrint(
          'FlutterFlow: Force refresh completed - fetched ${cachedClasses.length} missed classes');
    } else {
      // Normal flow: Check cache metadata and perform incremental sync
      final cachedMeta = metadataBox.get(metaKey);

      if (cachedMeta != null && cachedMeta is Map) {
        final meta = Map<String, dynamic>.from(cachedMeta);
        lastFetchDate = meta['last_fetch_date'] as String?;
        final enrollmentStart = meta['enrollment_start_date'] as String?;
        if (enrollmentStart != null) {
          enrollmentStartDate = DateTime.parse(enrollmentStart);
        }
      }

      // Get cached missed classes
      final cachedData = missedClassesBox.get(cacheKey);
      if (cachedData != null && cachedData is List) {
        cachedClasses = List<dynamic>.from(cachedData);
      }

      // Determine date range to check
      bool needsFetch = false;
      DateTime? fetchStartDate;
      DateTime fetchEndDate = today;
      List<String> daysToFetch = [];

      if (lastFetchDate == null) {
        // First run - fetch all from enrollment start
        needsFetch = true;
        enrollmentStartDate ??= today.subtract(Duration(days: 365));
        fetchStartDate = enrollmentStartDate;
        debugPrint('FlutterFlow: First run - fetching all missed classes');
      } else if (lastFetchDate != todayStr) {
        // Check which days need fetching based on attendance verification
        fetchStartDate = DateTime.parse(lastFetchDate).add(Duration(days: 1));

        // Get list of days between last fetch and today
        DateTime currentDay = fetchStartDate!;
        while (currentDay.isBefore(today) || currentDay.day == today.day) {
          final dayStr = currentDay.toIso8601String().split('T')[0];

          // Check if this day needs fetching by comparing attendance cache count
          final needsDayFetch = await _verifyDayRequiresFetch(
              userID, dayStr, enrolledCourseIDs, attendanceBox);

          if (needsDayFetch) {
            daysToFetch.add(dayStr);
            needsFetch = true;
          } else {
            debugPrint(
                'FlutterFlow: Skipping $dayStr - attendance records complete');
          }

          currentDay = currentDay.add(Duration(days: 1));
        }
      }

      if (needsFetch && fetchStartDate != null) {
        try {
          if (daysToFetch.isEmpty) {
            // First run or large range - fetch all
            await _fetchMissedClassesForDateRange(
                userID,
                enrolledCourseIDs,
                fetchStartDate,
                fetchEndDate,
                cachedClasses,
                missedClassesBox,
                cacheKey);
          } else {
            // Incremental fetch - only specific days
            await _fetchMissedClassesForSpecificDays(userID, enrolledCourseIDs,
                daysToFetch, cachedClasses, missedClassesBox, cacheKey);
          }

          // Update metadata
          await metadataBox.put(metaKey, {
            'last_fetch_date': todayStr,
            'enrollment_start_date':
                enrollmentStartDate?.toIso8601String().split('T')[0],
            'last_update': DateTime.now().millisecondsSinceEpoch,
            'total_count': cachedClasses.length,
          });
        } catch (e) {
          debugPrint('FlutterFlow: Error fetching missed classes: $e');
        }
      }
    }

    // Convert to ClassRowStruct list
    return cachedClasses.map((classData) {
      final data = Map<String, dynamic>.from(classData);

      // Helper function to convert DateTime to UNIX timestamp string
      String _dateTimeToUnixString(dynamic dateValue) {
        if (dateValue == null) {
          return DateTime.now().millisecondsSinceEpoch.toString();
        }

        if (dateValue is String) {
          try {
            // If it's already a UNIX timestamp string, return as is
            if (RegExp(r'^\d+$').hasMatch(dateValue)) {
              return dateValue;
            }
            // If it's an ISO date string, parse and convert to UNIX timestamp
            final dateTime = DateTime.parse(dateValue);
            return dateTime.millisecondsSinceEpoch.toString();
          } catch (e) {
            debugPrint('FlutterFlow: Error parsing date string: $dateValue');
            return DateTime.now().millisecondsSinceEpoch.toString();
          }
        }

        if (dateValue is DateTime) {
          return dateValue.millisecondsSinceEpoch.toString();
        }

        if (dateValue is int) {
          return dateValue.toString();
        }

        return DateTime.now().millisecondsSinceEpoch.toString();
      }

      return ClassRowStruct(
        classID: data['classID'] as String? ?? '',
        courseID: data['courseID'] as String? ?? '',
        courseName: data['courseName'] as String? ?? '',
        classStartTime: _dateTimeToUnixString(data['classStartTime']),
        classEndTime: _dateTimeToUnixString(data['classEndTime']),
        isCustomClass: data['isCustomClass'] as bool? ?? false,
      );
    }).toList();
  } catch (e) {
    debugPrint('FlutterFlow: Error in getMissedClassesWithIncrementalSync: $e');
    return [];
  }
}

// Helper function to verify if a day requires data fetching
Future<bool> _verifyDayRequiresFetch(
  String userID,
  String dateStr,
  List<String> enrolledCourseIDs,
  Box attendanceBox,
) async {
  try {
    // Get the total count of classes for this day
    final countResponse = await SupaFlow.client.rpc(
      'get_timetable_count_by_date_range',
      params: {
        'p_enrolled_courses': enrolledCourseIDs,
        'p_start_date': dateStr,
        'p_end_date': dateStr,
      },
    );

    if (countResponse == null) return true; // Fetch if we can't get count

    final countData = Map<String, dynamic>.from(countResponse);
    final dailyCounts = countData['daily_counts'] as Map<String, dynamic>?;
    final totalClassesForDay = dailyCounts?[dateStr] as int? ?? 0;

    if (totalClassesForDay == 0) return false; // No classes that day

    // Count attendance records in cache for this day
    int attendedClassesCount = 0;
    final attendanceKeys = attendanceBox.keys.where((key) =>
        key.toString().startsWith('regular_${userID}_') ||
        key.toString().startsWith('custom_'));

    for (final key in attendanceKeys) {
      final attendanceData = attendanceBox.get(key);
      if (attendanceData != null && attendanceData is Map) {
        final data = Map<String, dynamic>.from(attendanceData);
        final attended = data['attended'] as bool? ?? false;
        final timestamp = data['timestamp'] as int?;

        if (attended && timestamp != null) {
          final attendanceDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
          final attendanceDateStr =
              attendanceDate.toIso8601String().split('T')[0];

          if (attendanceDateStr == dateStr) {
            attendedClassesCount++;
          }
        }
      }
    }

    // If attended classes count matches total classes, no need to fetch
    final shouldFetch = attendedClassesCount < totalClassesForDay;

    debugPrint(
        'FlutterFlow: Day $dateStr - Attended: $attendedClassesCount, Total: $totalClassesForDay, Fetch: $shouldFetch');

    return shouldFetch;
  } catch (e) {
    debugPrint('FlutterFlow: Error verifying day $dateStr: $e');
    return true; // Fetch if error occurs
  }
}

// Helper function for date range fetching
Future<void> _fetchMissedClassesForDateRange(
  String userID,
  List<String> enrolledCourseIDs,
  DateTime startDate,
  DateTime endDate,
  List<dynamic> cachedClasses,
  Box missedClassesBox,
  String cacheKey,
) async {
  final response = await SupaFlow.client.rpc(
    'get_missed_classes_by_date_range',
    params: {
      'p_user_id': userID,
      'p_enrolled_courses': enrolledCourseIDs,
      'p_start_date': startDate.toIso8601String().split('T')[0],
      'p_end_date': endDate.toIso8601String().split('T')[0],
    },
  );

  if (response != null) {
    final responseData = Map<String, dynamic>.from(response);
    final List<dynamic> newMissedClasses =
        responseData['missed_classes'] as List<dynamic>? ?? [];

    await _mergeCachedClasses(
        cachedClasses, newMissedClasses, missedClassesBox, cacheKey);
  }
}

// Helper function for specific days fetching
Future<void> _fetchMissedClassesForSpecificDays(
  String userID,
  List<String> enrolledCourseIDs,
  List<String> daysToFetch,
  List<dynamic> cachedClasses,
  Box missedClassesBox,
  String cacheKey,
) async {
  for (final day in daysToFetch) {
    final response = await SupaFlow.client.rpc(
      'get_missed_classes_by_date_range',
      params: {
        'p_user_id': userID,
        'p_enrolled_courses': enrolledCourseIDs,
        'p_start_date': day,
        'p_end_date': day,
      },
    );

    if (response != null) {
      final responseData = Map<String, dynamic>.from(response);
      final List<dynamic> dayMissedClasses =
          responseData['missed_classes'] as List<dynamic>? ?? [];

      await _mergeCachedClasses(
          cachedClasses, dayMissedClasses, missedClassesBox, cacheKey);
    }
  }
}

// Helper function to merge cached classes
Future<void> _mergeCachedClasses(
  List<dynamic> cachedClasses,
  List<dynamic> newMissedClasses,
  Box missedClassesBox,
  String cacheKey,
) async {
  final Set<String> existingClassIds =
      cachedClasses.map((c) => c['classID'] as String).toSet();

  final List<dynamic> uniqueNewClasses = newMissedClasses
      .where((c) => !existingClassIds.contains(c['classID']))
      .toList();

  cachedClasses.addAll(uniqueNewClasses);
  cachedClasses.sort((a, b) => DateTime.parse(b['classStartTime'])
      .compareTo(DateTime.parse(a['classStartTime'])));

  await missedClassesBox.put(cacheKey, cachedClasses);

  debugPrint(
      'FlutterFlow: Added ${uniqueNewClasses.length} new missed classes');
}
