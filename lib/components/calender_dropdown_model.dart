import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'calender_dropdown_widget.dart' show CalenderDropdownWidget;
import 'package:flutter/material.dart';

class CalenderDropdownModel extends FlutterFlowModel<CalenderDropdownWidget> {
  ///  Local state fields for this component.

  bool remainderSet = false;

  bool quickNotesSet = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in calender_dropdown widget.
  List<NotificationsRow>? remainderNotificationRow;
  // Stores action output result for [Firestore Query - Query a collection] action in calender_dropdown widget.
  ClassNotesRecord? classNotes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
