import '/flutter_flow/flutter_flow_util.dart';
import 'newpassword_widget.dart' show NewpasswordWidget;
import 'package:flutter/material.dart';

class NewpasswordModel extends FlutterFlowModel<NewpasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for setnewpassword widget.
  FocusNode? setnewpasswordFocusNode;
  TextEditingController? setnewpasswordTextController;
  late bool setnewpasswordVisibility;
  String? Function(BuildContext, String?)?
      setnewpasswordTextControllerValidator;
  // State field(s) for confirmnewpassword widget.
  FocusNode? confirmnewpasswordFocusNode;
  TextEditingController? confirmnewpasswordTextController;
  late bool confirmnewpasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmnewpasswordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    setnewpasswordVisibility = false;
    confirmnewpasswordVisibility = false;
  }

  @override
  void dispose() {
    setnewpasswordFocusNode?.dispose();
    setnewpasswordTextController?.dispose();

    confirmnewpasswordFocusNode?.dispose();
    confirmnewpasswordTextController?.dispose();
  }
}
