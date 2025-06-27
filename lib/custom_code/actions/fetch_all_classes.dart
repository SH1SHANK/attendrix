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
import 'dart:convert';
import 'package:crypto/crypto.dart';

// Local constants for this action
const String _classesBoxName = 'classes_cache';

Future<List<ClassRowStruct>> fetchAllClasses(
  DocumentReference userDocRef,
) async {
  // Initialize Hive system using the separate action
  final hiveInitialized = await initializeHiveSystem();
  if (!hiveInitialized) {
    debugPrint('[fetchAllClasses] Hive initialization failed');
    return [];
  }

  if (userDocRef.path.isEmpty) {
    debugPrint('[fetchAllClasses] Invalid userDocRef');
    return [];
  }

  final userHash = _generateUserHash(userDocRef.path);
  final cacheKey = '${userHash}_all_classes';
  final timestampKey = '${userHash}_last_fetch';

  Box? classesBox;

  try {
    classesBox = Hive.isBoxOpen(_classesBoxName)
        ? Hive.box(_classesBoxName)
        : await Hive.openBox(_classesBoxName);
  } catch (e) {
    debugPrint('[fetchAllClasses] Hive box error: $e');
  }

  // Check cache first
  if (classesBox != null) {
    try {
      final cachedData = classesBox.get(cacheKey);
      final lastFetch = classesBox.get(timestampKey);

      if (cachedData != null && _isCacheValid(lastFetch)) {
        debugPrint(
            '[fetchAllClasses] Returning cached data (${cachedData.length} classes)');
        return _deserializeClasses(cachedData);
      }
    } catch (e) {
      debugPrint('[fetchAllClasses] Cache read error: $e');
    }
  }

  // Fetch from Firestore
  try {
    debugPrint('[fetchAllClasses] Fetching from Firestore...');

    final querySnapshot = await userDocRef
        .collection('customClasses')
        .get()
        .timeout(const Duration(seconds: 15));

    final classes = <ClassRowStruct>[];

    for (final doc in querySnapshot.docs) {
      final classDataList = _parseClassDocument(doc);
      if (classDataList.isNotEmpty) {
        classes.addAll(classDataList);
      }
    }

    // Sort classes by weekday and time
    classes.sort(_compareClasses);

    // Cache the results
    if (classesBox != null) {
      try {
        final serializedClasses = classes.map((c) => c.toMap()).toList();
        await classesBox.put(cacheKey, serializedClasses);
        await classesBox.put(
            timestampKey, DateTime.now().millisecondsSinceEpoch);
        debugPrint('[fetchAllClasses] Cached ${classes.length} classes');
      } catch (e) {
        debugPrint('[fetchAllClasses] Cache write error: $e');
      }
    }

    debugPrint(
        '[fetchAllClasses] Successfully fetched ${classes.length} classes');
    return classes;
  } catch (e) {
    debugPrint('[fetchAllClasses] Firestore fetch failed: $e');
    return [];
  }
}

// Updated helper function to parse timestamps directly
List<ClassRowStruct> _parseClassDocument(DocumentSnapshot doc) {
  try {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) return [];

    final classes = <ClassRowStruct>[];

    // Extract basic course information
    final courseID = data['courseID']?.toString() ?? '';
    final courseName = data['courseName']?.toString() ?? 'Unknown Course';
    final isCustomClass = data['isCustomClass'] ?? false;
    final createdAt = _parseDateTime(data['createdAt']);

    // Parse slotData structure
    final slotData = data['slotData'];
    if (slotData == null) {
      debugPrint(
          '[_parseClassDocument] No slotData found in document ${doc.id}');
      return [];
    }

    final slotMetadata = slotData['slotMetadata'];
    if (slotMetadata is! List) {
      debugPrint(
          '[_parseClassDocument] slotMetadata is not a list in document ${doc.id}');
      return [];
    }

    // Process each slot in the metadata
    for (final slot in slotMetadata) {
      if (slot is! Map<String, dynamic>) continue;

      final weekday = slot['weekday']?.toString().toLowerCase();
      final startTime = slot['startTime']?.toString();
      final endTime = slot['endTime']?.toString();
      final slotId = slot['slotId']?.toString() ?? '';

      if (weekday == null || startTime == null || endTime == null) {
        debugPrint(
            '[_parseClassDocument] Missing required slot data in document ${doc.id}');
        continue;
      }

      // Use timestamps directly without conversion
      final classStartTime = startTime; // Keep as "2025-06-16T08:00:00"
      final classEndTime = endTime; // Keep as "2025-06-16T08:50:00"

      // Create a unique class ID combining document ID and slot ID
      final classID = '${doc.id}_$slotId';

      classes.add(ClassRowStruct(
        classID: classID,
        courseID: courseID,
        courseName: courseName,
        classStartTime: classStartTime,
        classEndTime: classEndTime,
        weekday: weekday,
        createdAt: createdAt,
        isCustomClass: isCustomClass,
      ));
    }

    debugPrint(
        '[_parseClassDocument] Parsed ${classes.length} classes from document ${doc.id}');
    return classes;
  } catch (e) {
    debugPrint('[_parseClassDocument] Error parsing document ${doc.id}: $e');
    return [];
  }
}

int _compareClasses(ClassRowStruct a, ClassRowStruct b) {
  final weekdayOrder = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
  final aIndex = weekdayOrder.indexOf(a.weekday.toLowerCase());
  final bIndex = weekdayOrder.indexOf(b.weekday.toLowerCase());

  if (aIndex != bIndex) {
    return aIndex.compareTo(bIndex);
  }

  // Compare timestamps directly for sorting
  return a.classStartTime.compareTo(b.classStartTime);
}

String _generateUserHash(String path) {
  return md5.convert(utf8.encode(path)).toString().substring(0, 12);
}

bool _isCacheValid(int? lastFetchTimestamp) {
  if (lastFetchTimestamp == null) return false;

  const cacheValidityMs = 3600000; // 1 hour
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  return (currentTime - lastFetchTimestamp) < cacheValidityMs;
}

List<ClassRowStruct> _deserializeClasses(List<dynamic> cachedData) {
  return cachedData
      .map((classMap) =>
          ClassRowStruct.fromMap(classMap as Map<String, dynamic>))
      .toList();
}

DateTime _parseDateTime(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is DateTime) return value;

  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return DateTime.now();
    }
  }

  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }

  if (value is Map && value.containsKey('seconds')) {
    try {
      final seconds = value['seconds'] as int;
      final nanoseconds = (value['nanoseconds'] as int?) ?? 0;
      final milliseconds = (seconds * 1000) + (nanoseconds ~/ 1000000);
      return DateTime.fromMillisecondsSinceEpoch(milliseconds);
    } catch (_) {
      return DateTime.now();
    }
  }

  return DateTime.now();
}
