import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'attendance_calculator_widget.dart' show AttendanceCalculatorWidget;
import 'package:flutter/material.dart';

class AttendanceCalculatorModel
    extends FlutterFlowModel<AttendanceCalculatorWidget> {
  ///  Local state fields for this component.

  AttendanceCalculationStruct? attend;
  void updateAttendStruct(Function(AttendanceCalculationStruct) updateFn) {
    updateFn(attend ??= AttendanceCalculationStruct());
  }

  AttendanceCalculationStruct? skip;
  void updateSkipStruct(Function(AttendanceCalculationStruct) updateFn) {
    updateFn(skip ??= AttendanceCalculationStruct());
  }

  AttendanceCalculationStruct? skipandAttend;
  void updateSkipandAttendStruct(
      Function(AttendanceCalculationStruct) updateFn) {
    updateFn(skipandAttend ??= AttendanceCalculationStruct());
  }

  AttendanceCalculationStruct? custom;
  void updateCustomStruct(Function(AttendanceCalculationStruct) updateFn) {
    updateFn(custom ??= AttendanceCalculationStruct());
  }

  int tabIndex = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for skip widget.
  int? skipValue;
  // State field(s) for attendCounter2 widget.
  int? attendCounter2Value;
  // State field(s) for skipCounter1 widget.
  int? skipCounter1Value;
  // State field(s) for attendCounter1 widget.
  int? attendCounter1Value;
  // State field(s) for attendedClasses widget.
  int? attendedClassesValue;
  // State field(s) for totalClasses widget.
  int? totalClassesValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
