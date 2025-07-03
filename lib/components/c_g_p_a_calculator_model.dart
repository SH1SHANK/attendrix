import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/sgpa_grade_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'c_g_p_a_calculator_widget.dart' show CGPACalculatorWidget;
import 'package:flutter/material.dart';

class CGPACalculatorModel extends FlutterFlowModel<CGPACalculatorWidget> {
  ///  Local state fields for this component.

  String calculatedSGPA = 'couldn\'t process the data....';

  double sgpaValue = 0.0;

  List<CourseDetailsStruct> enteredGrades = [];
  void addToEnteredGrades(CourseDetailsStruct item) => enteredGrades.add(item);
  void removeFromEnteredGrades(CourseDetailsStruct item) =>
      enteredGrades.remove(item);
  void removeAtIndexFromEnteredGrades(int index) =>
      enteredGrades.removeAt(index);
  void insertAtIndexInEnteredGrades(int index, CourseDetailsStruct item) =>
      enteredGrades.insert(index, item);
  void updateEnteredGradesAtIndex(
          int index, Function(CourseDetailsStruct) updateFn) =>
      enteredGrades[index] = updateFn(enteredGrades[index]);

  ///  State fields for stateful widgets in this component.

  // Models for sgpaGradeCard dynamic component.
  late FlutterFlowDynamicModels<SgpaGradeCardModel> sgpaGradeCardModels;
  // State field(s) for DropDown widget.
  int? dropDownValue1;
  FormFieldController<int>? dropDownValueController1;
  // State field(s) for DropDown widget.
  int? dropDownValue2;
  FormFieldController<int>? dropDownValueController2;
  // Stores action output result for [Custom Action - gradeCalculator] action in Button widget.
  FeedbackStruct? calculatedGrades;

  @override
  void initState(BuildContext context) {
    sgpaGradeCardModels = FlutterFlowDynamicModels(() => SgpaGradeCardModel());
  }

  @override
  void dispose() {
    sgpaGradeCardModels.dispose();
  }
}
