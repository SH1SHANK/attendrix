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

import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async'; // Add this import for TimeoutException

Future<ChallengeFeedbackStruct> evaluateAndUpdateChallenges(
  String? userId,
  List<String> progressIds,
  int? currentStreak,
  List<String>? courseIds,
) async {
  // Input validation
  if (userId?.isEmpty ?? true) {
    return ChallengeFeedbackStruct(
      status: false,
      message: 'Invalid user ID',
      claimableChallengesCount: 0,
    );
  }

  if (progressIds.isEmpty) {
    return ChallengeFeedbackStruct(
      status: false,
      message: 'No progress data provided',
      claimableChallengesCount: 0,
    );
  }

  if (courseIds == null) {
    return ChallengeFeedbackStruct(
      status: false,
      message: 'Course IDs required',
      claimableChallengesCount: 0,
    );
  }

  try {
    // Prepare RPC parameters
    final Map<String, dynamic> rpcParams = {
      'p_progress_ids': progressIds,
      'p_user_id': userId!,
      'p_current_streak': currentStreak ?? 0,
      if (courseIds.isNotEmpty) 'p_course_ids': courseIds,
    };

    // Execute RPC call with timeout
    final response = await Supabase.instance.client
        .rpc('evaluate_user_challenges', params: rpcParams)
        .timeout(const Duration(seconds: 10));

    // Process response
    final data =
        response is List && response.isNotEmpty ? response.first : response;

    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response format from database');
    }

    // Extract response data with type safety
    final bool status = data['status'] as bool? ?? false;
    final String message = data['message'] as String? ?? 'Operation completed';
    final int claimableCount = data['claimable_challenges_count'] as int? ?? 0;

    return ChallengeFeedbackStruct(
      status: status,
      message: message,
      claimableChallengesCount: claimableCount,
    );
  } on TimeoutException {
    // Handle timeout errors (most specific first)
    return ChallengeFeedbackStruct(
      status: false,
      message: 'Request timeout - please try again',
      claimableChallengesCount: 0,
    );
  } on PostgrestException catch (e) {
    // Handle Supabase/PostgreSQL specific errors
    return ChallengeFeedbackStruct(
      status: false,
      message: 'Database error: ${e.message}',
      claimableChallengesCount: 0,
    );
  } on FormatException catch (e) {
    // Handle data format errors
    return ChallengeFeedbackStruct(
      status: false,
      message: 'Data format error: ${e.message}',
      claimableChallengesCount: 0,
    );
  } catch (e) {
    // Handle all other exceptions (most general last)
    return ChallengeFeedbackStruct(
      status: false,
      message: 'Failed to evaluate challenges: ${e.toString()}',
      claimableChallengesCount: 0,
    );
  }
}
