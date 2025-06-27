import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pick_file_alert_dialog_widget.dart' show PickFileAlertDialogWidget;
import 'package:flutter/material.dart';

class PickFileAlertDialogModel
    extends FlutterFlowModel<PickFileAlertDialogWidget> {
  ///  Local state fields for this component.

  bool fileUploaded = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Custom Action - fetchFileInfo] action in Container widget.
  FileInfoStruct? fileMetadata;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - fetchFileInfo] action in TextField widget.
  FileInfoStruct? fileMetadata2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
