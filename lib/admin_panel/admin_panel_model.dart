import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'admin_panel_widget.dart' show AdminPanelWidget;
import 'package:flutter/material.dart';

class AdminPanelModel extends FlutterFlowModel<AdminPanelWidget> {
  ///  Local state fields for this page.

  DateTime? dateSelected;

  ///  State fields for stateful widgets in this page.

  DateTime? datePicked;
  Stream<List<TimetableRecordsRow>>? listViewSupabaseStream;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
