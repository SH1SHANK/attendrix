import '/flutter_flow/flutter_flow_util.dart';
import 'class_cancellation_widget.dart' show ClassCancellationWidget;
import 'package:flutter/material.dart';

class ClassCancellationModel extends FlutterFlowModel<ClassCancellationWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
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
