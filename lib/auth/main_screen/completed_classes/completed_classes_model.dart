import '/flutter_flow/flutter_flow_util.dart';
import 'completed_classes_widget.dart' show CompletedClassesWidget;
import 'package:flutter/material.dart';

class CompletedClassesModel extends FlutterFlowModel<CompletedClassesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
