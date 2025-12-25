import '/backend/supabase/supabase.dart';
import '/class_components/class_block_calender/class_block_calender_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'calender_widget.dart' show CalenderWidget;
import 'package:flutter/material.dart';

class CalenderModel extends FlutterFlowModel<CalenderWidget> {
  ///  Local state fields for this page.

  DateTime? selectedDate;

  List<TimetableRecordsRow> timetableRecords = [];
  void addToTimetableRecords(TimetableRecordsRow item) =>
      timetableRecords.add(item);
  void removeFromTimetableRecords(TimetableRecordsRow item) =>
      timetableRecords.remove(item);
  void removeAtIndexFromTimetableRecords(int index) =>
      timetableRecords.removeAt(index);
  void insertAtIndexInTimetableRecords(int index, TimetableRecordsRow item) =>
      timetableRecords.insert(index, item);
  void updateTimetableRecordsAtIndex(
          int index, Function(TimetableRecordsRow) updateFn) =>
      timetableRecords[index] = updateFn(timetableRecords[index]);

  int daysToRender = 16;

  bool includeSundays = false;

  bool includeSaturdays = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in calender widget.
  List<TimetableRecordsRow>? initialTimetablerecords;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<TimetableRecordsRow>? selectedDayTimetableRecordsSelected;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  int? dropDownValue2;
  FormFieldController<int>? dropDownValueController2;
  // Models for classBlock_calender dynamic component.
  late FlutterFlowDynamicModels<ClassBlockCalenderModel>
      classBlockCalenderModels;

  @override
  void initState(BuildContext context) {
    classBlockCalenderModels =
        FlutterFlowDynamicModels(() => ClassBlockCalenderModel());
  }

  @override
  void dispose() {
    classBlockCalenderModels.dispose();
  }
}
