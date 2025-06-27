import '/backend/supabase/supabase.dart';
import '/components/assignment_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'tasks_widget.dart' show TasksWidget;
import 'package:flutter/material.dart';

class TasksModel extends FlutterFlowModel<TasksWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for MainBar widget.
  TabController? mainBarController;
  int get mainBarCurrentIndex =>
      mainBarController != null ? mainBarController!.index : 0;
  int get mainBarPreviousIndex =>
      mainBarController != null ? mainBarController!.previousIndex : 0;

  Completer<List<TaskRecordsRow>>? requestCompleter2;
  // Models for assignmentBlock dynamic component.
  late FlutterFlowDynamicModels<AssignmentBlockModel> assignmentBlockModels1;
  Completer<List<TaskRecordsRow>>? requestCompleter1;
  // Models for assignmentBlock dynamic component.
  late FlutterFlowDynamicModels<AssignmentBlockModel> assignmentBlockModels2;

  @override
  void initState(BuildContext context) {
    assignmentBlockModels1 =
        FlutterFlowDynamicModels(() => AssignmentBlockModel());
    assignmentBlockModels2 =
        FlutterFlowDynamicModels(() => AssignmentBlockModel());
  }

  @override
  void dispose() {
    mainBarController?.dispose();
    assignmentBlockModels1.dispose();
    assignmentBlockModels2.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
