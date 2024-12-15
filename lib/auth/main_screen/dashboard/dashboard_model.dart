import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  Local state fields for this page.

  bool? daySelected = false;

  String? selectedDay;

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for upcomingClassesList widget.
  ScrollController? upcomingClassesList;
  // State field(s) for checkInclassesList widget.
  ScrollController? checkInclassesList;
  // State field(s) for CheckboxListTile widget.
  Map<TimetableRecord, bool> checkboxListTileValueMap = {};
  List<TimetableRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for dayPickerRow widget.
  ScrollController? dayPickerRow;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<TimetableRecord>? dayclassDetails;
  // State field(s) for overallAttendanceList widget.
  ScrollController? overallAttendanceList;

  /// Query cache managers for this widget.

  final _attendanceRecordManager =
      StreamRequestManager<List<ClassDetailsRecord>>();
  Stream<List<ClassDetailsRecord>> attendanceRecord({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ClassDetailsRecord>> Function() requestFn,
  }) =>
      _attendanceRecordManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAttendanceRecordCache() => _attendanceRecordManager.clear();
  void clearAttendanceRecordCacheKey(String? uniqueKey) =>
      _attendanceRecordManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    upcomingClassesList = ScrollController();
    checkInclassesList = ScrollController();
    dayPickerRow = ScrollController();
    overallAttendanceList = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    upcomingClassesList?.dispose();
    checkInclassesList?.dispose();
    dayPickerRow?.dispose();
    overallAttendanceList?.dispose();

    /// Dispose query cache managers for this widget.

    clearAttendanceRecordCache();
  }
}
