import '/backend/backend.dart';
import '/components/class_archive_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'class_archives_widget.dart' show ClassArchivesWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ClassArchivesModel extends FlutterFlowModel<ClassArchivesWidget> {
  ///  Local state fields for this page.

  String? filter;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, ClassNotesRecord>?
      listViewPagingController;
  Query? listViewPagingQuery;
  List<StreamSubscription?> listViewStreamSubscriptions = [];

  // Models for classArchiveBlock dynamic component.
  late FlutterFlowDynamicModels<ClassArchiveBlockModel> classArchiveBlockModels;

  @override
  void initState(BuildContext context) {
    classArchiveBlockModels =
        FlutterFlowDynamicModels(() => ClassArchiveBlockModel());
  }

  @override
  void dispose() {
    listViewStreamSubscriptions.forEach((s) => s?.cancel());
    listViewPagingController?.dispose();

    classArchiveBlockModels.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, ClassNotesRecord> setListViewController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController ??= _createListViewController(query, parent);
    if (listViewPagingQuery != query) {
      listViewPagingQuery = query;
      listViewPagingController?.refresh();
    }
    return listViewPagingController!;
  }

  PagingController<DocumentSnapshot?, ClassNotesRecord>
      _createListViewController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller = PagingController<DocumentSnapshot?, ClassNotesRecord>(
        firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryClassNotesRecordPage(
          parent: parent,
          queryBuilder: (_) => listViewPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions,
          controller: controller,
          pageSize: 5,
          isStream: true,
        ),
      );
  }
}
