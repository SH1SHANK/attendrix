import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/components/leaderboard_widget.dart';
import '/components/toast_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, UsersRecord>? listViewPagingController1;
  Query? listViewPagingQuery1;
  List<StreamSubscription?> listViewStreamSubscriptions1 = [];

  // Models for leaderboard dynamic component.
  late FlutterFlowDynamicModels<LeaderboardModel> leaderboardModels;
  // Models for Toast dynamic component.
  late FlutterFlowDynamicModels<ToastModel> toastModels;

  /// Query cache managers for this widget.

  final _amplixLogsManager = FutureRequestManager<List<AmplixLogsRow>>();
  Future<List<AmplixLogsRow>> amplixLogs({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<AmplixLogsRow>> Function() requestFn,
  }) =>
      _amplixLogsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAmplixLogsCache() => _amplixLogsManager.clear();
  void clearAmplixLogsCacheKey(String? uniqueKey) =>
      _amplixLogsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    leaderboardModels = FlutterFlowDynamicModels(() => LeaderboardModel());
    toastModels = FlutterFlowDynamicModels(() => ToastModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    listViewStreamSubscriptions1.forEach((s) => s?.cancel());
    listViewPagingController1?.dispose();

    leaderboardModels.dispose();
    toastModels.dispose();

    /// Dispose query cache managers for this widget.

    clearAmplixLogsCache();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, UsersRecord> setListViewController1(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController1 ??= _createListViewController1(query, parent);
    if (listViewPagingQuery1 != query) {
      listViewPagingQuery1 = query;
      listViewPagingController1?.refresh();
    }
    return listViewPagingController1!;
  }

  PagingController<DocumentSnapshot?, UsersRecord> _createListViewController1(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, UsersRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryUsersRecordPage(
          queryBuilder: (_) => listViewPagingQuery1 ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions1,
          controller: controller,
          pageSize: 10,
          isStream: true,
        ),
      );
  }
}
