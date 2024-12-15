import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'assignments_widget.dart' show AssignmentsWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class AssignmentsModel extends FlutterFlowModel<AssignmentsWidget> {
  ///  State fields for stateful widgets in this page.

  Completer<List<AssignmentsRecord>>? firestoreRequestCompleter;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForFirestoreRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = firestoreRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
