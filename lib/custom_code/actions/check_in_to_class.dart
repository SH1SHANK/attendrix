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

/// Check-in to a class with robust error handling and engaging user feedback
Future<UserFeedbackStruct> checkInToClass(
  String userId, // userId as input
  String classId,
  List<String>? enrolledCourses,
  DateTime classStartTime,
  String courseID,
) async {
  const String logPrefix = '[CheckIn]';

  try {
    if (userId.trim().isEmpty) {
      debugPrint('$logPrefix User ID is empty');
      return _createErrorFeedback('Please sign in to check into class 🔐');
    }

    final validationError = _validateInputs(classId, classStartTime);
    if (validationError != null) {
      debugPrint('$logPrefix Input validation failed: $validationError');
      return _createErrorFeedback(validationError);
    }

    final safeCourses = enrolledCourses ?? <String>[];

    final response = await _performCheckInRPC(
      userId: userId,
      classId: classId,
      enrolledCourses: safeCourses,
      classStart: classStartTime,
    );

    final result = await _processCheckInResponse(response, userId);

    return result;
  } on TimeoutException catch (e) {
    debugPrint('$logPrefix Timeout: $e');
    return _createErrorFeedback(
        'Connection timeout. Check your internet and try again 🌐');
  } on FormatException catch (e) {
    debugPrint('$logPrefix Format error: $e');
    return _createErrorFeedback(
        'Data format error. Please refresh and try again 🔄');
  } on FirebaseAuthException catch (e) {
    debugPrint('$logPrefix Auth error: ${e.code} - ${e.message}');
    return _createErrorFeedback(
        'Authentication issue. Please sign in again 🔐');
  } on Exception catch (e) {
    debugPrint('$logPrefix Exception: $e');
    return _createErrorFeedback(
        'Something unexpected happened. Give it another shot! 🎯');
  } catch (e, stackTrace) {
    debugPrint('$logPrefix Unexpected error: $e');
    debugPrint('$logPrefix Stack trace: $stackTrace');
    return _createErrorFeedback(
        'Oops! Our servers hiccupped. Try again in a moment ⚡');
  }
}

/// Updated validation to accept classId + classStartTime
String? _validateInputs(String classId, DateTime classStartTime) {
  if (classId.trim().isEmpty) {
    return 'Invalid class ID. Contact support if this persists 🆘';
  }

  final now = DateTime.now();
  final earliestCheckIn = classStartTime.subtract(const Duration(minutes: 15));

  if (now.isBefore(earliestCheckIn)) {
    final timeUntilCheckIn = earliestCheckIn.difference(now);
    final minutes = timeUntilCheckIn.inMinutes;
    final seconds = timeUntilCheckIn.inSeconds % 60;

    if (minutes > 0) {
      return '⏰ Too early! Check-in opens in ${minutes}min ${seconds}s ⏳';
    } else {
      return '⏰ Almost there! Check-in opens in ${seconds} seconds ⏳';
    }
  }

  return null;
}

/// Perform the Supabase RPC call with proper error handling
Future<Map<String, dynamic>> _performCheckInRPC({
  required String userId,
  required String classId,
  required List<String> enrolledCourses,
  DateTime? classStart,
}) async {
  try {
    final response =
        await Supabase.instance.client.rpc('class_check_in', params: {
      'p_user_id': userId,
      'p_class_id': classId,
      'p_enrolled_courses': enrolledCourses,
      if (classStart != null) 'p_class_start': classStart.toIso8601String(),
    }).timeout(const Duration(seconds: 15));

    if (response == null) {
      throw const FormatException('Empty response from server');
    }

    // Ensure response is a Map
    if (response is! Map<String, dynamic>) {
      throw FormatException('Invalid response format: ${response.runtimeType}');
    }

    return response;
  } on PostgrestException catch (e) {
    debugPrint('[CheckIn] Supabase error: ${e.code} - ${e.message}');
    throw Exception('Database error: ${e.message}');
  }
}

/// Process the check-in response and update user data
Future<UserFeedbackStruct> _processCheckInResponse(
  Map<String, dynamic> response,
  String userId,
) async {
  final status = response['status'] as String?;
  final message = response['message'] as String?;

  // Extract new attendance data
  final attendedClasses = (response['attended_classes'] as num?)?.toInt() ?? 0;
  final totalClasses = (response['total_classes'] as num?)?.toInt() ?? 0;
  final attendedClassIds = (response['attended_class_ids'] as List<dynamic>?)
          ?.map((id) => id.toString())
          .toList() ??
      <String>[];

  debugPrint(
      '[CheckIn] Attendance stats - Attended: $attendedClasses, Total: $totalClasses');
  debugPrint('[CheckIn] Attended class IDs: $attendedClassIds');

  if (status != 'success') {
    final errorMsg = message ?? 'Check-in failed for unknown reason';
    debugPrint('[CheckIn] Server error: $errorMsg');
    return _createErrorFeedback(
      _getEngagingErrorMessage(message),
      attendedClasses: attendedClasses,
      totalClasses: totalClasses,
      attendedClassIds: attendedClassIds,
    );
  }

  final amplixGained = (response['amplix_gained'] as num?)?.toInt() ?? 0;
  final fullDay = response['full_day_completed'] as bool? ?? false;

  // 💰 Update user's Amplix if gained
  if (amplixGained > 0) {
    await _updateUserAmplix(userId, amplixGained);
  }

  // 🎉 Generate engaging success message with attendance stats
  final successMessage = _generateSuccessMessage(
    amplixGained: amplixGained,
    fullDay: fullDay,
    attendedClasses: attendedClasses,
    totalClasses: totalClasses,
  );

  return UserFeedbackStruct(
    status: 'success',
    message: successMessage,
    amplixDiff: amplixGained,
    fullDayAttendance: fullDay,
    attendedClasses: attendedClasses,
    totalClasses: totalClasses,
    attendedClassIds: attendedClassIds,
  );
}

