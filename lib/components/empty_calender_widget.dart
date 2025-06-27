import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'empty_calender_model.dart';
export 'empty_calender_model.dart';

class EmptyCalenderWidget extends StatefulWidget {
  const EmptyCalenderWidget({super.key});

  @override
  State<EmptyCalenderWidget> createState() => _EmptyCalenderWidgetState();
}

class _EmptyCalenderWidgetState extends State<EmptyCalenderWidget> {
  late EmptyCalenderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyCalenderModel());

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
