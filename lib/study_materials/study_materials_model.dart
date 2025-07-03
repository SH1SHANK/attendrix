import '/backend/backend.dart';
import '/components/folder_block_widget.dart';
import '/components/task_manager_block_widget.dart';
import '/empty_list_comp/empty_class/empty_class_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'study_materials_widget.dart' show StudyMaterialsWidget;
import 'package:flutter/material.dart';

class StudyMaterialsModel extends FlutterFlowModel<StudyMaterialsWidget> {
  ///  Local state fields for this page.

  bool searchActiveGlobal = false;

  String searchQuery = '';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for folderBlock dynamic component.
  late FlutterFlowDynamicModels<FolderBlockModel> folderBlockModels;
  Completer<List<StudyMaterialsRecord>>? algoliaRequestCompleter;
  // Models for taskManager_block dynamic component.
  late FlutterFlowDynamicModels<TaskManagerBlockModel> taskManagerBlockModels;
  // Stores action output result for [Custom Action - fileViewer] action in taskManager_block widget.
  String? fileStatus;
  // Model for emptyClass component.
  late EmptyClassModel emptyClassModel;

  @override
  void initState(BuildContext context) {
    folderBlockModels = FlutterFlowDynamicModels(() => FolderBlockModel());
    taskManagerBlockModels =
        FlutterFlowDynamicModels(() => TaskManagerBlockModel());
    emptyClassModel = createModel(context, () => EmptyClassModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    folderBlockModels.dispose();
    taskManagerBlockModels.dispose();
    emptyClassModel.dispose();
  }

  /// Additional helper methods.
  Future waitForAlgoliaRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = algoliaRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
