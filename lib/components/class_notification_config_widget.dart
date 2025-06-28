import '/auth/firebase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/schedule_remainder_general_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_notification_config_model.dart';
export 'class_notification_config_model.dart';

class ClassNotificationConfigWidget extends StatefulWidget {
  const ClassNotificationConfigWidget({
    super.key,
    required this.className,
    required this.courseID,
  });

  final String? className;
  final String? courseID;

  @override
  State<ClassNotificationConfigWidget> createState() =>
      _ClassNotificationConfigWidgetState();
}

class _ClassNotificationConfigWidgetState
    extends State<ClassNotificationConfigWidget> {
  late ClassNotificationConfigModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassNotificationConfigModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CLASS_NOTIFICATION_CONFIG_classNotificat');
      logFirebaseEvent('classNotification_config_backend_call');
      _model.remainderExistsCopy =
          await TimetableSubscriptionsTable().queryRows(
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
      if (_model.remainderExistsCopy != null &&
          (_model.remainderExistsCopy)!.isNotEmpty) {
        logFirebaseEvent('classNotification_config_update_componen');
        _model.notificationSet = true;
        safeSetState(() {});
      } else {
        logFirebaseEvent('classNotification_config_update_componen');
        _model.notificationSet = false;
        safeSetState(() {});
      }
    });

    _model.switchValue = _model.notificationSet;
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
      width: double.infinity,
      height: 120.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 8.0, 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valueOrDefault<String>(
                widget.className,
                'className Not Defined',
              ),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                  ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Course Code: ',
                        style: GoogleFonts.outfit(
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(
                        text: valueOrDefault<String>(
                          (widget.courseID!).substring(0, 7),
                          'ME1001E',
                        ),
                        style: GoogleFonts.outfit(
                          color: FlutterFlowTheme.of(context).tertiary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      TextSpan(
                        text: ' | ',
                        style: TextStyle(),
                      ),
                      TextSpan(
                        text: 'Slot: ',
                        style: GoogleFonts.outfit(
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(
                        text: valueOrDefault<String>(
                          (widget.courseID!).substring(9, 11),
                          'H',
                        ),
                        style: GoogleFonts.outfit(
                          color: FlutterFlowTheme.of(context).tertiary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodySmallFamily,
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodySmallIsCustom,
                        ),
                  ),
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Toggle Notifications',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelLargeFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelLargeIsCustom,
                                ),
                          ),
                          Switch(
                            value: _model.switchValue!,
                            onChanged: (newValue) async {
                              safeSetState(
                                  () => _model.switchValue = newValue);
                              if (newValue) {
                                logFirebaseEvent(
                                    'CLASS_NOTIFICATION_CONFIG_Switch_z9mddb3');
                                logFirebaseEvent('Switch_backend_call');
                                await TimetableSubscriptionsTable().insert({
                                  'user_ref': currentUserUid,
                                  'course_id': widget.courseID,
                                  'created_at': supaSerialize<DateTime>(
                                      getCurrentTimestamp),
                                  'minutesbeforeclass': 10,
                                });
                              } else {
                                logFirebaseEvent(
                                    'CLASS_NOTIFICATION_CONFIG_Switch_z9mddb3');
                                logFirebaseEvent('Switch_backend_call');
                                await TimetableSubscriptionsTable().delete(
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
                              }
                            },
                            activeColor: FlutterFlowTheme.of(context).info,
                            activeTrackColor: Color(0xFF6F58FE),
                            inactiveTrackColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            inactiveThumbColor: Colors.black,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'CLASS_NOTIFICATION_CONFIG_Icon_hhinhl2t_');
                                    logFirebaseEvent('Icon_bottom_sheet');
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: ScheduleRemainderGeneralWidget(
                                            courseID: '',
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Icon(
                                    FFIcons.ksetting,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 28.0,
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
