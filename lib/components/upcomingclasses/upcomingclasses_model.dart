import '/components/upcoming_tag/upcoming_tag_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'upcomingclasses_widget.dart' show UpcomingclassesWidget;
import 'package:flutter/material.dart';

class UpcomingclassesModel extends FlutterFlowModel<UpcomingclassesWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for upcoming_tag component.
  late UpcomingTagModel upcomingTagModel;

  @override
  void initState(BuildContext context) {
    upcomingTagModel = createModel(context, () => UpcomingTagModel());
  }

  @override
  void dispose() {
    upcomingTagModel.dispose();
  }
}
