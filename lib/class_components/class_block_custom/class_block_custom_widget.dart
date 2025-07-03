import '/auth/firebase_auth/auth_util.dart';
import '/auth_pages/class_management/cancel_custom_class/cancel_custom_class_widget.dart';
import '/backend/backend.dart';
import '/components/class_check_in_dialog_widget.dart';
import '/components/class_check_out_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_custom_model.dart';
export 'class_block_custom_model.dart';

class ClassBlockCustomWidget extends StatefulWidget {
  const ClassBlockCustomWidget({
    super.key,
    required this.courseID,
    required this.courseName,
    required this.classStartTime,
    required this.classEndTime,
    this.weekday,
  });

  final String? courseID;
  final String? courseName;
  final DateTime? classStartTime;
  final DateTime? classEndTime;
  final DateTime? weekday;

  @override
  State<ClassBlockCustomWidget> createState() => _ClassBlockCustomWidgetState();
}

class _ClassBlockCustomWidgetState extends State<ClassBlockCustomWidget> {
  late ClassBlockCustomModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockCustomModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CLASS_BLOCK_CUSTOM_classBlock_custom_ON_');
      logFirebaseEvent('classBlock_custom_custom_action');
      _model.isCancelledQuery = await actions.checkClassCancellation(
        widget.courseID!,
        widget.classStartTime!,
        currentUserReference!,
      );
      logFirebaseEvent('classBlock_custom_update_component_state');
      _model.isCancelled = valueOrDefault<bool>(
        _model.isCancelledQuery,
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
      builder: (context) => StreamBuilder<List<CustomClassesRecord>>(
        stream: FFAppState().individualCustomClassViaCourseID(
          uniqueQueryKey: '${widget.courseID}_${currentUserUid}',
          overrideCache: _model.hasChanges,
          requestFn: () => queryCustomClassesRecord(
            parent: currentUserReference,
            queryBuilder: (customClassesRecord) => customClassesRecord.where(
              'courseID',
              isEqualTo: widget.courseID,
            ),
            singleRecord: true,
          ),
        ),
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
          List<CustomClassesRecord> containerCustomClassesRecordList =
              snapshot.data!;
          final containerCustomClassesRecord =
              containerCustomClassesRecordList.isNotEmpty
                  ? containerCustomClassesRecordList.first
                  : null;

          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('CLASS_BLOCK_CUSTOM_Container_ovrmgd2i_ON');
              if (!containerCustomClassesRecord!.attendedClasses
                      .contains(widget.classStartTime) &&
                  !_model.isCancelled) {
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
                        classID: widget.courseID!,
                        isCustomClass: true,
                      ),
                    );
                  },
                );
              } else if (containerCustomClassesRecord.attendedClasses
                      .contains(widget.classStartTime) &&
                  !_model.isCancelled) {
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
                        classID: widget.courseID!,
                        courseID: widget.courseID!,
                        classStartTime: widget.classStartTime!,
                        className: widget.courseName,
                        isCustomClass: true,
                        classEndTime: widget.classEndTime!,
                        courseName: widget.courseName!,
                      ),
                    );
                  },
                );
              }

              if (!_model.isCancelled) {
                logFirebaseEvent('Container_custom_action');
                _model.isCancelledRefreshed =
                    await actions.checkClassCancellation(
                  widget.courseID!,
                  widget.classStartTime!,
                  currentUserReference!,
                );
              }
              logFirebaseEvent('Container_update_component_state');
              _model.hasChanges = true;
              _model.isCancelled = _model.isCancelledRefreshed!;
              safeSetState(() {});

              safeSetState(() {});
            },
            child: Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  () {
                    if (_model.isCancelled) {
                      return FlutterFlowTheme.of(context).secondaryText;
                    } else if (containerCustomClassesRecord!.attendedClasses
                        .contains(widget.classStartTime)) {
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            valueOrDefault<String>(
                              widget.courseName,
                              'courseName Not Found!',
                            ),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: dateTimeFormat(
                                        "MMMMEEEEd",
                                        widget.weekday,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      style: GoogleFonts.outfit(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ', ',
                                      style: GoogleFonts.outfit(
                                        color:
                                            FlutterFlowTheme.of(context).info,
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
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 11.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
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
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
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
                                      'CLASS_BLOCK_CUSTOM_Icon_frg09hg1_ON_TAP');
                                  logFirebaseEvent('Icon_alert_dialog');
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: CancelCustomClassWidget(
                                          courseName: widget.courseName!,
                                          courseID: widget.courseID!,
                                          classStartTime:
                                              widget.classStartTime!,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  FFIcons.kxCircleCloseDelete,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 25.0,
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
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
                            visible: _model.isCancelled,
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
          );
        },
      ),
    );
  }
}
