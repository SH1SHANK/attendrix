import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'challenge_block_widget.dart' show ChallengeBlockWidget;
import 'package:flutter/material.dart';

class ChallengeBlockModel extends FlutterFlowModel<ChallengeBlockWidget> {
  ///  Local state fields for this component.

  bool rebuildComponent = false;

  ///  State fields for stateful widgets in this component.

  Stream<List<AmplixChallengeProgressRow>>? containerSupabaseStream;
  // Stores action output result for [Custom Action - verifyAndClaimChallenge] action in Button widget.
  int? amplixReward;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
