import '/components/challenge_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'challenges_widget.dart' show ChallengesWidget;
import 'package:flutter/material.dart';

class ChallengesModel extends FlutterFlowModel<ChallengesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for challenge_block dynamic component.
  late FlutterFlowDynamicModels<ChallengeBlockModel> challengeBlockModels1;
  // Models for challenge_block dynamic component.
  late FlutterFlowDynamicModels<ChallengeBlockModel> challengeBlockModels2;

  @override
  void initState(BuildContext context) {
    challengeBlockModels1 =
        FlutterFlowDynamicModels(() => ChallengeBlockModel());
    challengeBlockModels2 =
        FlutterFlowDynamicModels(() => ChallengeBlockModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    challengeBlockModels1.dispose();
    challengeBlockModels2.dispose();
  }
}
