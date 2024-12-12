import '/flutter_flow/flutter_flow_util.dart';
import 'class_reschedule_widget.dart' show ClassRescheduleWidget;
import 'package:flutter/material.dart';

class ClassRescheduleModel extends FlutterFlowModel<ClassRescheduleWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  DateTime? datePicked;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
