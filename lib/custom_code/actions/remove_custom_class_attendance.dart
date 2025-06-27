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

/// Function to remove attendance for a class by removing the timestamp from attendedClasses
Future<String> removeCustomClassAttendance(
  String courseID,
  DocumentReference userDocRef,
  DateTime classStartTime,
) async {
  try {
    // Pre-compute timestamp once to avoid multiple conversions
    final classTimestamp = Timestamp.fromDate(classStartTime);
    final classTimeMillis = classTimestamp.millisecondsSinceEpoch;

    // Query the customClasses collection by courseID field
    final querySnapshot = await userDocRef
        .collection('customClasses')
        .where('courseID', isEqualTo: courseID)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return 'Class not found. Please contact support if this issue persists.';
    }

    // Get the first (and should be only) matching document
    final doc = querySnapshot.docs.first;
    final data = doc.data();

    // Get attendedClasses array with null safety
    final attendedClasses = (data['attendedClasses'] as List<dynamic>?)
            ?.whereType<Timestamp>()
            .toList() ??
        <Timestamp>[];

    // Check if the timestamp exists in attendedClasses
    bool timestampFound = false;
    for (final timestamp in attendedClasses) {
      if (timestamp.millisecondsSinceEpoch == classTimeMillis) {
        timestampFound = true;
        break;
      }
    }

    if (!timestampFound) {
      return 'You were not marked as present for this class.';
    }

    // Atomic update operation to remove the timestamp from attendedClasses
    await doc.reference.update({
      'attendedClasses': FieldValue.arrayRemove([classTimestamp])
    });

    return 'Class marked as absent successfully.';
  } catch (e) {
    // More user-friendly error handling
    if (e is FirebaseException) {
      return 'Error while marking class as absent. Please try again later. Contact support if this issue persists.';
    }
    return 'Error while marking class as absent. Please try again later. Contact support if this issue persists.';
  }
}
