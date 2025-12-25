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

/// Function to cancel a class by adding the timestamp to cancelledClasses
/// and optionally removing it from attendedClasses if user was checked in
Future<String> cancelCustomClass(
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

    // Get arrays with null safety
    final attendedClasses = (data['attendedClasses'] as List<dynamic>?)
            ?.whereType<Timestamp>()
            .toList() ??
        <Timestamp>[];

    final cancelledClasses = (data['cancelledClasses'] as List<dynamic>?)
            ?.whereType<Timestamp>()
            .toList() ??
        <Timestamp>[];

    // Check if class is already cancelled
    for (final timestamp in cancelledClasses) {
      if (timestamp.millisecondsSinceEpoch == classTimeMillis) {
        return 'This class is already cancelled.';
      }
    }

    // Check if user was previously checked in to this class
    bool wasCheckedIn = false;
    for (final timestamp in attendedClasses) {
      if (timestamp.millisecondsSinceEpoch == classTimeMillis) {
        wasCheckedIn = true;
        break;
      }
    }

    // Prepare update operations
    Map<String, dynamic> updateData = {
      'cancelledClasses': FieldValue.arrayUnion([classTimestamp])
    };

    // If user was checked in, also remove from attendedClasses
    if (wasCheckedIn) {
      updateData['attendedClasses'] = FieldValue.arrayRemove([classTimestamp]);
    }

    // Atomic update operation
    await doc.reference.update(updateData);

    if (wasCheckedIn) {
      return 'Class cancelled successfully. Your attendance has been removed.';
    } else {
      return 'Class cancelled successfully.';
    }
  } catch (e) {
    // User-friendly error handling
    return 'Error while cancelling class. Please try again later. Contact support if this issue persists.';
  }
}
