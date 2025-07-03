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

Future<FeedbackStruct> gradeCalculator(
    List<CourseDetailsStruct> courseDetails) async {
  // Check if at least 6 courses are provided
  if (courseDetails.length < 6) {
    return FeedbackStruct(
      status: 'Error',
      message: '',
      error: 'At least 6 courses are required for CGPA calculation',
      details:
          'Found ${courseDetails.length} courses, but minimum 6 courses are needed',
    );
  }

  // Validate course data and check for zero grades
  for (int i = 0; i < courseDetails.length; i++) {
    CourseDetailsStruct course = courseDetails[i];

    // Check for zero grade (failure case)
    if (course.gradeSelected == 0) {
      return FeedbackStruct(
        status: 'Error',
        message: '',
        error: 'Cannot calculate CGPA with failing grades',
        details:
            'Course ${course.courseID} has a failing grade (0). All courses must be passed to calculate CGPA.',
      );
    }

    // Check for invalid credits
    if (course.credits <= 0) {
      return FeedbackStruct(
        status: 'Error',
        message: '',
        error: 'Invalid credits found',
        details:
            'Course ${course.courseID} has invalid credits: ${course.credits}. Credits must be positive.',
      );
    }

    // Check for negative grade values
    if (course.gradeSelected < 0) {
      return FeedbackStruct(
        status: 'Error',
        message: '',
        error: 'Invalid grade found',
        details:
            'Course ${course.courseID} has an invalid grade: ${course.gradeSelected}. Grade cannot be negative.',
      );
    }
  }

  // Calculate CGPA
  double totalGradePoints = 0.0;
  int totalCredits = 0;

  for (CourseDetailsStruct course in courseDetails) {
    // gradeSelected directly contains the GPA for the course
    double courseGPA = course.gradeSelected.toDouble();
    totalGradePoints += courseGPA * course.credits;
    totalCredits += course.credits;
  }

  double cgpa = totalGradePoints / totalCredits;

  // Generate motivating message based on CGPA
  String motivatingMessage = _getMotivatingMessage(cgpa);

  // Format CGPA to 2 decimal places
  String formattedCGPA = cgpa.toStringAsFixed(2);

  return FeedbackStruct(
    status: 'CGPA Calculated: $formattedCGPA',
    message: motivatingMessage,
    error: '',
    details:
        'Total Credits: $totalCredits, Total Grade Points: ${totalGradePoints.toStringAsFixed(2)}',
  );
}

String _getMotivatingMessage(double cgpa) {
  if (cgpa >= 9.5) {
    return "🌟 Outstanding performance! You're truly exceptional and destined for greatness!";
  } else if (cgpa >= 9.0) {
    return "🏆 Excellent work! You're among the top performers. Keep up the fantastic effort!";
  } else if (cgpa >= 8.5) {
    return "⭐ Very impressive! You're doing remarkably well. Continue this excellent momentum!";
  } else if (cgpa >= 8.0) {
    return "🎯 Great job! You're performing very well. Your hard work is paying off!";
  } else if (cgpa >= 7.5) {
    return "👍 Good performance! You're on the right track. Keep pushing yourself!";
  } else if (cgpa >= 7.0) {
    return "💪 Solid work! You have a good foundation. There's room to reach even higher!";
  } else if (cgpa >= 6.5) {
    return "📈 You're doing well! With more focus, you can achieve even better results!";
  } else if (cgpa >= 6.0) {
    return "🚀 Keep going! Every step forward counts. You have the potential to improve!";
  } else if (cgpa >= 5.5) {
    return "💼 You're making progress! Focus on strengthening your fundamentals for better outcomes!";
  } else {
    return "🌱 Every journey starts with a single step. Use this as motivation to grow stronger!";
  }
}
