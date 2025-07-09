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

/// Removes all classes for a specific courseID from the existing list.
/// Returns a new list with the course classes removed.
List<ClassRowStruct> removeCourseClasses(
  String courseID,
  List<ClassRowStruct> existingClasses,
) {
  if (courseID.isEmpty || existingClasses == null || existingClasses.isEmpty) {
    return List.from(existingClasses ?? []);
  }

  return existingClasses
      .where((classRow) => classRow.courseID != courseID)
      .toList();
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
