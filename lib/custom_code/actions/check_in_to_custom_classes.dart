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

/// Enhanced function to check in to custom classes by querying the courseID field
Future<String> checkInToCustomClasses(
  String courseID,
  DocumentReference userDocRef,
  DateTime classStartTime,
) async {
  try {
    // Pre-compute timestamp once to avoid multiple conversions
    final classTimestamp = Timestamp.fromDate(classStartTime);
    final classTimeMillis = classTimestamp.millisecondsSinceEpoch;

    // Query the customClasses collection by courseID field (not document ID)
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

    // Get arrays with null safety
    final attendedClasses = (data['attendedClasses'] as List<dynamic>?)
            ?.whereType<Timestamp>()
            .toList() ??
        <Timestamp>[];

    final cancelledClasses = (data['cancelledClasses'] as List<dynamic>?)
            ?.whereType<Timestamp>()
            .toList() ??
        <Timestamp>[];

    // Single pass check for both attended and cancelled using efficient comparison
    for (final timestamp in attendedClasses) {
      if (timestamp.millisecondsSinceEpoch == classTimeMillis) {
        return 'You are already marked as present for this class.';
      }
    }

    for (final timestamp in cancelledClasses) {
      if (timestamp.millisecondsSinceEpoch == classTimeMillis) {
        return 'This class has been cancelled and check-in is not available.';
      }
    }

    // Atomic update operation using the document reference
    await doc.reference.update({
      'attendedClasses': FieldValue.arrayUnion([classTimestamp])
    });

    return 'Checked in successfully!';
  } catch (e) {
    // More user-friendly error handling
    return 'Error while checking in to class. Please try again later. Contact support if this issue persists.';
  }
}
