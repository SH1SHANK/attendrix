import '/components/class_archive_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'class_archives_widget.dart' show ClassArchivesWidget;
import 'package:flutter/material.dart';

class ClassArchivesModel extends FlutterFlowModel<ClassArchivesWidget> {
  ///  Local state fields for this page.

  String? filter;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Models for classArchiveBlock dynamic component.
  late FlutterFlowDynamicModels<ClassArchiveBlockModel> classArchiveBlockModels;

  @override
  void initState(BuildContext context) {
    classArchiveBlockModels =
        FlutterFlowDynamicModels(() => ClassArchiveBlockModel());
  }

  @override
  void dispose() {
    classArchiveBlockModels.dispose();
  }
}
