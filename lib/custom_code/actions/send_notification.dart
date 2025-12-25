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
import 'dart:convert';
import 'package:http/http.dart' as http;

// Custom Action: Send OneSignal Notification
Future<bool> sendNotification(
  String title,
  String description,
  String? subtitle,
  String? imageUrl,
  String? deepLinkUrl,
  bool sendImmediately,
  DateTime? scheduledTime,
  String restApiKey,
) async {
  try {
    // Validate scheduling parameters
    if (!sendImmediately && scheduledTime == null) {
      print('Error: scheduledTime is required when sendImmediately is false');
      return false;
    }

    if (!sendImmediately &&
        scheduledTime != null &&
        scheduledTime.isBefore(DateTime.now())) {
      print('Error: scheduledTime cannot be in the past');
      return false;
    }
    // Prepare notification data
    Map<String, dynamic> notificationData = {
      "app_id": "f68de5e2-0441-44f5-b8c2-f2d91e0f0159",
      "included_segments": ["All"],
      "headings": {"en": title},
      "contents": {"en": description},
    };

    // Add optional parameters
    if (subtitle != null) {
      notificationData["subtitle"] = {"en": subtitle};
    }

    if (imageUrl != null) {
      notificationData["big_picture"] = imageUrl;
      notificationData["large_icon"] = imageUrl;
      notificationData["ios_attachments"] = {"id": imageUrl};
      notificationData["chrome_web_image"] = imageUrl;
    }

    if (deepLinkUrl != null) {
      notificationData["url"] = deepLinkUrl;
    }

    // Handle scheduling
    if (!sendImmediately && scheduledTime != null) {
      notificationData["send_after"] = scheduledTime.toUtc().toIso8601String();
    }

    // Send notification using REST API
    final response = await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $restApiKey',
      },
      body: json.encode(notificationData),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (sendImmediately) {
        print('Notification sent successfully!');
      } else {
        print('Notification scheduled successfully for: $scheduledTime');
      }
      print('Notification ID: ${responseData['id']}');
      print('Recipients: ${responseData['recipients']}');
      return true;
    } else {
      print('Failed to send notification');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Exception occurred while sending notification: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
