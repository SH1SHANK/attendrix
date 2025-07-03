import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'sgpa_grade_card_widget.dart' show SgpaGradeCardWidget;
import 'package:flutter/material.dart';

class SgpaGradeCardModel extends FlutterFlowModel<SgpaGradeCardWidget> {
  ///  Local state fields for this component.

  int credits = 3;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in sgpaGradeCard widget.
  List<CourseRecordsRow>? courseRecord;
  // State field(s) for DropDown widget.
  int? dropDownValue;
  FormFieldController<int>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
