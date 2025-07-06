import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future universalErrorSnackbar(
  BuildContext context, {
  required String? errorMessage,
}) async {
  logFirebaseEvent('UniversalErrorSnackbar_show_snack_bar');
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        errorMessage!,
        style: GoogleFonts.outfit(
          color: FlutterFlowTheme.of(context).info,
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.start,
      ),
      duration: Duration(milliseconds: 2000),
      backgroundColor: FlutterFlowTheme.of(context).error,
    ),
  );
}

Future userDataAuthenticityCheck(BuildContext context) async {
  if (!((valueOrDefault(currentUserDocument?.username, '') != '') &&
      ((currentUserDocument?.coursesEnrolled.toList() ?? []).length >= 6) &&
      ((valueOrDefault(currentUserDocument?.semesterID, '') != '') &&
          (valueOrDefault(currentUserDocument?.batchID, '') != '')))) {
    logFirebaseEvent('userDataAuthenticityCheck_navigate_to');

    context.goNamed(OnboardingWidget.routeName);
  }
}

Future<String?> checkInAttendanceProtocal(
  BuildContext context, {
  required String? classID,
  required String? courseID,
  required DateTime? classStartTime,
}) async {
  UserFeedbackStruct? userFeedbackForAttendance;
  ChallengeFeedbackStruct? challengeFeedback;

  logFirebaseEvent('CheckInAttendanceProtocal_custom_action');
  userFeedbackForAttendance = await actions.checkInToClass(
    currentUserUid,
    classID!,
    (currentUserDocument?.coursesEnrolled.toList() ?? [])
        .map((e) => e.courseID)
        .toList()
        .toList(),
    classStartTime!,
    courseID!,
  );
  logFirebaseEvent('CheckInAttendanceProtocal_custom_action');
  await actions.updateAttendanceForCourse(
    (currentUserDocument?.coursesEnrolled.toList() ?? [])
        .where((e) => e.courseID == courseID)
        .toList()
        .firstOrNull!,
    currentUserReference!,
  );
  logFirebaseEvent('CheckInAttendanceProtocal_custom_action');
  await actions.manageUserStreaks(
    currentUserUid,
    userFeedbackForAttendance.fullDayAttendance,
    classStartTime,
  );
  logFirebaseEvent('CheckInAttendanceProtocal_custom_action');
  challengeFeedback = await actions.evaluateAndUpdateChallenges(
    currentUserUid,
    (currentUserDocument?.challengesAllotted.toList() ?? [])
        .map((e) => e.progressID)
        .toList()
        .toList(),
    valueOrDefault(currentUserDocument?.currentStreak, 0),
    (currentUserDocument?.coursesEnrolled.toList() ?? [])
        .map((e) => e.courseID)
        .toList()
        .toList(),
  );
  return userFeedbackForAttendance.message;
}

Future<String?> checkOutAttendanceProtocol(
  BuildContext context, {
  required String? userID,
  required List<String>? enrolledCourses,
  required String? classID,
  required String? courseID,
  required DateTime? classStartTime,
  required DateTime? classEndTime,
  required String? courseName,
}) async {
  UserFeedbackStruct? checkOutUserFeedback;

  logFirebaseEvent('CheckOutAttendanceProtocol_custom_action');
  checkOutUserFeedback = await actions.markClassAsAbsent(
    classID!,
    enrolledCourses!.toList(),
  );
  logFirebaseEvent('CheckOutAttendanceProtocol_custom_action');
  await actions.manageUserStreaks(
    currentUserUid,
    checkOutUserFeedback.fullDayAttendance,
    classStartTime,
  );
  logFirebaseEvent('CheckOutAttendanceProtocol_custom_action');
  await actions.evaluateAndUpdateChallenges(
    currentUserUid,
    (currentUserDocument?.challengesAllotted.toList() ?? [])
        .map((e) => e.progressID)
        .toList()
        .toList(),
    valueOrDefault(currentUserDocument?.currentStreak, 0),
    (currentUserDocument?.coursesEnrolled.toList() ?? [])
        .map((e) => e.courseID)
        .toList()
        .toList(),
  );
  return checkOutUserFeedback.message;
}
