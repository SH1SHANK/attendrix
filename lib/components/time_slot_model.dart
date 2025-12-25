import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'time_slot_widget.dart' show TimeSlotWidget;
import 'package:flutter/material.dart';

class TimeSlotModel extends FlutterFlowModel<TimeSlotWidget> {
  ///  Local state fields for this component.

  bool conflictsAvailable = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
