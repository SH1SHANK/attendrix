import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'google_calender_sync_model.dart';
export 'google_calender_sync_model.dart';

class GoogleCalenderSyncWidget extends StatefulWidget {
  const GoogleCalenderSyncWidget({super.key});

  @override
  State<GoogleCalenderSyncWidget> createState() =>
      _GoogleCalenderSyncWidgetState();
}

class _GoogleCalenderSyncWidgetState extends State<GoogleCalenderSyncWidget> {
  late GoogleCalenderSyncModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GoogleCalenderSyncModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
