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

import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<bool> verifyAdminCode(
  String userID,
  String adminCode,
) async {
  final supabase = Supabase.instance.client;

  try {
    final res = await supabase.functions.invoke(
      'verify_admin_code', // Name of the Edge Function
      body: {
        'userID': userID,
        'adminCode': adminCode,
      },
    );

    // Check the response status and data to determine success
    if (res.status == 200 && res.data != null) {
      // Assuming the function returns a success indicator
      return res.data['success'] ?? false;
    }

    return false;
  } catch (e) {
    // Log the error for debugging
    print('Error verifying admin code: $e');
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
