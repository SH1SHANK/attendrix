import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'elective_selection_block_widget.dart' show ElectiveSelectionBlockWidget;
import 'package:flutter/material.dart';

class ElectiveSelectionBlockModel
    extends FlutterFlowModel<ElectiveSelectionBlockWidget> {
  ///  Local state fields for this component.

  String? userChoosenCourseId;

  CourseRecordsRow? courseRecord;

  bool courseChoosen = false;

  bool skipElectiveSelection = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<CourseRecordsRow>? courseRecordRow;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<CourseRecordsRow>? courseRecordRow2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
