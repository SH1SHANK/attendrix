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

import 'package:intl/intl.dart'; // ✅ For clean date formatting
import 'dart:convert'; // For JSON parsing

Future runIfStale(
  dynamic currentData,
  Future Function()? makeAPIRequest,
) async {
  final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  try {
    if (currentData == null) {
      if (makeAPIRequest != null) {
        await makeAPIRequest();
      }
      return;
    }

    Map<String, dynamic> jsonData;

    if (currentData is String) {
      jsonData = json.decode(currentData);
    } else if (currentData is Map<String, dynamic>) {
      jsonData = currentData;
    } else {
      if (makeAPIRequest != null) {
        await makeAPIRequest();
      }
      return;
    }

    final String? dataDate = jsonData['date'] as String?;

    if (dataDate == null || dataDate != today) {
      if (makeAPIRequest != null) {
        await makeAPIRequest();
      }
    }
  } catch (e) {
    if (makeAPIRequest != null) {
      await makeAPIRequest();
    }
  }
}
