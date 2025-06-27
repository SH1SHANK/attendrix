import '/auth/firebase_auth/auth_util.dart';
import '/components/class_check_in_dialog_widget.dart';
import '/components/class_check_out_dialog_widget.dart';
import '/components/past_class_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_general_model.dart';
export 'class_block_general_model.dart';

class ClassBlockGeneralWidget extends StatefulWidget {
  const ClassBlockGeneralWidget({
    super.key,
    required this.classID,
    required this.courseID,
    required this.courseName,
    required this.classStartTime,
    required this.classEndTime,
    bool? isCustomClass,
    this.weekday,
  }) : this.isCustomClass = isCustomClass ?? false;

  final String? classID;
  final String? courseID;
  final String? courseName;
  final DateTime? classStartTime;
  final DateTime? classEndTime;
  final bool isCustomClass;
  final DateTime? weekday;

  @override
  State<ClassBlockGeneralWidget> createState() =>
      _ClassBlockGeneralWidgetState();
}

class _ClassBlockGeneralWidgetState extends State<ClassBlockGeneralWidget> {
  late ClassBlockGeneralModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockGeneralModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CLASS_BLOCK_GENERAL_classBlock_general_O');
      logFirebaseEvent('classBlock_general_custom_action');
      _model.classAttendance = await actions.checkClassAttendance(
        widget.courseID!,
        widget.classStartTime!,
        currentUserUid,
        false,
        currentUserReference!,
        widget.classID!,
      );
      if (widget.isCustomClass) {
        logFirebaseEvent('classBlock_general_custom_action');
        _model.isCancelledQuery = await actions.checkClassCancellation(
          widget.courseID!,
          widget.classStartTime!,
          currentUserReference!,
        );
        logFirebaseEvent('classBlock_general_update_component_stat');
        _model.isCancelled = valueOrDefault<bool>(
          _model.isCancelledQuery,
          false,
        );
        safeSetState(() {});
      }
      logFirebaseEvent('classBlock_general_update_component_stat');
      _model.isAttended = valueOrDefault<bool>(
        _model.classAttendance,
        false,
      );
      safeSetState(() {});
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
    return Builder(
      builder: (context) => InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          logFirebaseEvent('CLASS_BLOCK_GENERAL_Container_mk5y0i5v_O');
          if (!_model.isAttended && !_model.isCancelled) {
            logFirebaseEvent('Container_alert_dialog');
            await showDialog(
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: ClassCheckInDialogWidget(
                    courseID: widget.courseID!,
                    className: widget.courseName!,
                    classStartTime: widget.classStartTime!,
                    classID: widget.classID!,
                    isCustomClass: widget.isCustomClass,
                  ),
                );
              },
            );
          } else if (_model.isAttended && !_model.isCancelled) {
            logFirebaseEvent('Container_alert_dialog');
            await showDialog(
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: ClassCheckOutDialogWidget(
                    classID: widget.classID!,
                    courseID: widget.courseID!,
                    classStartTime: widget.classStartTime!,
                    className: widget.courseName,
                    isCustomClass: widget.isCustomClass,
                  ),
                );
              },
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: 45.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              () {
                if (_model.isCancelled) {
                  return FlutterFlowTheme.of(context).secondaryText;
                } else if (_model.isAttended) {
                  return FlutterFlowTheme.of(context).presentGreen;
                } else {
                  return FlutterFlowTheme.of(context).error;
                }
              }(),
              FlutterFlowTheme.of(context).absentRed,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          widget.courseName,
                          'courseName Not Found!',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).info,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 12.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.isCustomClass
                                      ? dateTimeFormat(
                                          "MMMMEEEEd",
                                          widget.weekday,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )
                                      : dateTimeFormat(
                                          "MMMMEEEEd",
                                          widget.classStartTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 10.0,
                                  ),
                                ),
                                TextSpan(
                                  text: ', ',
                                  style: GoogleFonts.outfit(
                                    color: FlutterFlowTheme.of(context).info,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0,
                                  ),
                                ),
                                TextSpan(
                                  text: dateTimeFormat(
                                    "jm",
                                    widget.classStartTime,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 11.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                TextSpan(
                                  text: ' - ',
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                ),
                                TextSpan(
                                  text: dateTimeFormat(
                                    "jm",
                                    widget.classEndTime,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0,
                                  ),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!_model.isCancelled)
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 8.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'CLASS_BLOCK_GENERAL_Icon_sxve31ai_ON_TAP');
                              logFirebaseEvent('Icon_alert_dialog');
                              await showAlignedDialog(
                                context: context,
                                isGlobal: false,
                                avoidOverflow: true,
                                targetAnchor: AlignmentDirectional(-1.0, 1.0)
                                    .resolve(Directionality.of(context)),
                                followerAnchor: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                builder: (dialogContext) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: PastClassDropdownWidget(
                                      classID: widget.classID!,
                                      courseID: widget.courseID!,
                                      classStartTime:
                                          functions.convertToDateTime(widget
                                              .classStartTime!
                                              .toString()),
                                      className: widget.courseName!,
                                      isCustomClass: widget.isCustomClass,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.filter_list,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                    AlignedTooltip(
                      content: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'This Class was Marked As Cancelled',
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                        ),
                      ),
                      offset: 6.0,
                      preferredDirection: AxisDirection.down,
                      borderRadius: BorderRadius.circular(12.0),
                      backgroundColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      elevation: 4.0,
                      tailBaseWidth: 28.0,
                      tailLength: 18.0,
                      waitDuration: Duration(milliseconds: 100),
                      showDuration: Duration(milliseconds: 1500),
                      triggerMode: TooltipTriggerMode.tap,
                      child: Visibility(
                        visible: _model.isCancelled && widget.isCustomClass,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/Alert_Animated_Icon_(1).gif',
                            width: 34.0,
                            height: 34.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
