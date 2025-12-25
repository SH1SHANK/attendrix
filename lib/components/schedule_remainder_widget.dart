import '/auth/firebase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'schedule_remainder_model.dart';
export 'schedule_remainder_model.dart';

/// A component that will serve as a bottom sheet that will be used for
/// scheduling a notification with multiple features, such as adding a title
/// and description and reminding 5 minutes, 10 minutes, or a custom time
/// before the class time.
class ScheduleRemainderWidget extends StatefulWidget {
  const ScheduleRemainderWidget({
    super.key,
    required this.className,
    required this.classStartTime,
    required this.classID,
  });

  final String? className;
  final DateTime? classStartTime;
  final String? classID;

  @override
  State<ScheduleRemainderWidget> createState() =>
      _ScheduleRemainderWidgetState();
}

class _ScheduleRemainderWidgetState extends State<ScheduleRemainderWidget> {
  late ScheduleRemainderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduleRemainderModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SCHEDULE_REMAINDER_scheduleRemainder_ON_');
      logFirebaseEvent('scheduleRemainder_backend_call');
      _model.existingNotification = await NotificationsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'class_id',
              widget.classID,
            )
            .eqOrNull(
              'user_ref',
              currentUserUid,
            ),
      );
      if (_model.existingNotification != null &&
          (_model.existingNotification)!.isNotEmpty) {
        logFirebaseEvent('scheduleRemainder_update_component_state');
        _model.minutes = functions.elapsedTime(
            _model.existingNotification!.firstOrNull!.scheduledAt,
            widget.classStartTime!,
            'MM');
        _model.notificationSet = true;
        safeSetState(() {});
      } else {
        logFirebaseEvent('scheduleRemainder_update_component_state');
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
                    logFirebaseEvent('SCHEDULE_REMAINDER_Icon_3r2adgt6_ON_TAP');
                    if (_model.minutes > 5) {
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
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      ),
                      TextSpan(
                        text: valueOrDefault<String>(
                          _model.minutes.toString(),
                          '5',
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      ),
                      TextSpan(
                        text: ' Minutes Before Class',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 18.0,
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
                    logFirebaseEvent('SCHEDULE_REMAINDER_Icon_l1yjv457_ON_TAP');
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
                  logFirebaseEvent('SCHEDULE_REMAINDER_Button_oel3vx0u_ON_TA');
                  if (_model.notificationSet) {
                    logFirebaseEvent('Button_backend_call');
                    await NotificationsTable().update(
                      data: {
                        'scheduled_at': supaSerialize<DateTime>(
                            functions.subtractTime(
                                widget.classStartTime!, _model.minutes, 'MM')),
                      },
                      matchingRows: (rows) => rows
                          .eqOrNull(
                            'class_id',
                            widget.classID,
                          )
                          .eqOrNull(
                            'user_ref',
                            currentUserUid,
                          ),
                    );
                  } else {
                    logFirebaseEvent('Button_backend_call');
                    await NotificationsTable().insert({
                      'user_ref': currentUserUid,
                      'title': functions.generateClassReminderText(
                          true,
                          widget.className!,
                          _model.minutes,
                          currentUserDisplayName),
                      'body': functions.generateClassReminderText(
                          false,
                          widget.className!,
                          _model.minutes,
                          currentUserDisplayName),
                      'scheduled_at': supaSerialize<DateTime>(
                          functions.subtractTime(
                              widget.classStartTime!, _model.minutes, 'MM')),
                      'created_at':
                          supaSerialize<DateTime>(getCurrentTimestamp),
                      'class_id': widget.classID,
                    });
                  }

                  logFirebaseEvent('Button_bottom_sheet');
                  Navigator.pop(context);
                },
                text: valueOrDefault<String>(
                  _model.notificationSet ? 'Update Remainder' : 'Add Remainder',
                  'Add Remainder',
                ),
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
