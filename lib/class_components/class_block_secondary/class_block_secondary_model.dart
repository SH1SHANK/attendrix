import '/flutter_flow/flutter_flow_util.dart';
import 'class_block_secondary_widget.dart' show ClassBlockSecondaryWidget;
import 'package:flutter/material.dart';

class ClassBlockSecondaryModel
    extends FlutterFlowModel<ClassBlockSecondaryWidget> {
  ///  Local state fields for this component.

  bool attendanceMarked = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - checkClassAttendance] action in classBlock_secondary widget.
  bool? isAttended;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Custom Action - checkInToCustomClasses] action in Checkbox widget.
  String? checkInStatus;
  // Stores action output result for [Custom Action - removeCustomClassAttendance] action in Checkbox widget.
  String? removeAttendanceFeedback;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
