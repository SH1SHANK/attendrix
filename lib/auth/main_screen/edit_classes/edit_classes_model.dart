import '/components/assign_exams_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_classes_widget.dart' show EditClassesWidget;
import 'package:flutter/material.dart';

class EditClassesModel extends FlutterFlowModel<EditClassesWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  DateTime? datePicked;
  // Model for assignExams component.
  late AssignExamsModel assignExamsModel;

  @override
  void initState(BuildContext context) {
    assignExamsModel = createModel(context, () => AssignExamsModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    assignExamsModel.dispose();
  }
}
