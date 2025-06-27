import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_existing_class_widget.dart' show EditExistingClassWidget;
import 'package:flutter/material.dart';

class EditExistingClassModel extends FlutterFlowModel<EditExistingClassWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TimetableRecordsRow>? updatedTimetableData;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TimetableRecordsRow>? plusSlotFeedback;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TimetableRecordsRow>? updatedTimetableDataEndTime;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
