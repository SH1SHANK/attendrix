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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';

/// Efficiently mark class as absent with minimal network calls
Future<UserFeedbackStruct> markClassAsAbsent(
  String classID,
  List<String> enrolledCourses,
) async {
  try {
    // Quick auth check
    final user = FirebaseAuth.instance.currentUser;
    if (user?.uid == null) {
      return _errorFeedback('Please sign in to continue 🔐');
    }

    // Input validation
    final trimmedClassID = classID.trim();
    if (trimmedClassID.isEmpty) {
      return _errorFeedback('Invalid class ID 📅');
    }

    // Single Supabase call with timeout
    final response =
        await Supabase.instance.client.rpc('mark_class_absent', params: {
      'p_user_id': user!.uid,
      'p_class_id': trimmedClassID,
      'p_enrolled_courses': enrolledCourses,
    }).timeout(const Duration(seconds: 10));

    return _processResponse(response, user.uid);
  } on TimeoutException {
    return _errorFeedback('Connection timeout 🌐');
  } on FirebaseAuthException {
    return _errorFeedback('Please sign in again 🔐');
  } catch (e) {
    debugPrint('[MarkAbsent] Error: $e');
    return _errorFeedback('Something went wrong. Try again! 🔄');
  }
}

/// Process server response and update local data if needed
Future<UserFeedbackStruct> _processResponse(
    dynamic response, String userId) async {
  if (response == null || response is! Map<String, dynamic>) {
    return _errorFeedback('Invalid server response 🔄');
  }

  final status = response['status'] as String?;
  final message = response['message'] as String? ?? '';

  if (status != 'success') {
    return _errorFeedback(_getErrorMessage(message));
  }

  final amplixLost = (response['amplix_lost'] as num?)?.toInt() ?? 0;

  // Update local Firestore only if Amplix was lost
  if (amplixLost > 0) {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'amplix': FieldValue.increment(-amplixLost),
      });
    } catch (e) {
      debugPrint('[MarkAbsent] Firestore update failed: $e');
      // Continue anyway - Supabase operation succeeded
    }
  }

  return UserFeedbackStruct(
    status: 'success',
    message: _getSuccessMessage(amplixLost, message),
    amplixDiff: -amplixLost,
    fullDayAttendance: false,
  );
}

/// Generate engaging success messages with variety
String _getSuccessMessage(int amplixLost, String serverMessage) {
  final random = math.Random();

  if (amplixLost > 0) {
    final amplixMessages = [
      "📝 Marked absent! Lost $amplixLost Amplix 💔",
      "✅ Absence recorded! -$amplixLost Amplix deducted 📉",
      "📋 Class marked absent! $amplixLost Amplix lost ⚡",
      "🎯 Done! Lost $amplixLost Amplix for this absence 💸",
      "📌 Attendance removed! -$amplixLost Amplix penalty 🔻"
    ];
    return amplixMessages[random.nextInt(amplixMessages.length)];
  }

  final successMessages = [
    "📝 Class marked as absent!",
    "✅ Absence recorded successfully!",
    "📋 All set! Class marked absent.",
    "🎯 Done! Absence has been noted.",
    "📌 Successfully marked absent!",
    "🎭 Absence logged! You're all set!",
    "⭐ Class absence confirmed!"
  ];
  return successMessages[random.nextInt(successMessages.length)];
}

/// Generate engaging error messages with variety
String _getErrorMessage(String? serverMessage) {
  if (serverMessage == null) return _getRandomErrorMessage();

  final msg = serverMessage.toLowerCase();
  if (msg.contains('not found')) return "🔍 Class not found in the system!";
  if (msg.contains('not enrolled'))
    return "🎯 You're not enrolled in this class! 📅";
  if (msg.contains('no attendance'))
    return "📋 No attendance record found for this class!";
  if (msg.contains('already absent'))
    return "📝 This class is already marked absent!";

  return _getRandomErrorMessage();
}

/// Generate random engaging error messages
String _getRandomErrorMessage() {
  final random = math.Random();
  final errorMessages = [
    "🎭 Something went sideways! Try again! 🔄",
    "🎪 Technical hiccup! Give it another shot! ⚡",
    "🎲 Oops! Refresh and try again! 🎯",
    "🎨 Our servers need a moment! Retry! 🖌️",
    "🚀 Minor glitch! Retry the mission! 🛸",
    "⚡ Quick stumble! Back on track in 3, 2, 1... 🎯",
    "🎊 Plot twist! Try that again! 🔄"
  ];
  return errorMessages[random.nextInt(errorMessages.length)];
}

/// Create error feedback struct
UserFeedbackStruct _errorFeedback(String message) {
  return UserFeedbackStruct(
    status: 'error',
    message: message,
    amplixDiff: 0,
    fullDayAttendance: false,
  );
}
