import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'request_access_follow_up_widget.dart' show RequestAccessFollowUpWidget;
import 'package:flutter/material.dart';

class RequestAccessFollowUpModel
    extends FlutterFlowModel<RequestAccessFollowUpWidget> {
  ///  Local state fields for this page.

  bool invalidPin = false;

  CoursesEnrolledStruct? courseEnrolled;
  void updateCourseEnrolledStruct(Function(CoursesEnrolledStruct) updateFn) {
    updateFn(courseEnrolled ??= CoursesEnrolledStruct());
  }

  List<CoursesEnrolledStruct> coursesEnrolled = [];
  void addToCoursesEnrolled(CoursesEnrolledStruct item) =>
      coursesEnrolled.add(item);
  void removeFromCoursesEnrolled(CoursesEnrolledStruct item) =>
      coursesEnrolled.remove(item);
  void removeAtIndexFromCoursesEnrolled(int index) =>
      coursesEnrolled.removeAt(index);
  void insertAtIndexInCoursesEnrolled(int index, CoursesEnrolledStruct item) =>
      coursesEnrolled.insert(index, item);
  void updateCoursesEnrolledAtIndex(
          int index, Function(CoursesEnrolledStruct) updateFn) =>
      coursesEnrolled[index] = updateFn(coursesEnrolled[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Custom Action - verifyAdminCode] action in Button widget.
  bool? verificationResult;
  // Stores action output result for [Custom Action - markAllCoursesEditable] action in Button widget.
  List<CoursesEnrolledStruct>? editablecourses;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }
}
