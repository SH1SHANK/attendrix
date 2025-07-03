import '/backend/backend.dart';
import '/components/class_info_block_custom_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'custom_classes_widget.dart' show CustomClassesWidget;
import 'package:flutter/material.dart';

class CustomClassesModel extends FlutterFlowModel<CustomClassesWidget> {
  ///  Local state fields for this page.

  bool hasChanges = false;

  ///  State fields for stateful widgets in this page.

  // Models for classInfoBlock_custom dynamic component.
  late FlutterFlowDynamicModels<ClassInfoBlockCustomModel>
      classInfoBlockCustomModels;

  /// Query cache managers for this widget.

  final _customClassesManager =
      StreamRequestManager<List<CustomClassesRecord>>();
  Stream<List<CustomClassesRecord>> customClasses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<CustomClassesRecord>> Function() requestFn,
  }) =>
      _customClassesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCustomClassesCache() => _customClassesManager.clear();
  void clearCustomClassesCacheKey(String? uniqueKey) =>
      _customClassesManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    classInfoBlockCustomModels =
        FlutterFlowDynamicModels(() => ClassInfoBlockCustomModel());
  }

  @override
  void dispose() {
    classInfoBlockCustomModels.dispose();

    /// Dispose query cache managers for this widget.

    clearCustomClassesCache();
  }
}
