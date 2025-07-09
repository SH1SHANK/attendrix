import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'elective_block_widget.dart' show ElectiveBlockWidget;
import 'package:flutter/material.dart';

class ElectiveBlockModel extends FlutterFlowModel<ElectiveBlockWidget> {
  ///  Local state fields for this component.

  bool isElectiveSelected = false;

  bool isElectiveSelectionSkipped = false;

  CourseRecordsRow? selectedElectiveRecord;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
