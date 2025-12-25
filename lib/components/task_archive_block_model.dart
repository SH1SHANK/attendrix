import '/flutter_flow/flutter_flow_util.dart';
import 'task_archive_block_widget.dart' show TaskArchiveBlockWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class TaskArchiveBlockModel extends FlutterFlowModel<TaskArchiveBlockWidget> {
  ///  Local state fields for this component.

  bool isExpanded = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();
  }
}
