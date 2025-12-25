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
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkClassCancellation(
  String courseID,
  DateTime classStartTime,
  DocumentReference userDocRef,
) async {
  try {
    // Validate input parameters
    if (courseID.isEmpty) {
      debugPrint('FlutterFlow: Invalid courseID parameter');
      return false;
    }

    // Single optimized Firestore query
    final querySnapshot = await userDocRef
        .collection('customClasses')
        .where('courseID', isEqualTo: courseID)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      debugPrint('FlutterFlow: No custom class found for courseID: $courseID');
      return false;
    }

    final docData = querySnapshot.docs.first.data();
    final cancelledClasses = docData['cancelledClasses'] as List<dynamic>?;

    if (cancelledClasses == null || cancelledClasses.isEmpty) {
      return false;
    }

    // Check if the class time matches any cancelled class (with 1-minute tolerance)
    final targetTime = classStartTime.millisecondsSinceEpoch;

    for (final timestamp in cancelledClasses) {
      if (timestamp is Timestamp) {
        final timeDifference =
            (timestamp.toDate().millisecondsSinceEpoch - targetTime).abs();
        if (timeDifference < 60000) {
          // 1 minute tolerance
          debugPrint(
              'FlutterFlow: Class is cancelled at ${timestamp.toDate()}');
          return true;
        }
      }
    }

    debugPrint('FlutterFlow: Class is not cancelled');
    return false;
  } catch (e) {
    debugPrint('FlutterFlow: Error checking class cancellation: $e');
    return false;
  }
}
