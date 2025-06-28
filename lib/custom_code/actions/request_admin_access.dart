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

Future<FeedbackStruct> requestAdminAccess(
  String userID,
  String email,
  List<String> courseIds,
) async {
  final supabase = Supabase.instance.client;

  try {
    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'userID': userID,
      'email': email,
      'courseIds': courseIds,
    };

    final res = await supabase.functions.invoke(
      'generate_admin_code',
      body: requestBody,
    );

    final data = res.data;

    return FeedbackStruct(
      status: data['status']?.toString() ?? '',
      message: data['message']?.toString() ?? '',
      error: '',
      details: '',
    );
  } catch (e) {
    return FeedbackStruct(
      status: 'error',
      message: 'Failed to send request.',
      error: 'Request failed',
      details: e.toString(),
    );
  }
}
