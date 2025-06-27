import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_tags_personal_vault_widget.dart' show AddTagsPersonalVaultWidget;
import 'package:flutter/material.dart';

class AddTagsPersonalVaultModel
    extends FlutterFlowModel<AddTagsPersonalVaultWidget> {
  ///  Local state fields for this component.

  List<String> addedTags = [];
  void addToAddedTags(String item) => addedTags.add(item);
  void removeFromAddedTags(String item) => addedTags.remove(item);
  void removeAtIndexFromAddedTags(int index) => addedTags.removeAt(index);
  void insertAtIndexInAddedTags(int index, String item) =>
      addedTags.insert(index, item);
  void updateAddedTagsAtIndex(int index, Function(String) updateFn) =>
      addedTags[index] = updateFn(addedTags[index]);

  bool isSimilarTag = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
