import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/mime_image_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quick_notes_widget.dart' show QuickNotesWidget;
import 'package:flutter/material.dart';

class QuickNotesModel extends FlutterFlowModel<QuickNotesWidget> {
  ///  Local state fields for this component.

  bool attachmentAdded = false;

  FileInfoStruct? fileInfo;
  void updateFileInfoStruct(Function(FileInfoStruct) updateFn) {
    updateFn(fileInfo ??= FileInfoStruct());
  }

  Color selectedColour = Color(4294967295);

  List<String> tags = [];
  void addToTags(String item) => tags.add(item);
  void removeFromTags(String item) => tags.remove(item);
  void removeAtIndexFromTags(int index) => tags.removeAt(index);
  void insertAtIndexInTags(int index, String item) => tags.insert(index, item);
  void updateTagsAtIndex(int index, Function(String) updateFn) =>
      tags[index] = updateFn(tags[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for mimeImageIcon component.
  late MimeImageIconModel mimeImageIconModel;
  Color? colorPicked;

  @override
  void initState(BuildContext context) {
    mimeImageIconModel = createModel(context, () => MimeImageIconModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    mimeImageIconModel.dispose();
  }
}
