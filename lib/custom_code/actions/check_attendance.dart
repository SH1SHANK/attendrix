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

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkAttendance(
  String classId,
  String courseId,
  String userId,
  bool isCustomClass,
  DateTime? classStartTime, // Required for custom classes
) async {
  try {
    if (isCustomClass) {
      // Handle custom class attendance using Firestore
      if (classStartTime == null) {
        print('Error: classStartTime is required for custom classes');
        return false;
      }

      return await _checkCustomClassAttendance(
        courseId,
        classStartTime,
        FirebaseFirestore.instance.collection('users').doc(userId),
      );
    } else {
      // Handle regular class attendance using Supabase
      return await _checkRegularClassAttendance(classId, userId);
    }
  } catch (e) {
    print('Exception in checkAttendance: $e');
    return false;
  }
}

Future<bool> _checkRegularClassAttendance(
  String classId,
  String userId,
) async {
  try {
    final response = await SupaFlow.client.rpc(
      'check_attendance_exists',
      params: {
        'p_class_id': classId,
        'p_user_id': userId,
      },
    );

    if (response.error != null) {
      print('Error checking regular attendance: ${response.error!.message}');
      return false;
    }

    // The RPC function returns a boolean
    return response.data as bool? ?? false;
  } catch (e) {
    print('Exception in _checkRegularClassAttendance: $e');
    return false;
  }
}

Future<bool> _checkCustomClassAttendance(
  String courseID,
  DateTime classStartTime,
  DocumentReference usersRef,
) async {
  try {
    // Use more efficient query with exact timestamp matching
    final targetTime = Timestamp.fromDate(classStartTime);
    final tolerance = const Duration(minutes: 1);
    final startRange = Timestamp.fromDate(classStartTime.subtract(tolerance));
    final endRange = Timestamp.fromDate(classStartTime.add(tolerance));

    final querySnapshot = await usersRef
        .collection('customClasses')
        .where('courseID', isEqualTo: courseID)
        .where('attendedClasses', arrayContainsAny: [targetTime])
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return true;
    }

    // Check with timestamp tolerance if exact match not found
    final serverQuery = await usersRef
        .collection('customClasses')
        .where('courseID', isEqualTo: courseID)
        .limit(1)
        .get();

    if (serverQuery.docs.isNotEmpty) {
      final docData = serverQuery.docs.first.data();
      final attendedClasses = docData['attendedClasses'] as List<dynamic>?;

      if (attendedClasses != null) {
        final targetTimeMs = classStartTime.millisecondsSinceEpoch;
        return attendedClasses.any((timestamp) {
          if (timestamp is Timestamp) {
            return (timestamp.toDate().millisecondsSinceEpoch - targetTimeMs)
                    .abs() <
                60000; // 1 minute tolerance
          }
          return false;
        });
      }
    }

    return false;
  } catch (e) {
    print('Exception in _checkCustomClassAttendance: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
