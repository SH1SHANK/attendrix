import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/class_components/class_block_custom/class_block_custom_widget.dart';
import '/class_components/class_block_general/class_block_general_widget.dart';
import '/class_components/class_block_missed/class_block_missed_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'classes_widget.dart' show ClassesWidget;
import 'package:flutter/material.dart';

class ClassesModel extends FlutterFlowModel<ClassesWidget> {
  ///  Local state fields for this page.

  int numDays = 7;

  List<ClassRowStruct> missedClasses = [];
  void addToMissedClasses(ClassRowStruct item) => missedClasses.add(item);
  void removeFromMissedClasses(ClassRowStruct item) =>
      missedClasses.remove(item);
  void removeAtIndexFromMissedClasses(int index) =>
      missedClasses.removeAt(index);
  void insertAtIndexInMissedClasses(int index, ClassRowStruct item) =>
      missedClasses.insert(index, item);
  void updateMissedClassesAtIndex(
          int index, Function(ClassRowStruct) updateFn) =>
      missedClasses[index] = updateFn(missedClasses[index]);

  List<ClassRowStruct> customClasses = [];
  void addToCustomClasses(ClassRowStruct item) => customClasses.add(item);
  void removeFromCustomClasses(ClassRowStruct item) =>
      customClasses.remove(item);
  void removeAtIndexFromCustomClasses(int index) =>
      customClasses.removeAt(index);
  void insertAtIndexInCustomClasses(int index, ClassRowStruct item) =>
      customClasses.insert(index, item);
  void updateCustomClassesAtIndex(
          int index, Function(ClassRowStruct) updateFn) =>
      customClasses[index] = updateFn(customClasses[index]);

  bool multiSelectMode = false;

  List<ClassRowStruct> selectedclasses = [];
  void addToSelectedclasses(ClassRowStruct item) => selectedclasses.add(item);
  void removeFromSelectedclasses(ClassRowStruct item) =>
      selectedclasses.remove(item);
  void removeAtIndexFromSelectedclasses(int index) =>
      selectedclasses.removeAt(index);
  void insertAtIndexInSelectedclasses(int index, ClassRowStruct item) =>
      selectedclasses.insert(index, item);
  void updateSelectedclassesAtIndex(
          int index, Function(ClassRowStruct) updateFn) =>
      selectedclasses[index] = updateFn(selectedclasses[index]);

  bool includeSundays = false;

  bool includeSaturdays = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getMissedClasses] action in classes widget.
  List<ClassRowStruct>? missedClassesLoad;
  // Stores action output result for [Custom Action - fetchCustomClasses] action in classes widget.
  List<ClassRowStruct>? customClassesQuery;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for DropDown widget.
  int? dropDownValue1;
  FormFieldController<int>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Models for classBlock_general dynamic component.
  late FlutterFlowDynamicModels<ClassBlockGeneralModel> classBlockGeneralModels;
  // Models for classBlock_custom dynamic component.
  late FlutterFlowDynamicModels<ClassBlockCustomModel> classBlockCustomModels;
  // Stores action output result for [Custom Action - getMissedClasses] action in Button widget.
  List<ClassRowStruct>? refreshedMissedClasses;
  // Models for classBlock_missed dynamic component.
  late FlutterFlowDynamicModels<ClassBlockMissedModel> classBlockMissedModels;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? confirmDialogResponse;

  @override
  void initState(BuildContext context) {
    classBlockGeneralModels =
        FlutterFlowDynamicModels(() => ClassBlockGeneralModel());
    classBlockCustomModels =
        FlutterFlowDynamicModels(() => ClassBlockCustomModel());
    classBlockMissedModels =
        FlutterFlowDynamicModels(() => ClassBlockMissedModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    classBlockGeneralModels.dispose();
    classBlockCustomModels.dispose();
    classBlockMissedModels.dispose();
  }
}
