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

import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> initializeOneSignal() async {
  try {
    // Replace with your OneSignal App ID
    const String oneSignalAppId = "f68de5e2-0441-44f5-b8c2-f2d91e0f0159";

    // Initialize OneSignal
    OneSignal.initialize(oneSignalAppId);

    // Optional: Request notification permissions
    OneSignal.Notifications.requestPermission(true);

    print('OneSignal initialized successfully');
  } catch (e) {
    print('Error initializing OneSignal: $e');
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
