import '/components/class_notification_config_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'customize_notifications_widget.dart' show CustomizeNotificationsWidget;
import 'package:flutter/material.dart';

class CustomizeNotificationsModel
    extends FlutterFlowModel<CustomizeNotificationsWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for classNotification_config dynamic component.
  late FlutterFlowDynamicModels<ClassNotificationConfigModel>
      classNotificationConfigModels;

  @override
  void initState(BuildContext context) {
    classNotificationConfigModels =
        FlutterFlowDynamicModels(() => ClassNotificationConfigModel());
  }

  @override
  void dispose() {
    classNotificationConfigModels.dispose();
  }
}
