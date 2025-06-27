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
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> setupOneSignalUser() async {
  try {
    // Get current Firebase user
    final firebase_auth.User? currentUser =
        firebase_auth.FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('No authenticated user found');
      return;
    }

    // Get user document from Firestore
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (!userDoc.exists) {
      print('User document not found in Firestore');
      return;
    }

    // Extract user data
    final Map<String, dynamic> userData =
        userDoc.data() as Map<String, dynamic>;
    final String email = currentUser.email ?? userData['email'] ?? '';
    final String displayName =
        userData['display_name'] ?? userData['displayName'] ?? '';
    final String userId = currentUser.uid;

    // Login user with external user ID
    OneSignal.login(userId);

    // Set email
    if (email.isNotEmpty) {
      OneSignal.User.addEmail(email);
      print('OneSignal email set: $email');
    }

    // Set only display name as tag
    if (displayName.isNotEmpty) {
      Map<String, String> tags = {
        'display_name': displayName,
      };

      // Send tags to OneSignal
      OneSignal.User.addTags(tags);
      print('OneSignal display_name tag sent: $displayName');
    }

    // Set external user ID (this is the Firebase UID)
    OneSignal.User.addAlias('firebase_uid', userId);
    print('OneSignal external user ID set: $userId');

    print('OneSignal user setup completed successfully');
  } catch (e) {
    print('Error setting up OneSignal user: $e');
  }
}

// Helper function to update display name tag only
Future<void> updateOneSignalDisplayName(String displayName) async {
  try {
    Map<String, String> tags = {
      'display_name': displayName,
    };
    OneSignal.User.addTags(tags);
    print('OneSignal display_name tag updated: $displayName');
  } catch (e) {
    print('Error updating OneSignal display_name tag: $e');
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
