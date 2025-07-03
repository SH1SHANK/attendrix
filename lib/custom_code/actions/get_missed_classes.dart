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

Future<List<ClassRowStruct>> getMissedClasses(
  String userID,
  List<String> enrolledCourseIDs,
  bool forceRefresh,
) async {
  try {
    // Initialize Hive
    final initialized = await initializeHiveSystem();
    if (!initialized) {
      debugPrint('FlutterFlow: Hive initialization failed');
      return [];
    }

    // Open single cache box
    final Box cacheBox = Hive.isBoxOpen('missed_classes')
        ? Hive.box('missed_classes')
        : await Hive.openBox('missed_classes');

    final String cacheKey = userID;
    final DateTime now = DateTime.now();
    final String todayStr = now.toIso8601String().split('T')[0];

    // Get cached data
    Map<String, dynamic>? cachedData = cacheBox.get(cacheKey);

    // Check if we need to fetch data
    bool shouldFetch = forceRefresh;

    if (!shouldFetch && cachedData != null) {
      final String? lastFetchDate = cachedData['lastFetchDate'];
      shouldFetch = lastFetchDate != todayStr;
    }

    List<dynamic> missedClasses = [];

    if (shouldFetch) {
      debugPrint(
          'FlutterFlow: ${forceRefresh ? "Force refresh" : "Fetching new data"} for $todayStr');

      // Determine date range
      DateTime startDate;
      if (forceRefresh || cachedData == null) {
        // Fetch from 1 year ago or enrollment start
        startDate = now.subtract(Duration(days: 365));
      } else {
        // Incremental fetch from last fetch date
        final lastFetchDate = cachedData['lastFetchDate'] as String?;
        startDate = lastFetchDate != null
            ? DateTime.parse(lastFetchDate).add(Duration(days: 1))
            : now.subtract(Duration(days: 365));
      }

      // Fetch missed classes
      final fetchedClasses = await _fetchMissedClassesFromDB(
          userID, enrolledCourseIDs, startDate, now);

      if (forceRefresh || cachedData == null) {
        // Replace all data
        missedClasses = fetchedClasses;
      } else {
        // Merge with existing data
        final existingClasses = List<dynamic>.from(cachedData['classes'] ?? []);
        missedClasses = _mergeClasses(existingClasses, fetchedClasses);
      }

      // Update cache
      await cacheBox.put(cacheKey, {
        'classes': missedClasses,
        'lastFetchDate': todayStr,
        'lastUpdate': now.millisecondsSinceEpoch,
      });

      debugPrint('FlutterFlow: Cached ${missedClasses.length} missed classes');
    } else {
      // Use cached data
      missedClasses = List<dynamic>.from(cachedData!['classes'] ?? []);
      debugPrint(
          'FlutterFlow: Using cached data with ${missedClasses.length} classes');
    }

    // Convert to ClassRowStruct
    return missedClasses
        .map((classData) => _convertToClassRowStruct(classData))
        .toList();
  } catch (e) {
    debugPrint('FlutterFlow: Error in getMissedClasses: $e');
    return [];
  }
}

// Fetch missed classes from database
Future<List<dynamic>> _fetchMissedClassesFromDB(
  String userID,
  List<String> enrolledCourseIDs,
  DateTime startDate,
  DateTime endDate,
) async {
  try {
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
      return responseData['missed_classes'] as List<dynamic>? ?? [];
    }
    return [];
  } catch (e) {
    debugPrint('FlutterFlow: Error fetching from DB: $e');
    return [];
  }
}

// Merge existing and new classes, removing duplicates
List<dynamic> _mergeClasses(List<dynamic> existing, List<dynamic> newClasses) {
  final Map<String, dynamic> classMap = {};

  // Add existing classes
  for (final classData in existing) {
    final classID = classData['classID'];
    if (classID != null) {
      classMap[classID] = classData;
    }
  }

  // Add/update with new classes
  for (final classData in newClasses) {
    final classID = classData['classID'];
    if (classID != null) {
      classMap[classID] = classData;
    }
  }

  // Convert back to list and sort by start time (newest first)
  final result = classMap.values.toList();
  result.sort((a, b) {
    try {
      final timeA = DateTime.parse(a['classStartTime']);
      final timeB = DateTime.parse(b['classStartTime']);
      return timeB.compareTo(timeA);
    } catch (e) {
      return 0;
    }
  });

  return result;
}

// Convert database row to ClassRowStruct
ClassRowStruct _convertToClassRowStruct(dynamic classData) {
  final data = Map<String, dynamic>.from(classData);

  String _dateTimeToUnixString(dynamic dateValue) {
    if (dateValue == null) {
      return DateTime.now().millisecondsSinceEpoch.toString();
    }

    if (dateValue is String) {
      try {
        // If already a UNIX timestamp
        if (RegExp(r'^\d+$').hasMatch(dateValue)) {
          return dateValue;
        }
        // Parse ISO date and convert to UNIX timestamp
        final dateTime = DateTime.parse(dateValue);
        return dateTime.millisecondsSinceEpoch.toString();
      } catch (e) {
        debugPrint('FlutterFlow: Error parsing date: $dateValue');
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
}
