import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'class_block_primary_widget.dart' show ClassBlockPrimaryWidget;
import 'package:flutter/material.dart';

class ClassBlockPrimaryModel extends FlutterFlowModel<ClassBlockPrimaryWidget> {
  ///  Local state fields for this component.

  bool attendanceMarked = false;

  bool rebuildComponent = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Action Block - CheckInAttendanceProtocal] action in Checkbox widget.
  bool? attendanceFeedback;
  // Stores action output result for [Custom Action - markClassAsAbsent] action in Checkbox widget.
  UserFeedbackStruct? absentFeedback;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
