import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'progress_bar_widget.dart' show ProgressBarWidget;
import 'package:flutter/material.dart';

class ProgressBarModel extends FlutterFlowModel<ProgressBarWidget> {
  ///  Local state fields for this component.

  int current = 0;

  ///  State fields for stateful widgets in this component.

  InstantTimer? Timer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    Timer?.cancel();
  }
}
