import '/flutter_flow/flutter_flow_util.dart';
import 'google_calender_sync_widget.dart' show GoogleCalenderSyncWidget;
import 'package:flutter/material.dart';

class GoogleCalenderSyncModel
    extends FlutterFlowModel<GoogleCalenderSyncWidget> {
  ///  Local state fields for this component.

  String? status = 'Request failed';

  String? message = 'error: NetworkException';

  bool requestSent = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
