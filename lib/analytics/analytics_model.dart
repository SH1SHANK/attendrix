import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'analytics_widget.dart' show AnalyticsWidget;
import 'package:flutter/material.dart';

class AnalyticsModel extends FlutterFlowModel<AnalyticsWidget> {
  ///  Local state fields for this page.

  List<String> courseIDs = [];
  void addToCourseIDs(String item) => courseIDs.add(item);
  void removeFromCourseIDs(String item) => courseIDs.remove(item);
  void removeAtIndexFromCourseIDs(int index) => courseIDs.removeAt(index);
  void insertAtIndexInCourseIDs(int index, String item) =>
      courseIDs.insert(index, item);
  void updateCourseIDsAtIndex(int index, Function(String) updateFn) =>
      courseIDs[index] = updateFn(courseIDs[index]);

  String period = '7d';

  List<String> courseNames = [];
  void addToCourseNames(String item) => courseNames.add(item);
  void removeFromCourseNames(String item) => courseNames.remove(item);
  void removeAtIndexFromCourseNames(int index) => courseNames.removeAt(index);
  void insertAtIndexInCourseNames(int index, String item) =>
      courseNames.insert(index, item);
  void updateCourseNamesAtIndex(int index, Function(String) updateFn) =>
      courseNames[index] = updateFn(courseNames[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  List<String>? dropDownValue1;
  FormFieldController<List<String>>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
