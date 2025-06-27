import '/components/task_manager_user_personal_vault_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'file_manger_personalvault_widget.dart'
    show FileMangerPersonalvaultWidget;
import 'package:flutter/material.dart';

class FileMangerPersonalvaultModel
    extends FlutterFlowModel<FileMangerPersonalvaultWidget> {
  ///  Local state fields for this page.

  String? parentPath = 'home/';

  String? message;

  String fileType = 'all';

  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Models for taskManager_userPersonalVault dynamic component.
  late FlutterFlowDynamicModels<TaskManagerUserPersonalVaultModel>
      taskManagerUserPersonalVaultModels;
  // Stores action output result for [Custom Action - fileViewer] action in taskManager_userPersonalVault widget.
  String? fileStatus;

  @override
  void initState(BuildContext context) {
    taskManagerUserPersonalVaultModels =
        FlutterFlowDynamicModels(() => TaskManagerUserPersonalVaultModel());
  }

  @override
  void dispose() {
    taskManagerUserPersonalVaultModels.dispose();
  }
}
