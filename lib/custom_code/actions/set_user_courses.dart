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

/// Sets courses for a user with robust error handling
Future<String> setUserCourses(
  String userID,
  List<String> courseIDs,
  bool isAdmin,
) async {
  // Basic validation
  if (userID.trim().isEmpty) {
    return 'Error: User ID cannot be empty';
  }

  if (courseIDs.isEmpty) {
    return 'Error: Course IDs cannot be empty';
  }

  try {
    await Supabase.instance.client.rpc(
      'set_user_courses',
      params: {
        'p_user_id': userID.trim(),
        'p_course_ids': courseIDs.where((id) => id.trim().isNotEmpty).toList(),
        'p_is_admin': isAdmin,
      },
    );

    return 'Success';
  } on PostgrestException catch (e) {
    return 'Database error: ${e.message}';
  } on AuthException catch (e) {
    return 'Auth error: ${e.message}';
  } catch (e) {
    return 'Error: ${e.toString()}';
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
