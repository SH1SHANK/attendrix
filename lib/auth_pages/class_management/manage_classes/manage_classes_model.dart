import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'manage_classes_widget.dart' show ManageClassesWidget;
import 'package:flutter/material.dart';

class ManageClassesModel extends FlutterFlowModel<ManageClassesWidget> {
  ///  Local state fields for this page.

  DateTime? selectedDate;

  int startTime = 8;

  int endTime = 50;

  bool sundaysIncluded = false;

  bool saturdaysIncluded = false;

  int daysToRender = 16;

  bool customStartTime = false;

  ClassStatusStruct? classCancellationTemplate;
  void updateClassCancellationTemplateStruct(
      Function(ClassStatusStruct) updateFn) {
    updateFn(classCancellationTemplate ??= ClassStatusStruct());
  }

  ///  State fields for stateful widgets in this page.

  Stream<List<CourseRecordsRow>>? manageClassesSupabaseStream;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  int? dropDownValue2;
  FormFieldController<int>? dropDownValueController2;
  // State field(s) for courseName widget.
  String? courseNameValue;
  FormFieldController<String>? courseNameValueController;
  DateTime? datePicked;
  // State field(s) for classStartTime widget.
  FormFieldController<List<String>>? classStartTimeValueController;
  String? get classStartTimeValue =>
      classStartTimeValueController?.value?.firstOrNull;
  set classStartTimeValue(String? val) =>
      classStartTimeValueController?.value = val != null ? [val] : [];
  // State field(s) for classEndTime widget.
  int? classEndTimeValue;
  // State field(s) for classVenue widget.
  FocusNode? classVenueFocusNode;
  TextEditingController? classVenueTextController;
  String? Function(BuildContext, String?)? classVenueTextControllerValidator;
  // State field(s) for isPlusSlot widget.
  FormFieldController<List<String>>? isPlusSlotValueController;
  String? get isPlusSlotValue => isPlusSlotValueController?.value?.firstOrNull;
  set isPlusSlotValue(String? val) =>
      isPlusSlotValueController?.value = val != null ? [val] : [];
  // State field(s) for isExtraClass widget.
  FormFieldController<List<String>>? isExtraClassValueController;
  String? get isExtraClassValue =>
      isExtraClassValueController?.value?.firstOrNull;
  set isExtraClassValue(String? val) =>
      isExtraClassValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Insert Row] action in scheduleButton widget.
  TimetableRecordsRow? generatedClass;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    classVenueFocusNode?.dispose();
    classVenueTextController?.dispose();
  }
}
