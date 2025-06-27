import '/flutter_flow/flutter_flow_util.dart';
import 'assignment_block_widget.dart' show AssignmentBlockWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class AssignmentBlockModel extends FlutterFlowModel<AssignmentBlockWidget> {
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
