import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quick_notes_widget.dart' show QuickNotesWidget;
import 'package:flutter/material.dart';

class QuickNotesModel extends FlutterFlowModel<QuickNotesWidget> {
  ///  Local state fields for this component.

  bool classRemainderSet = false;

  bool attachmentAdded = false;

  FileInfoStruct? fileInfo;
  void updateFileInfoStruct(Function(FileInfoStruct) updateFn) {
    updateFn(fileInfo ??= FileInfoStruct());
  }

  Color selectedColour = Color(4294967295);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  Color? colorPicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
