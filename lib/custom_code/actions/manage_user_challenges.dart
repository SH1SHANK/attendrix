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
import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<String> manageUserChallenges(
  String userID,
  int weeklyLimit,
  int monthlyLimit,
  String lastChallengeKey, // Current challengeKey from client
  List<ChallengeStruct> currentChallenges, // FlutterFlow ChallengeStruct list
) async {
  // Generate current time-based keys using existing function
  final currentWeeklyKey = generateChallengeKey(true);
  final currentMonthlyKey = generateChallengeKey(false);

  // Extract keys from lastChallengeKey
  final lastWeekKey = lastChallengeKey;
  final lastMonthKey = lastChallengeKey.split('-').first + '-M';

  // Check if updates are needed
  final weeklyOutdated = lastWeekKey != currentWeeklyKey;
  final monthlyOutdated = lastMonthKey != currentMonthlyKey;

  // ZERO READS/WRITES - Return early if no updates needed
  if (!weeklyOutdated && !monthlyOutdated) {
    return 'Challenges already up-to-date.';
  }

  try {
    // Prepare current challenges for Supabase RPC - convert from ChallengeStruct
    final currentChallengesJson = currentChallenges
        .map((challenge) => {
              'progressID': challenge.progressID,
              'challengeID': challenge.challengeID,
              'challengeName': challenge.challengeName,
              'challengeDescription': challenge.challengeDescription,
              'challengeCondition': challenge.challengeCondition,
              'challengeKey': challenge.challengeKey,
            })
        .toList();

    // Call Supabase RPC to generate new challenges
    final response = await Supabase.instance.client.rpc(
      'generate_user_challenges_v2',
      params: {
        'p_user_id': userID,
        'p_current_challenges': currentChallengesJson,
        'p_weekly_amplix_limit': weeklyLimit,
        'p_monthly_amplix_limit': monthlyLimit,
      },
    );

    // Supabase RPC returns the data directly, not in a .data property
    if (response != null && response['status'] == true) {
      final newChallengesRaw = response['challenges'] as List<dynamic>;

      // Convert raw response to ChallengeStruct list
      final List<ChallengeStruct> newChallenges = [];

      for (var challengeData in newChallengesRaw) {
        final progressID = challengeData['progressID']?.toString() ?? '';
        final challengeID = challengeData['challengeID']?.toString() ?? '';
        final challengeKey = challengeData['challengeKey']?.toString() ?? '';

        newChallenges.add(ChallengeStruct(
          progressID: progressID,
          challengeID: challengeID,
          challengeName: challengeData['challengeName']?.toString() ?? '',
          challengeDescription:
              challengeData['challengeDescription']?.toString() ?? '',
          challengeCondition:
              challengeData['challengeCondition']?.toString() ?? '',
          challengeKey: challengeKey,
        ));
      }

      // Merge challenges: keep non-expired ones + add new ones
      final mergedChallenges = [
        ...currentChallenges.where((challenge) =>
            challenge.challengeKey != currentWeeklyKey &&
            challenge.challengeKey != currentMonthlyKey),
        ...newChallenges,
      ];

      // Convert merged challenges back to JSON for Firestore
      final mergedChallengesJson = mergedChallenges
          .map((challenge) => {
                'progressID': challenge.progressID,
                'challengeID': challenge.challengeID,
                'challengeName': challenge.challengeName,
                'challengeDescription': challenge.challengeDescription,
                'challengeCondition': challenge.challengeCondition,
                'challengeKey': challenge.challengeKey,
              })
          .toList();

      // SINGLE WRITE - Update Firestore with new challenges and key
      final firestore = FirebaseFirestore.instance;
      final userDocRef = firestore.collection('users').doc(userID);

      await userDocRef.update({
        'challengesAllotted': mergedChallengesJson,
        'challengeKey': currentWeeklyKey,
        'currentWeekAmplixGained': 0,
      });

      return 'New challenges generated and saved.';
    } else {
      return 'Supabase RPC failed: ${response?['message'] ?? 'Unknown error'}';
    }
  } catch (e) {
    return 'Error during challenge management: $e';
  }
}

// Helper function to generate hashed idempotent key for challenge progress tracking
Future<String> generateIdempotentKey(
    String userID, String challengeID, String challengeType) async {
  final currentTime = getCurrentISTTime();
  final timeKey = challengeType == 'weekly'
      ? generateChallengeKey(true)
      : generateChallengeKey(false);

  final rawKey = '${userID}_${challengeID}_${timeKey}';

  // Hash the idempotent key for security
  final bytes = utf8.encode(rawKey);
  final digest = sha256.convert(bytes);

  return digest.toString();
}

// Helper function to check if challenges need updating (client-side check)
bool shouldUpdateChallenges(String lastChallengeKey) {
  final currentWeeklyKey = generateChallengeKey(true);
  final currentMonthlyKey = generateChallengeKey(false);

  final lastWeekKey = lastChallengeKey;
  final lastMonthKey = lastChallengeKey.split('-').first + '-M';

  return lastWeekKey != currentWeeklyKey || lastMonthKey != currentMonthlyKey;
}

// Additional helper function to get current IST time
DateTime getCurrentISTTime() {
  return DateTime.now().toUtc().add(Duration(hours: 5, minutes: 30));
}
