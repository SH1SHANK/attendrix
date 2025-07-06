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

Future<List<ClassRowStruct>> fetchCustomClasses(
  DocumentReference userDocRef,
  String? weekday,
) async {
  // Early validation
  if (userDocRef.path.isEmpty) {
    return [];
  }

  try {
    // Single network call with optimized query
    final querySnapshot = await userDocRef
        .collection('customClasses')
        .get()
        .timeout(const Duration(seconds: 15));

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    // Process all documents in a single pass
    final classes = <ClassRowStruct>[];
    final weekdayOrder = _getWeekdayOrder();
    final filterWeekday = weekday?.toLowerCase();

    for (final doc in querySnapshot.docs) {
      final docClasses = _parseClassDocument(doc, filterWeekday);
      if (docClasses.isNotEmpty) {
        classes.addAll(docClasses);
      }
    }

    // Sort once at the end for better performance
    classes.sort((a, b) => _compareClasses(a, b, weekdayOrder));

    return classes;
  } catch (e) {
    debugPrint('[fetchAllClasses] Error: $e');
    return [];
  }
}

// Optimized document parsing with error handling
List<ClassRowStruct> _parseClassDocument(
    DocumentSnapshot doc, String? filterWeekday) {
  try {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) return [];

    // Extract common fields once
    final courseID = data['courseID']?.toString() ?? '';
    final courseName = data['courseName']?.toString() ?? 'Unknown Course';
    final isCustomClass = data['isCustomClass'] ?? false;
    final createdAt = _parseDateTime(data['createdAt']);

    // Validate slot data structure
    final slotData = data['slotData'];
    if (slotData == null) return [];

    final slotMetadata = slotData['slotMetadata'];
    if (slotMetadata is! List || slotMetadata.isEmpty) return [];

    // Pre-allocate list with known capacity
    final classes = <ClassRowStruct>[];

    // Process slots efficiently
    for (int i = 0; i < slotMetadata.length; i++) {
      final slot = slotMetadata[i];
      if (slot is! Map<String, dynamic>) continue;

      final classStruct = _createClassFromSlot(
        slot,
        doc.id,
        courseID,
        courseName,
        isCustomClass,
        createdAt,
        filterWeekday,
      );

      if (classStruct != null) {
        classes.add(classStruct);
      }
    }

    return classes;
  } catch (e) {
    return [];
  }
}

// Extracted method for creating class from slot data
ClassRowStruct? _createClassFromSlot(
  Map<String, dynamic> slot,
  String docId,
  String courseID,
  String courseName,
  bool isCustomClass,
  DateTime createdAt,
  String? filterWeekday,
) {
  final weekday = slot['weekday']?.toString().toLowerCase();
  final startTime = slot['startTime']?.toString();
  final endTime = slot['endTime']?.toString();
  final slotId = slot['slotId']?.toString() ?? '';

  // Validate required fields
  if (weekday == null || startTime == null || endTime == null) {
    return null;
  }

  // Filter by weekday if specified
  if (filterWeekday != null && weekday != filterWeekday) {
    return null;
  }

  return ClassRowStruct(
    classID: '${docId}_$slotId',
    courseID: courseID,
    courseName: courseName,
    classStartTime: startTime,
    classEndTime: endTime,
    weekday: weekday,
    createdAt: createdAt,
    isCustomClass: isCustomClass,
  );
}

// Optimized comparison function
int _compareClasses(
    ClassRowStruct a, ClassRowStruct b, List<String> weekdayOrder) {
  final aIndex = weekdayOrder.indexOf(a.weekday.toLowerCase());
  final bIndex = weekdayOrder.indexOf(b.weekday.toLowerCase());

  if (aIndex != bIndex) {
    return aIndex.compareTo(bIndex);
  }

  // Compare timestamps directly
  return a.classStartTime.compareTo(b.classStartTime);
}

// Cached weekday order for performance
List<String> _getWeekdayOrder() {
  return const [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
}

// Optimized DateTime parsing
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

  // Handle Firestore Timestamp format
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
