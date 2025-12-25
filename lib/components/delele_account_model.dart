import '/flutter_flow/flutter_flow_util.dart';
import 'delele_account_widget.dart' show DeleleAccountWidget;
import 'package:flutter/material.dart';

class DeleleAccountModel extends FlutterFlowModel<DeleleAccountWidget> {
  ///  Local state fields for this component.

  bool mismatch = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
