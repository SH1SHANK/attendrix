import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/components/confirm_dialog_widget.dart';
import '/components/schedule_remainder_custom_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'class_info_block_custom_model.dart';
export 'class_info_block_custom_model.dart';

/// Course Details Overview
class ClassInfoBlockCustomWidget extends StatefulWidget {
  const ClassInfoBlockCustomWidget({
    super.key,
    required this.classRecord,
  });

  final CustomClassesRecord? classRecord;

  @override
  State<ClassInfoBlockCustomWidget> createState() =>
      _ClassInfoBlockCustomWidgetState();
}

class _ClassInfoBlockCustomWidgetState
    extends State<ClassInfoBlockCustomWidget> {
  late ClassInfoBlockCustomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassInfoBlockCustomModel());

    _model.switchValue = widget.classRecord!.toggleNotfications;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 150.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 12.0, 8.0, 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.classRecord?.courseName,
                          'CourseName Not Defined',
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      ),
                      if (widget.classRecord?.courseDescription != null &&
                          widget.classRecord?.courseDescription != '')
                        Text(
                          valueOrDefault<String>(
                            widget.classRecord?.courseDescription,
                            '{courseDescription}',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      builder: (context) => InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'CLASS_INFO_BLOCK_CUSTOM_Icon_ujxprhcs_ON');
                          logFirebaseEvent('Icon_alert_dialog');
                          await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: ConfirmDialogWidget(
                                  title: 'Delete Custom Class?',
                                  description:
                                      'Are you sure you want to delete this custom class? This action is permanent — all associated attendance data will be lost forever and cannot be restored.',
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() =>
                              _model.confirmnationDialogResponse = value));

                          if (_model.confirmnationDialogResponse!) {
                            logFirebaseEvent('Icon_backend_call');
                            await widget.classRecord!.reference.delete();
                            logFirebaseEvent('Icon_backend_call');
                            await NotificationsConfigTable().delete(
                              matchingRows: (rows) => rows
                                  .eqOrNull(
                                    'course_id',
                                    widget.classRecord?.courseID,
                                  )
                                  .eqOrNull(
                                    'user_id',
                                    currentUserUid,
                                  ),
                            );
                            logFirebaseEvent('Icon_custom_action');
                            _model.newCustomClassesAllDay =
                                await actions.removeCourseClasses(
                              widget.classRecord!.courseID,
                              FFAppState().customClassesAlldays.toList(),
                            );
                            logFirebaseEvent('Icon_custom_action');
                            _model.newCustomClassesCurrentDay =
                                await actions.fetchCustomClasses(
                              currentUserReference!,
                              dateTimeFormat(
                                "EEEE",
                                getCurrentTimestamp,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ).toLowerCase(),
                            );
                            logFirebaseEvent('Icon_update_app_state');
                            FFAppState().customClassesAlldays = _model
                                .newCustomClassesAllDay!
                                .toList()
                                .cast<ClassRowStruct>();
                            FFAppState().customClassesCurrentDay = _model
                                .newCustomClassesCurrentDay!
                                .toList()
                                .cast<ClassRowStruct>();
                            FFAppState().customClassesLastUpdatedAt =
                                getCurrentTimestamp;
                          }
                          logFirebaseEvent('Icon_dismiss_dialog');
                          Navigator.pop(context);

                          safeSetState(() {});
                        },
                        child: Icon(
                          FFIcons.ktrash,
                          color: FlutterFlowTheme.of(context).absentRed,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Course Code:',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.classRecord?.courseID,
                        '- - -',
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(width: 4.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Slot:',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.classRecord?.slotData.slotName,
                        '- - -',
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                    ),
                    if (widget.classRecord?.isCustomSlot ?? true)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            width: 100.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFD9D9),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: Color(0xFFFC8484),
                                width: 2.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    7.0, 0.0, 7.0, 0.0),
                                child: Text(
                                  'Custom Slot',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF606A85),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!widget.classRecord!.isCustomSlot)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            width: 110.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF9CC),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: Color(0xFFFBEC81),
                                width: 2.0,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    7.0, 0.0, 7.0, 0.0),
                                child: Text(
                                  'Institute Slot',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF606A85),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ].divide(SizedBox(width: 4.0)),
                ),
              ],
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
                                    'CLASS_INFO_BLOCK_CUSTOM_Switch_5oa1ircf_');
                                logFirebaseEvent('Switch_backend_call');
                                await NotificationsConfigTable().update(
                                  data: {
                                    'toggle_notifications': true,
                                  },
                                  matchingRows: (rows) => rows
                                      .eqOrNull(
                                        'course_id',
                                        widget.classRecord?.courseID,
                                      )
                                      .eqOrNull(
                                        'user_id',
                                        currentUserUid,
                                      ),
                                );
                                logFirebaseEvent('Switch_backend_call');

                                await widget.classRecord!.reference
                                    .update(createCustomClassesRecordData(
                                  toggleNotfications: true,
                                ));
                              } else {
                                logFirebaseEvent(
                                    'CLASS_INFO_BLOCK_CUSTOM_Switch_5oa1ircf_');
                                logFirebaseEvent('Switch_backend_call');
                                await NotificationsConfigTable().update(
                                  data: {
                                    'toggle_notifications': false,
                                  },
                                  matchingRows: (rows) => rows
                                      .eqOrNull(
                                        'course_id',
                                        widget.classRecord?.courseID,
                                      )
                                      .eqOrNull(
                                        'user_id',
                                        currentUserUid,
                                      ),
                                );
                                logFirebaseEvent('Switch_backend_call');

                                await widget.classRecord!.reference
                                    .update(createCustomClassesRecordData(
                                  toggleNotfications: false,
                                ));
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
                      if (valueOrDefault<bool>(
                        widget.classRecord?.toggleNotfications,
                        false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (_model.switchValue == true)
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
                                            'CLASS_INFO_BLOCK_CUSTOM_Icon_hkduj7vy_ON');
                                        logFirebaseEvent('Icon_bottom_sheet');
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child:
                                                  ScheduleRemainderCustomWidget(
                                                courseID: widget
                                                    .classRecord?.courseID,
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
