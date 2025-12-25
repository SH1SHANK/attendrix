import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'schedule_remainder_widget.dart' show ScheduleRemainderWidget;
import 'package:flutter/material.dart';

class ScheduleRemainderModel extends FlutterFlowModel<ScheduleRemainderWidget> {
  ///  Local state fields for this component.

  int minutes = 5;

  bool notificationSet = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in scheduleRemainder widget.
  List<NotificationsRow>? existingNotification;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
