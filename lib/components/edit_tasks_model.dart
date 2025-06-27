import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_tasks_widget.dart' show EditTasksWidget;
import 'package:flutter/material.dart';

class EditTasksModel extends FlutterFlowModel<EditTasksWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode1;
  TextEditingController? nameTextController1;
  String? Function(BuildContext, String?)? nameTextController1Validator;
  String? _nameTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for name widget.
  FocusNode? nameFocusNode2;
  TextEditingController? nameTextController2;
  String? Function(BuildContext, String?)? nameTextController2Validator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TaskRecordsRow>? assignmentFeedback;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TaskRecordsRow>? examFeedback;

  @override
  void initState(BuildContext context) {
    nameTextController1Validator = _nameTextController1Validator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode1?.dispose();
    nameTextController1?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    nameFocusNode2?.dispose();
    nameTextController2?.dispose();
  }
}
