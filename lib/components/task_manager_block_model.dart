import '/components/mime_image_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'task_manager_block_widget.dart' show TaskManagerBlockWidget;
import 'package:flutter/material.dart';

class TaskManagerBlockModel extends FlutterFlowModel<TaskManagerBlockWidget> {
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
