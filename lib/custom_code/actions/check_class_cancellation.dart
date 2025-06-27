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
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '/custom_code/actions/initialize_hive_system.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkClassCancellation(
  String courseID,
  DateTime classStartTime,
  DocumentReference userDocRef,
) async {
  try {
    // Validate input parameters first
    if (courseID.isEmpty) {
      debugPrint('FlutterFlow: Invalid input parameters');
      return false;
    }

    // Initialize Hive system using the separate action
    await initializeHiveSystem();

    // Create optimized cache key for cancellation
    final String cacheKey =
        "cancellation_${courseID}_${classStartTime.millisecondsSinceEpoch}";

    // Use dynamic type for the box instead of Map<String, dynamic>
    Box? cancellationBox;

    try {
      cancellationBox = Hive.isBoxOpen('cancellation_cache')
          ? Hive.box('cancellation_cache')
          : await Hive.openBox('cancellation_cache');
    } catch (hiveError) {
      debugPrint('FlutterFlow: Hive box error: $hiveError');
      // Continue without cache if Hive fails
    }

    // Check cache (no expiry needed since cancellations are permanent)
    if (cancellationBox != null) {
      try {
        final cachedData = cancellationBox.get(cacheKey);
        if (cachedData != null && cachedData is bool) {
          debugPrint(
              'FlutterFlow: Returning cached cancellation result: $cachedData');
          return cachedData;
        }
      } catch (cacheError) {
        debugPrint('FlutterFlow: Cache read error: $cacheError');
        // Continue to database query if cache fails
      }
    }

    bool isCancelled = false;

    try {
      // Firestore query for custom classes with null checks
      final querySnapshot = await userDocRef
          .collection('customClasses')
          .where('courseID', isEqualTo: courseID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docData = querySnapshot.docs.first.data();
        if (docData != null) {
          final cancelledClasses =
              docData['cancelledClasses'] as List<dynamic>?;

          if (cancelledClasses != null && cancelledClasses.isNotEmpty) {
            final targetTime = classStartTime.millisecondsSinceEpoch;
            isCancelled = cancelledClasses.any((timestamp) {
              if (timestamp is Timestamp) {
                return (timestamp.toDate().millisecondsSinceEpoch - targetTime)
                        .abs() <
                    60000; // 1 minute tolerance
              }
              return false;
            });
          }
        }
      }
    } catch (firestoreError) {
      debugPrint('FlutterFlow: Firestore query error: $firestoreError');
      // Return false if Firestore query fails
    }

    // Cache result permanently (only if box is available)
    if (cancellationBox != null) {
      try {
        await cancellationBox.put(cacheKey, isCancelled);
      } catch (cacheWriteError) {
        debugPrint('FlutterFlow: Cache write error: $cacheWriteError');
        // Continue even if caching fails
      }
    }

    debugPrint('FlutterFlow: Cancellation check result: $isCancelled');
    return isCancelled;
  } catch (e) {
    debugPrint('FlutterFlow: Error checking cancellation: $e');
    return false;
  }
}
