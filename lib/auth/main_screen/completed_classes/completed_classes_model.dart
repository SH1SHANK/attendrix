import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'completed_classes_widget.dart' show CompletedClassesWidget;
import 'package:flutter/material.dart';

class CompletedClassesModel extends FlutterFlowModel<CompletedClassesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  /// Query cache managers for this widget.

  final _overallClassesManager = StreamRequestManager<List<TimetableRecord>>();
  Stream<List<TimetableRecord>> overallClasses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TimetableRecord>> Function() requestFn,
  }) =>
      _overallClassesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearOverallClassesCache() => _overallClassesManager.clear();
  void clearOverallClassesCacheKey(String? uniqueKey) =>
      _overallClassesManager.clearRequest(uniqueKey);

  final _attendedclassesManager = StreamRequestManager<List<TimetableRecord>>();
  Stream<List<TimetableRecord>> attendedclasses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TimetableRecord>> Function() requestFn,
  }) =>
      _attendedclassesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAttendedclassesCache() => _attendedclassesManager.clear();
  void clearAttendedclassesCacheKey(String? uniqueKey) =>
      _attendedclassesManager.clearRequest(uniqueKey);

  final _missedClassesManager = StreamRequestManager<List<TimetableRecord>>();
  Stream<List<TimetableRecord>> missedClasses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TimetableRecord>> Function() requestFn,
  }) =>
      _missedClassesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMissedClassesCache() => _missedClassesManager.clear();
  void clearMissedClassesCacheKey(String? uniqueKey) =>
      _missedClassesManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();

    /// Dispose query cache managers for this widget.

    clearOverallClassesCache();

    clearAttendedclassesCache();

    clearMissedClassesCache();
  }
}
