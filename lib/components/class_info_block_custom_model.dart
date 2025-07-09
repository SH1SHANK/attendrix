import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'class_info_block_custom_widget.dart' show ClassInfoBlockCustomWidget;
import 'package:flutter/material.dart';

class ClassInfoBlockCustomModel
    extends FlutterFlowModel<ClassInfoBlockCustomWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Alert Dialog - Custom Dialog] action in Icon widget.
  bool? confirmnationDialogResponse;
  // Stores action output result for [Custom Action - removeCourseClasses] action in Icon widget.
  List<ClassRowStruct>? newCustomClassesAllDay;
  // Stores action output result for [Custom Action - fetchCustomClasses] action in Icon widget.
  List<ClassRowStruct>? newCustomClassesCurrentDay;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
