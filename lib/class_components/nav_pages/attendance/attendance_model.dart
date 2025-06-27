import '/class_components/course_attendance/course_attendance_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'attendance_widget.dart' show AttendanceWidget;
import 'package:flutter/material.dart';

class AttendanceModel extends FlutterFlowModel<AttendanceWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for courseAttendance dynamic component.
  late FlutterFlowDynamicModels<CourseAttendanceModel> courseAttendanceModels;

  @override
  void initState(BuildContext context) {
    courseAttendanceModels =
        FlutterFlowDynamicModels(() => CourseAttendanceModel());
  }

  @override
  void dispose() {
    courseAttendanceModels.dispose();
  }
}
