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

  // State field(s) for FileNameTextField widget.
  FocusNode? fileNameTextFieldFocusNode;
  TextEditingController? fileNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      fileNameTextFieldTextControllerValidator;
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
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Custom Action - fetchFileInfo] action in Button widget.
  FileInfoStruct? fileMetadataCopy;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  StudyMaterialsRecord? selectedFolder;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  StudyMaterialsRecord? userNewFile;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    fileNameTextFieldFocusNode?.dispose();
    fileNameTextFieldTextController?.dispose();

    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController2?.dispose();
  }
}
