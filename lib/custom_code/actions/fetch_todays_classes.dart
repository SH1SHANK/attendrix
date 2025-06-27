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

Future<List<ClassRowStruct>> fetchTodaysClasses(
  DocumentReference userDocRef,
) async {
  // Initialize Hive system using the separate action
  final hiveInitialized = await initializeHiveSystem();
  if (!hiveInitialized) {
    debugPrint('[fetchTodaysClasses] Hive initialization failed');
    return [];
  }

  if (userDocRef.path.isEmpty) {
    debugPrint('[fetchTodaysClasses] Invalid userDocRef');
    return [];
  }

  final today = _getCurrentWeekday();
  final userHash = _generateUserHash(userDocRef.path);
  final todayCacheKey = '${userHash}_today_$today';
  final timestampKey = '${userHash}_last_fetch';

  Box? classesBox;

  try {
    classesBox = Hive.isBoxOpen(_classesBoxName)
        ? Hive.box(_classesBoxName)
        : await Hive.openBox(_classesBoxName);
  } catch (e) {
    debugPrint('[fetchTodaysClasses] Hive box error: $e');
  }

  // Check today's cache first
  if (classesBox != null) {
    try {
      final cachedTodayData = classesBox.get(todayCacheKey);
      final lastFetch = classesBox.get(timestampKey);

      if (cachedTodayData != null && _isCacheValid(lastFetch)) {
        debugPrint(
            '[fetchTodaysClasses] Returning cached today\'s data (${cachedTodayData.length} classes)');
        return _deserializeClasses(cachedTodayData);
      }
    } catch (e) {
      debugPrint('[fetchTodaysClasses] Cache read error: $e');
    }
  }

  // Get all classes and filter for today
  final allClasses = await fetchAllClasses(userDocRef);
  final todaysClasses = allClasses
      .where((cls) => cls.weekday.toLowerCase() == today.toLowerCase())
      .toList();

  // Cache today's classes separately for faster access
  if (classesBox != null) {
    try {
      final serializedClasses = todaysClasses.map((c) => c.toMap()).toList();
      await classesBox.put(todayCacheKey, serializedClasses);
      debugPrint(
          '[fetchTodaysClasses] Cached ${todaysClasses.length} classes for $today');
    } catch (e) {
      debugPrint('[fetchTodaysClasses] Cache write error: $e');
    }
  }

  debugPrint(
      '[fetchTodaysClasses] Returning ${todaysClasses.length} classes for $today');
  return todaysClasses;
}

// Helper functions
String _getCurrentWeekday() {
  final now = DateTime.now();
  final weekdays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
  return weekdays[now.weekday - 1];
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
