import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  Local state fields for this page.

  DateTime? selectedDay;

  bool daySelected = false;

  String? selectedDate;

  ///  State fields for stateful widgets in this page.

  // State field(s) for CheckboxListTile widget.
  Map<TimetableRecord, bool> checkboxListTileValueMap = {};
  List<TimetableRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  /// Query cache managers for this widget.

  final _checkinClassManager = StreamRequestManager<List<TimetableRecord>>();
  Stream<List<TimetableRecord>> checkinClass({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TimetableRecord>> Function() requestFn,
  }) =>
      _checkinClassManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCheckinClassCache() => _checkinClassManager.clear();
  void clearCheckinClassCacheKey(String? uniqueKey) =>
      _checkinClassManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearCheckinClassCache();
  }
}
