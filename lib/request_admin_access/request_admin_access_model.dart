import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'request_admin_access_widget.dart' show RequestAdminAccessWidget;
import 'package:flutter/material.dart';

class RequestAdminAccessModel
    extends FlutterFlowModel<RequestAdminAccessWidget> {
  ///  Local state fields for this page.

  bool invalidEmail = false;

  String errorMessage = 'Invalid Email Format';

  ///  State fields for stateful widgets in this page.

  Stream<List<AdminusersRow>>? requestAdminAccessSupabaseStream;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Supabase Admin Verification)] action in Button widget.
  ApiCallResponse? aPIResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
