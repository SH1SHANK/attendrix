import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/class_components/class_block_primary/class_block_primary_widget.dart';
import '/class_components/class_block_secondary/class_block_secondary_widget.dart';
import '/class_components/class_block_upcoming/class_block_upcoming_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  Local state fields for this page.

  List<ClassRowStruct> customClassesList = [];
  void addToCustomClassesList(ClassRowStruct item) =>
      customClassesList.add(item);
  void removeFromCustomClassesList(ClassRowStruct item) =>
      customClassesList.remove(item);
  void removeAtIndexFromCustomClassesList(int index) =>
      customClassesList.removeAt(index);
  void insertAtIndexInCustomClassesList(int index, ClassRowStruct item) =>
      customClassesList.insert(index, item);
  void updateCustomClassesListAtIndex(
          int index, Function(ClassRowStruct) updateFn) =>
      customClassesList[index] = updateFn(customClassesList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - generateGreetingMessage] action in dashboard widget.
  UserGreetingMessageStruct? greetingMessage;
  // Stores action output result for [Custom Action - fetchCustomClasses] action in dashboard widget.
  List<ClassRowStruct>? customClassesQuery;
  // Stores action output result for [Custom Action - updateAttendanceCounts] action in dashboard widget.
  String? updateFeedback;
  // Stores action output result for [Custom Action - manageUserChallenges] action in dashboard widget.
  String? newChallengesFeedback;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for classBlock_primary dynamic component.
  late FlutterFlowDynamicModels<ClassBlockPrimaryModel> classBlockPrimaryModels;
  // Models for classBlock_secondary dynamic component.
  late FlutterFlowDynamicModels<ClassBlockSecondaryModel>
      classBlockSecondaryModels;
  // Models for classBlock_upcoming dynamic component.
  late FlutterFlowDynamicModels<ClassBlockUpcomingModel>
      classBlockUpcomingModels;

  /// Query cache managers for this widget.

  final _currentDayTimetableRecordsManager =
      FutureRequestManager<List<TimetableRecordsRow>>();
  Future<List<TimetableRecordsRow>> currentDayTimetableRecords({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TimetableRecordsRow>> Function() requestFn,
  }) =>
      _currentDayTimetableRecordsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCurrentDayTimetableRecordsCache() =>
      _currentDayTimetableRecordsManager.clear();
  void clearCurrentDayTimetableRecordsCacheKey(String? uniqueKey) =>
      _currentDayTimetableRecordsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    classBlockPrimaryModels =
        FlutterFlowDynamicModels(() => ClassBlockPrimaryModel());
    classBlockSecondaryModels =
        FlutterFlowDynamicModels(() => ClassBlockSecondaryModel());
    classBlockUpcomingModels =
        FlutterFlowDynamicModels(() => ClassBlockUpcomingModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    classBlockPrimaryModels.dispose();
    classBlockSecondaryModels.dispose();
    classBlockUpcomingModels.dispose();

    /// Dispose query cache managers for this widget.

    clearCurrentDayTimetableRecordsCache();
  }
}
