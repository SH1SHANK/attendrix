import '/auth/firebase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'schedule_remainder_custom_model.dart';
export 'schedule_remainder_custom_model.dart';

/// A component that will serve as a bottom sheet that will be used for
/// scheduling a notification with multiple features, such as adding a title
/// and description and reminding 5 minutes, 10 minutes, or a custom time
/// before the class time.
class ScheduleRemainderCustomWidget extends StatefulWidget {
  const ScheduleRemainderCustomWidget({
    super.key,
    this.courseID,
  });

  final String? courseID;

  @override
  State<ScheduleRemainderCustomWidget> createState() =>
      _ScheduleRemainderCustomWidgetState();
}

class _ScheduleRemainderCustomWidgetState
    extends State<ScheduleRemainderCustomWidget> {
  late ScheduleRemainderCustomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduleRemainderCustomModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              -2.0,
            ),
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'SCHEDULE_REMAINDER_CUSTOM_Icon_4eq71uud_');
                    if (_model.minutes > 10) {
                      logFirebaseEvent('Icon_update_component_state');
                      _model.minutes = _model.minutes + -5;
                      safeSetState(() {});
                    }
                  },
                  child: Icon(
                    FFIcons.kminusSubtractNegativeDash,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 32.0,
                  ),
                ),
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Remind Me ',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      ),
                      TextSpan(
                        text: valueOrDefault<String>(
                          _model.minutes.toString(),
                          '15',
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      ),
                      TextSpan(
                        text: ' Minutes Before Every Class',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'SCHEDULE_REMAINDER_CUSTOM_Icon_tvxsfb4x_');
                    if (_model.minutes < 120) {
                      logFirebaseEvent('Icon_update_component_state');
                      _model.minutes = _model.minutes + 5;
                      safeSetState(() {});
                    }
                  },
                  child: Icon(
                    FFIcons.kaddPlus,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 32.0,
                  ),
                ),
              ],
            ),
            Flexible(
              child: FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('SCHEDULE_REMAINDER_CUSTOM_UPDATE_REMAIND');
                  logFirebaseEvent('Button_backend_call');
                  await NotificationsConfigTable().update(
                    data: {
                      'minutes_before_class': _model.minutes,
                      'toggle_notifications': true,
                    },
                    matchingRows: (rows) => rows
                        .eqOrNull(
                          'course_id',
                          widget.courseID,
                        )
                        .eqOrNull(
                          'user_id',
                          currentUserUid,
                        ),
                  );
                  logFirebaseEvent('Button_bottom_sheet');
                  Navigator.pop(context);
                },
                text: 'Update Remainder',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
            ),
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
