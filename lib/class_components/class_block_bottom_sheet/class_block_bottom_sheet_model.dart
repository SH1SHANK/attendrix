import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'class_block_bottom_sheet_widget.dart' show ClassBlockBottomSheetWidget;
import 'package:flutter/material.dart';

class ClassBlockBottomSheetModel
    extends FlutterFlowModel<ClassBlockBottomSheetWidget> {
  /// Query cache managers for this widget.

  final _courseQueryManager = FutureRequestManager<List<CourseRecordsRow>>();
  Future<List<CourseRecordsRow>> courseQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CourseRecordsRow>> Function() requestFn,
  }) =>
      _courseQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCourseQueryCache() => _courseQueryManager.clear();
  void clearCourseQueryCacheKey(String? uniqueKey) =>
      _courseQueryManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearCourseQueryCache();
  }
}
