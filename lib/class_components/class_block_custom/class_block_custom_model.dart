import '/flutter_flow/flutter_flow_util.dart';
import 'class_block_custom_widget.dart' show ClassBlockCustomWidget;
import 'package:flutter/material.dart';

class ClassBlockCustomModel extends FlutterFlowModel<ClassBlockCustomWidget> {
  ///  Local state fields for this component.

  bool isCancelled = false;

  bool hasChanges = false;

  bool isAttended = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - checkClassCancellation] action in classBlock_custom widget.
  bool? isCancelledQuery;
  // Stores action output result for [Custom Action - checkAttendance] action in classBlock_custom widget.
  bool? isAttendedQuery;
  // Stores action output result for [Custom Action - checkClassCancellation] action in Container widget.
  bool? isCancelledRefreshed;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
