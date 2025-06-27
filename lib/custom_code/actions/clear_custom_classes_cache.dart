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

import 'package:hive_ce/hive.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<bool> clearCustomClassesCache(DocumentReference? userDocRef) async {
  const cacheKey = 'user_classes';

  try {
    // Initialize Hive system if needed
    await initializeHiveSystem();

    final box = Hive.isBoxOpen(cacheKey)
        ? Hive.box(cacheKey)
        : await Hive.openBox(cacheKey);

    if (userDocRef != null) {
      // Clear cache for specific user
      final userHash =
          md5.convert(utf8.encode(userDocRef.path)).toString().substring(0, 8);
      await box.delete(userHash);
    } else {
      // Clear all custom classes cache
      await box.clear();
    }

    return true;
  } catch (_) {
    return false;
  }
}
