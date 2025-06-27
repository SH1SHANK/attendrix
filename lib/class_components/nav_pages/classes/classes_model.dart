import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/class_components/class_block_general/class_block_general_widget.dart';
import '/class_components/class_block_missed/class_block_missed_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'classes_widget.dart' show ClassesWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class ClassesModel extends FlutterFlowModel<ClassesWidget> {
  ///  Local state fields for this page.

  int numDays = 7;

  bool rebuildPage = false;

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

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getMissedClasses] action in classes widget.
  List<ClassRowStruct>? missedClassesQuery;
  // Stores action output result for [Custom Action - fetchAllClasses] action in classes widget.
  List<ClassRowStruct>? customClassesQuery;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for DropDown widget.
  int? dropDownValue;
  FormFieldController<int>? dropDownValueController;
  bool requestCompleted = false;
  String? requestLastUniqueKey;
  // Models for classBlock_general dynamic component.
  late FlutterFlowDynamicModels<ClassBlockGeneralModel>
      classBlockGeneralModels1;
  // Models for classBlock_general dynamic component.
  late FlutterFlowDynamicModels<ClassBlockGeneralModel>
      classBlockGeneralModels2;
  // Models for classBlock_missed dynamic component.
  late FlutterFlowDynamicModels<ClassBlockMissedModel> classBlockMissedModels;

  @override
  void initState(BuildContext context) {
    classBlockGeneralModels1 =
        FlutterFlowDynamicModels(() => ClassBlockGeneralModel());
    classBlockGeneralModels2 =
        FlutterFlowDynamicModels(() => ClassBlockGeneralModel());
    classBlockMissedModels =
        FlutterFlowDynamicModels(() => ClassBlockMissedModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    classBlockGeneralModels1.dispose();
    classBlockGeneralModels2.dispose();
    classBlockMissedModels.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
