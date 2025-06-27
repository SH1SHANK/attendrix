import '/components/task_manager_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'file_manager_widget.dart' show FileManagerWidget;
import 'package:flutter/material.dart';

class FileManagerModel extends FlutterFlowModel<FileManagerWidget> {
  ///  Local state fields for this page.

  String? parentPath = 'home/';

  String? message;

  String fileType = 'All';

  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Models for taskManager_block dynamic component.
  late FlutterFlowDynamicModels<TaskManagerBlockModel> taskManagerBlockModels;
  // Stores action output result for [Custom Action - fileViewer] action in taskManager_block widget.
  String? fileStatus;

  @override
  void initState(BuildContext context) {
    taskManagerBlockModels =
        FlutterFlowDynamicModels(() => TaskManagerBlockModel());
  }

  @override
  void dispose() {
    taskManagerBlockModels.dispose();
  }
}
