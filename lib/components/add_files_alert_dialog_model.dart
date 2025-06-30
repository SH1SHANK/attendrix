import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_files_alert_dialog_widget.dart' show AddFilesAlertDialogWidget;
import 'package:flutter/material.dart';

class AddFilesAlertDialogModel
    extends FlutterFlowModel<AddFilesAlertDialogWidget> {
  ///  Local state fields for this component.

  bool fileUploaded = false;

  FileInfoStruct? uploadedFile;
  void updateUploadedFileStruct(Function(FileInfoStruct) updateFn) {
    updateFn(uploadedFile ??= FileInfoStruct());
  }

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Custom Action - fetchFileInfo] action in Container widget.
  FileInfoStruct? fileMetadata;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Custom Action - fetchFileInfo] action in Button widget.
  FileInfoStruct? fileMetadataCopy;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  UserPersonalVaultRecord? userNewFile;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    tabBarController?.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
