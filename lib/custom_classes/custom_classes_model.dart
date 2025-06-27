import '/components/class_info_block_custom_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'custom_classes_widget.dart' show CustomClassesWidget;
import 'package:flutter/material.dart';

class CustomClassesModel extends FlutterFlowModel<CustomClassesWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for classInfoBlock_custom dynamic component.
  late FlutterFlowDynamicModels<ClassInfoBlockCustomModel>
      classInfoBlockCustomModels;

  @override
  void initState(BuildContext context) {
    classInfoBlockCustomModels =
        FlutterFlowDynamicModels(() => ClassInfoBlockCustomModel());
  }

  @override
  void dispose() {
    classInfoBlockCustomModels.dispose();
  }
}
