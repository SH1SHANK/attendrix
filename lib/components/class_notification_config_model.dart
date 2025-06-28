import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'class_notification_config_widget.dart'
    show ClassNotificationConfigWidget;
import 'package:flutter/material.dart';

class ClassNotificationConfigModel
    extends FlutterFlowModel<ClassNotificationConfigWidget> {
  ///  Local state fields for this component.

  bool notificationSet = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in classNotification_config widget.
  List<TimetableSubscriptionsRow>? remainderExistsCopy;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
