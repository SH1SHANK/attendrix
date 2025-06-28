import '/auth/firebase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'schedule_remainder_general_model.dart';
export 'schedule_remainder_general_model.dart';

class ScheduleRemainderGeneralWidget extends StatefulWidget {
  const ScheduleRemainderGeneralWidget({
    super.key,
    this.courseID,
  });

  final String? courseID;

  @override
  State<ScheduleRemainderGeneralWidget> createState() =>
      _ScheduleRemainderGeneralWidgetState();
}

class _ScheduleRemainderGeneralWidgetState
    extends State<ScheduleRemainderGeneralWidget> {
  late ScheduleRemainderGeneralModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduleRemainderGeneralModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SCHEDULE_REMAINDER_GENERAL_scheduleRemai');
      logFirebaseEvent('scheduleRemainder_general_backend_call');
      _model.remainderExists = await TimetableSubscriptionsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'user_ref',
              currentUserUid,
            )
            .eqOrNull(
              'course_id',
              widget.courseID,
            ),
      );
      if (_model.remainderExists != null &&
          (_model.remainderExists)!.isNotEmpty) {
        logFirebaseEvent('scheduleRemainder_general_update_compone');
        _model.notificationSet = true;
        _model.minutes =
            _model.remainderExists!.firstOrNull!.minutesbeforeclass!;
        safeSetState(() {});
      } else {
        logFirebaseEvent('scheduleRemainder_general_update_compone');
        _model.notificationSet = false;
        safeSetState(() {});
      }
    });

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
                        'SCHEDULE_REMAINDER_GENERAL_Icon_6r7w276s');
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
                          '10',
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
                        'SCHEDULE_REMAINDER_GENERAL_Icon_54nqbjwo');
                    if (_model.minutes < 120) {
                      logFirebaseEvent('Icon_update_component_state');
                      _model.minutes = 5;
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
                  logFirebaseEvent('SCHEDULE_REMAINDER_GENERAL_Button_6v4oc7');
                  if (_model.notificationSet) {
                    logFirebaseEvent('Button_backend_call');
                    await TimetableSubscriptionsTable().update(
                      data: {
                        'minutesbeforeclass': _model.minutes,
                      },
                      matchingRows: (rows) => rows
                          .eqOrNull(
                            'user_ref',
                            currentUserUid,
                          )
                          .eqOrNull(
                            'course_id',
                            widget.courseID,
                          ),
                    );
                  } else {
                    logFirebaseEvent('Button_backend_call');
                    await TimetableSubscriptionsTable().insert({
                      'user_ref': currentUserUid,
                      'course_id': widget.courseID,
                      'created_at':
                          supaSerialize<DateTime>(getCurrentTimestamp),
                      'minutesbeforeclass': _model.minutes,
                    });
                  }

                  logFirebaseEvent('Button_bottom_sheet');
                  Navigator.pop(context);
                },
                text: _model.notificationSet
                    ? 'Update Remainder'
                    : 'Add Remainder',
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
