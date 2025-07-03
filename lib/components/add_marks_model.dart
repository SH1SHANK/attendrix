import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_marks_widget.dart' show AddMarksWidget;
import 'package:flutter/material.dart';

class AddMarksModel extends FlutterFlowModel<AddMarksWidget> {
  ///  Local state fields for this component.

  String taskDetails = 'Not Defined';

  Color colorSelected = Color(4294046968);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for examtype widget.
  String? examtypeValue;
  FormFieldController<String>? examtypeValueController;
  // State field(s) for exam widget.
  FormFieldController<List<String>>? examValueController;
  String? get examValue => examValueController?.value?.firstOrNull;
  set examValue(String? val) =>
      examValueController?.value = val != null ? [val] : [];
  // State field(s) for assignmentType widget.
  String? assignmentTypeValue;
  FormFieldController<String>? assignmentTypeValueController;
  // State field(s) for assignment widget.
  FormFieldController<List<String>>? assignmentValueController;
  String? get assignmentValue => assignmentValueController?.value?.firstOrNull;
  set assignmentValue(String? val) =>
      assignmentValueController?.value = val != null ? [val] : [];
  // State field(s) for obtained widget.
  FocusNode? obtainedFocusNode;
  TextEditingController? obtainedTextController;
  String? Function(BuildContext, String?)? obtainedTextControllerValidator;
  // State field(s) for total widget.
  FocusNode? totalFocusNode;
  TextEditingController? totalTextController;
  String? Function(BuildContext, String?)? totalTextControllerValidator;
  Color? colorPicked;

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
