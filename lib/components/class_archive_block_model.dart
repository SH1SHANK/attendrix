import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'class_archive_block_widget.dart' show ClassArchiveBlockWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ClassArchiveBlockModel extends FlutterFlowModel<ClassArchiveBlockWidget> {
  ///  Local state fields for this component.

  bool isExpanded = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<TimetableRecordsRow>? timetableRecord;
  // Stores action output result for [Custom Action - fileViewer] action in Button widget.
  String? fileFeedback;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();
  }
}
