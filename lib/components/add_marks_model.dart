import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_marks_widget.dart' show AddMarksWidget;
import 'package:flutter/material.dart';

class AddMarksModel extends FlutterFlowModel<AddMarksWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for obtained widget.
  FocusNode? obtainedFocusNode;
  TextEditingController? obtainedTextController;
  String? Function(BuildContext, String?)? obtainedTextControllerValidator;
  // State field(s) for total widget.
  FocusNode? totalFocusNode;
  TextEditingController? totalTextController;
  String? Function(BuildContext, String?)? totalTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    obtainedFocusNode?.dispose();
    obtainedTextController?.dispose();

    totalFocusNode?.dispose();
    totalTextController?.dispose();
  }
}