/// Update user's Amplix in Firestore
Future<void> _updateUserAmplix(String userId, int amplixGained) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'amplix': FieldValue.increment(amplixGained)});
    debugPrint('[CheckIn] Successfully updated Amplix by $amplixGained');
  } catch (e) {
    debugPrint('[CheckIn] Failed to update Amplix: $e');
    // Don't throw here - the check-in was successful, Amplix update is secondary
  }
}

/// Generate engaging success messages with variety and attendance stats
String _generateSuccessMessage({
  required int amplixGained,
  required bool fullDay,
  required int attendedClasses,
  required int totalClasses,
}) {
  final random = math.Random();
  List<String> messageParts = [];

  if (amplixGained > 0) {
    // 15 variants for Amplix gain messages
    final amplixMessages = [
      "🎯 Bullseye! +$amplixGained Amplix secured!",
      "⚡ Power move! +$amplixGained Amplix charged up!",
      "🚀 Blast off! +$amplixGained Amplix in the bag!",
      "💎 Gem collected! +$amplixGained Amplix earned!",
      "🎪 Show time! +$amplixGained Amplix for the win!",
      "🏆 Champion move! +$amplixGained Amplix gained!",
      "🎨 Masterpiece! +$amplixGained Amplix crafted!",
      "🎲 Lucky roll! +$amplixGained Amplix scored!",
      "🌟 Star player! +$amplixGained Amplix shining!",
      "🎯 Perfect shot! +$amplixGained Amplix locked in!",
      "🔥 On fire! +$amplixGained Amplix blazing!",
      "⭐ Stellar work! +$amplixGained Amplix achieved!",
      "🏅 Medal worthy! +$amplixGained Amplix earned!",
      "🎊 Party time! +$amplixGained Amplix celebrated!",
      "💫 Magic moment! +$amplixGained Amplix materialized!"
    ];
    messageParts.add(amplixMessages[random.nextInt(amplixMessages.length)]);
  } else {
    // 10 variants for already checked in messages
    final alreadyMessages = [
      "✅ All set! You've already checked into this class.",
      "📋 Already marked! Your attendance has been recorded.",
      "🎯 You're in! This class is already checked in.",
      "📝 No worries! You've already been marked present.",
      "🔒 Attendance secured! You're good to go.",
      "⚡ Heads-up! You've already checked in for this session.",
      "🎟️ Already registered! You're counted in.",
      "🌟 Present and shining! No need to check in again.",
      "🖼️ Already captured! This class is on your record.",
      "🏆 Nice! You've already secured attendance for this class."
    ];
    messageParts.add(alreadyMessages[random.nextInt(alreadyMessages.length)]);
  }

  // Add attendance progress message
  if (totalClasses > 0) {
    final progressMessages = [
      "📊 Progress: $attendedClasses/$totalClasses classes today",
      "📈 Daily streak: $attendedClasses/$totalClasses completed",
      "🎯 Target: $attendedClasses of $totalClasses classes done",
      "📋 Today's score: $attendedClasses/$totalClasses attended",
      "🌟 Class count: $attendedClasses/$totalClasses checked in",
    ];
    messageParts.add(progressMessages[random.nextInt(progressMessages.length)]);
  }

  // Bonus message for full day completion
  if (fullDay) {
    final fullDayMessages = [
      "🌞 Full day conquered!",
      "🎯 Complete domination today!",
      "🏆 Today's champion!",
      "⭐ Daily mission completed!",
      "🔥 Full attendance unlocked!",
      "💪 Today's attendance beast!",
      "🎊 Perfect day achieved!",
      "🌟 Daily star earned!",
      "🎨 Masterful day completed!",
      "⚡ Full power day!"
    ];
    messageParts.add(fullDayMessages[random.nextInt(fullDayMessages.length)]);
  }

  return messageParts.join(' ');
}

/// Generate engaging error messages
String _getEngagingErrorMessage(String? serverMessage) {
  if (serverMessage?.toLowerCase().contains('already') == true) {
    return "📋 You're already checked in!";
  }

  if (serverMessage?.toLowerCase().contains('not enrolled') == true) {
    return "🎯 Oops! You're not enrolled in this class. Check your schedule! 📅";
  }

  if (serverMessage?.toLowerCase().contains('too early') == true) {
    return "⏰ Hold up! Check-in window hasn't opened yet. Come back soon! ⏳";
  }

  if (serverMessage?.toLowerCase().contains('too late') == true) {
    return "⏰ Missed the window! Better luck next time, champ! 🎯";
  }

  // Default engaging error messages
  final errorMessages = [
    "🎭 Plot twist! Something went sideways. Try again! 🔄",
    "🎪 Technical difficulties! Give it another shot! ⚡",
    "🎲 Bad roll! Reload and try your luck again! 🎯",
    "🎨 Oops! Our canvas needs a refresh. Try again! 🖌️",
    "🚀 Houston, we have a problem! Retry mission! 🛸"
  ];

  final random = math.Random();
  return errorMessages[random.nextInt(errorMessages.length)];
}

/// Create standardized error feedback with attendance data
UserFeedbackStruct _createErrorFeedback(
  String message, {
  int attendedClasses = 0,
  int totalClasses = 0,
  List<String> attendedClassIds = const [],
}) {
  return UserFeedbackStruct(
    status: 'error',
    message: message,
    amplixDiff: 0,
    fullDayAttendance: false,
    attendedClasses: attendedClasses,
    totalClasses: totalClasses,
    attendedClassIds: attendedClassIds,
  );
}
