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

Future<void> clearAllClassesCache(String userPath) async {
  final userHash = _generateUserHash(userPath);
  final weekdays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  final classesBox = Hive.isBoxOpen(_classesBoxName)
      ? Hive.box(_classesBoxName)
      : await Hive.openBox(_classesBoxName);

  for (final day in weekdays) {
    await classesBox.delete('${userHash}_today_$day');
  }

  await classesBox.delete('${userHash}_last_fetch');

  debugPrint('[clearAllClassesCache] Cleared all cached days and timestamp');
}

//Helper Functions

String _generateUserHash(String path) {
  return md5.convert(utf8.encode(path)).toString().substring(0, 12);
}
