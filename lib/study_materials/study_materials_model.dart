import '/backend/backend.dart';
import '/components/folder_block_user_vault_widget.dart';
import '/components/folder_block_widget.dart';
import '/components/task_manager_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'study_materials_widget.dart' show StudyMaterialsWidget;
import 'package:flutter/material.dart';

class StudyMaterialsModel extends FlutterFlowModel<StudyMaterialsWidget> {
  ///  Local state fields for this page.

  bool isFavoritteSelectedPersonalVault = false;

  bool isFavoriteSelectedGlobal = false;

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
  Completer<List<StudyMaterialsRecord>>? firestoreRequestCompleter;
  // Models for folderBlock dynamic component.
  late FlutterFlowDynamicModels<FolderBlockModel> folderBlockModels;
  Completer<List<StudyMaterialsRecord>>? algoliaRequestCompleter;
  // Models for taskManager_block dynamic component.
  late FlutterFlowDynamicModels<TaskManagerBlockModel> taskManagerBlockModels;
  // Stores action output result for [Custom Action - fileViewer] action in taskManager_block widget.
  String? fileStatus;
  // Models for folderBlockUserVault dynamic component.
  late FlutterFlowDynamicModels<FolderBlockUserVaultModel>
      folderBlockUserVaultModels;

  @override
  void initState(BuildContext context) {
    folderBlockModels = FlutterFlowDynamicModels(() => FolderBlockModel());
    taskManagerBlockModels =
        FlutterFlowDynamicModels(() => TaskManagerBlockModel());
    folderBlockUserVaultModels =
        FlutterFlowDynamicModels(() => FolderBlockUserVaultModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    folderBlockModels.dispose();
    taskManagerBlockModels.dispose();
    folderBlockUserVaultModels.dispose();
  }

  /// Additional helper methods.
  Future waitForFirestoreRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = firestoreRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

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
