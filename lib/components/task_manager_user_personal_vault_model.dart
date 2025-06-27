import '/components/mime_image_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'task_manager_user_personal_vault_widget.dart'
    show TaskManagerUserPersonalVaultWidget;
import 'package:flutter/material.dart';

class TaskManagerUserPersonalVaultModel
    extends FlutterFlowModel<TaskManagerUserPersonalVaultWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for mimeImageIcon component.
  late MimeImageIconModel mimeImageIconModel;

  @override
  void initState(BuildContext context) {
    mimeImageIconModel = createModel(context, () => MimeImageIconModel());
  }

  @override
  void dispose() {
    mimeImageIconModel.dispose();
  }
}
