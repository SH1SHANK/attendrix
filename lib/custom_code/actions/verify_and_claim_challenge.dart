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

Future<int> verifyAndClaimChallenge(String progressID) async {
  try {
    // Call the RPC function using Supabase client
    final response = await SupaFlow.client.rpc(
      'complete_challenge_and_award',
      params: {
        'progress_id': progressID,
      },
    );

    // Check if the response is successful and contains data
    if (response != null) {
      // The RPC function returns an integer (amplixReward)
      int amplixReward = response as int;

      print('Challenge claimed successfully! Amplix reward: $amplixReward');
      return amplixReward;
    } else {
      print('Error: No response from RPC function');
      throw Exception('Failed to claim challenge reward: No response');
    }
  } catch (e) {
    // Handle errors (challenge not completed, already claimed, etc.)
    print('Error claiming challenge: $e');

    // Re-throw the exception so the UI can handle it appropriately
    throw Exception('Failed to claim challenge reward: ${e.toString()}');
  }
}
