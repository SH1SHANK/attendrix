import '/flutter_flow/flutter_flow_util.dart';
import 'a_p_o_d_previw_component_widget.dart' show APODPreviwComponentWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class APODPreviwComponentModel
    extends FlutterFlowModel<APODPreviwComponentWidget> {
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
