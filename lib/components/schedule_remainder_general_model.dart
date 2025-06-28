import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'schedule_remainder_general_widget.dart'
    show ScheduleRemainderGeneralWidget;
import 'package:flutter/material.dart';

class ScheduleRemainderGeneralModel
    extends FlutterFlowModel<ScheduleRemainderGeneralWidget> {
  ///  Local state fields for this component.

  bool notificationSet = false;

  int minutes = 10;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in scheduleRemainder_general widget.
  List<TimetableSubscriptionsRow>? remainderExists;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
