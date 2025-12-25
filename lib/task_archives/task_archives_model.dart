import '/backend/supabase/supabase.dart';
import '/components/task_archive_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'task_archives_widget.dart' show TaskArchivesWidget;
import 'package:flutter/material.dart';

class TaskArchivesModel extends FlutterFlowModel<TaskArchivesWidget> {
  ///  Local state fields for this page.

  String? filter;

  ///  State fields for stateful widgets in this page.

  Stream<List<TaskRecordsRow>>? listViewSupabaseStream;
  // Models for taskArchiveBlock dynamic component.
  late FlutterFlowDynamicModels<TaskArchiveBlockModel> taskArchiveBlockModels;

  @override
  void initState(BuildContext context) {
    taskArchiveBlockModels =
        FlutterFlowDynamicModels(() => TaskArchiveBlockModel());
  }

  @override
  void dispose() {
    taskArchiveBlockModels.dispose();
  }
}
