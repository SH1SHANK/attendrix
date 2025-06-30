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

Future<void> clearTodaysClassesCache(String userPath) async {
  final userHash = _generateUserHash(userPath);
  final today = _getCurrentWeekday();
  final classesBox = Hive.isBoxOpen(_classesBoxName)
      ? Hive.box(_classesBoxName)
      : await Hive.openBox(_classesBoxName);

  final todayCacheKey = '${userHash}_today_$today';
  final timestampKey = '${userHash}_last_fetch';

  await classesBox.delete(todayCacheKey);
  await classesBox.delete(timestampKey);

  debugPrint('[clearTodaysClassesCache] Cleared cache for $today');
}

//Helper Functions

String _generateUserHash(String path) {
  return md5.convert(utf8.encode(path)).toString().substring(0, 12);
}

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
