import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'challenge_block_model.dart';
export 'challenge_block_model.dart';

/// Create a component which is a goal Component with a heading, description
/// and a progress bar and a icon to the left, make it playful and creative
/// and gamified look to it
///
///
class ChallengeBlockWidget extends StatefulWidget {
  const ChallengeBlockWidget({
    super.key,
    required this.challengeRecord,
  });

  final ChallengeStruct? challengeRecord;

  @override
  State<ChallengeBlockWidget> createState() => _ChallengeBlockWidgetState();
}

class _ChallengeBlockWidgetState extends State<ChallengeBlockWidget> {
  late ChallengeBlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChallengeBlockModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AmplixChallengeProgressRow>>(
      stream: _model.containerSupabaseStream ??= SupaFlow.client
          .from("amplixChallengeProgress")
          .stream(primaryKey: ['progressID'])
          .eqOrNull(
            'progressID',
            widget.challengeRecord?.progressID,
          )
          .map((list) =>
              list.map((item) => AmplixChallengeProgressRow(item)).toList()),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 25.0,
              height: 25.0,
              child: SpinKitFadingCube(
                color: FlutterFlowTheme.of(context).primary,
                size: 25.0,
              ),
            ),
          );
        }
        List<AmplixChallengeProgressRow>
            containerAmplixChallengeProgressRowList = snapshot.data!;

        final containerAmplixChallengeProgressRow =
            containerAmplixChallengeProgressRowList.isNotEmpty
                ? containerAmplixChallengeProgressRowList.first
                : null;

        return AnimatedContainer(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  2.0,
                ),
              )
            ],
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 8.0, 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    valueOrDefault<String>(
                      FFAppConstants.icons.elementAtOrNull(valueOrDefault<int>(
                        functions.randomNumberGenerator(
                            0, 17, widget.challengeRecord!.challengeID),
                        5,
                      )),
                      'https://cdn-icons-gif.flaticon.com/15577/15577997.gif',
                    ),
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            valueOrDefault<String>(
                              widget.challengeRecord?.challengeName,
                              'Daily Fitness Challenge',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            valueOrDefault<String>(
                              widget.challengeRecord?.challengeDescription,
                              'No description was provided for this challenge.',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  fontSize: 8.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 0.0),
                            child: LinearPercentIndicator(
                              percent: valueOrDefault<double>(
                                (int var1, int var2) {
                                  return var2 == 0
                                      ? 0.0
                                      : double.parse(
                                          (var1 / var2).toStringAsFixed(1));
                                }(
                                    containerAmplixChallengeProgressRow!
                                        .progress,
                                    containerAmplixChallengeProgressRow
                                        .targetValue),
                                0.0,
                              ),
                              lineHeight: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: FFAppConstants.colours
                                  .elementAtOrNull(valueOrDefault<int>(
                                functions.randomNumberGenerator(
                                    0, 8, widget.challengeRecord!.challengeID),
                                0,
                              )),
                              backgroundColor: Color(0xB7D4D7DB),
                              center: Text(
                                valueOrDefault<String>(
                                  '${containerAmplixChallengeProgressRow.progress.toString()}/${containerAmplixChallengeProgressRow.targetValue.toString()}',
                                  '0/0',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 8.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineSmallIsCustom,
                                    ),
                              ),
                              barRadius: Radius.circular(24.0),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: (containerAmplixChallengeProgressRow
                                .isClaimed! ||
                            !containerAmplixChallengeProgressRow.isCompleted)
                        ? null
                        : () async {
                            logFirebaseEvent(
                                'CHALLENGE_BLOCK_Button_2gkh1lra_ON_TAP');
                            if (containerAmplixChallengeProgressRow
                                    .isCompleted &&
                                !containerAmplixChallengeProgressRow
                                    .isClaimed!) {
                              logFirebaseEvent('Button_custom_action');
                              _model.amplixReward =
                                  await actions.verifyAndClaimChallenge(
                                widget.challengeRecord!.progressID,
                              );
                              logFirebaseEvent('Button_backend_call');

                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'amplix': FieldValue.increment(
                                        _model.amplixReward!),
                                  },
                                ),
                              });
                              logFirebaseEvent('Button_show_snack_bar');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Challenge claimed! You gained +${_model.amplixReward?.toString()} Amplix! ⚡',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelSmallIsCustom,
                                        ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                              );
                              logFirebaseEvent('Button_update_component_state');
                              _model.rebuildComponent =
                                  !_model.rebuildComponent;
                              safeSetState(() {});
                            } else {
                              logFirebaseEvent('Button_action_block');
                              await action_blocks.universalErrorSnackbar(
                                context,
                                errorMessage:
                                    'Oops! You\'ve already claimed this reward or haven\'t completed the challenge yet. Finish it up and try again!',
                              );
                            }

                            safeSetState(() {});
                          },
                    text: valueOrDefault<String>(
                      () {
                        if (containerAmplixChallengeProgressRow.progress ==
                            0) {
                          return 'Not Started';
                        } else if (!containerAmplixChallengeProgressRow
                            .isCompleted) {
                          return 'In Progress';
                        } else if (containerAmplixChallengeProgressRow
                            .isClaimed!) {
                          return 'Claimed';
                        } else {
                          return 'Claim Now';
                        }
                      }(),
                      'Not Started',
                    ),
                    options: FFButtonOptions(
                      height: 32.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: valueOrDefault<Color>(
                        FFAppConstants.colours
                            .elementAtOrNull(valueOrDefault<int>(
                          functions.randomNumberGenerator(
                              0, 8, widget.challengeRecord!.challengeID),
                          0,
                        )),
                        FlutterFlowTheme.of(context).error,
                      ),
                      textStyle: FlutterFlowTheme.of(context)
                          .labelSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: FlutterFlowTheme.of(context).info,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelSmallIsCustom,
                          ),
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(32.0),
                      disabledColor: FlutterFlowTheme.of(context).secondaryText,
                      disabledTextColor: Colors.black,
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
          ),
        );
      },
    );
  }
}
