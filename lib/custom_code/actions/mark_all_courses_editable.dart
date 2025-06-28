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

Future<List<CoursesEnrolledStruct>> markAllCoursesEditable(
    List<CoursesEnrolledStruct> coursesEnrolled) async {
  // Map over the list and create new instances with isEditable set to true
  return coursesEnrolled.map((course) {
    return CoursesEnrolledStruct(
      courseID: course.courseID,
      courseName: course.courseName,
      courseType: course.courseType,
      courseFaculty: course.courseFaculty,
      attendedClasses: course.attendedClasses,
      totalClasses: course.totalClasses,
      isEditable: true, // Set this to true for all courses
    );
  }).toList();
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
