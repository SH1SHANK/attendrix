import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_secondary_model.dart';
export 'class_block_secondary_model.dart';

class ClassBlockSecondaryWidget extends StatefulWidget {
  const ClassBlockSecondaryWidget({
    super.key,
    required this.classID,
    required this.courseID,
    required this.courseName,
    required this.classStartTime,
    required this.classEndTime,
    bool? isCustomClass,
  }) : this.isCustomClass = isCustomClass ?? false;

  final String? classID;
  final String? courseID;
  final String? courseName;
  final String? classStartTime;
  final String? classEndTime;
  final bool isCustomClass;

  @override
  State<ClassBlockSecondaryWidget> createState() =>
      _ClassBlockSecondaryWidgetState();
}

class _ClassBlockSecondaryWidgetState extends State<ClassBlockSecondaryWidget> {
  late ClassBlockSecondaryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockSecondaryModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CLASS_BLOCK_SECONDARY_classBlock_seconda');
      logFirebaseEvent('classBlock_secondary_custom_action');
      _model.isAttended = await actions.checkClassAttendance(
        widget.courseID!,
        currentUserDocument!.createdTime!,
        currentUserUid,
        true,
        currentUserReference!,
        widget.classID!,
      );
      logFirebaseEvent('classBlock_secondary_update_component_st');
      _model.attendanceMarked = _model.isAttended!;
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
    return FutureBuilder<List<CustomClassesRecord>>(
      future: queryCustomClassesRecordOnce(
        parent: currentUserReference,
        queryBuilder: (customClassesRecord) => customClassesRecord.where(
          'courseID',
          isEqualTo: widget.courseID,
        ),
        singleRecord: true,
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

        return Container(
          width: double.infinity,
          height: 85.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 3.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  1.0,
                ),
              )
            ],
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.65,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.62,
                            decoration: BoxDecoration(),
                            child: Text(
                              valueOrDefault<String>(
                                widget.courseName,
                                'CourseName Not Defined',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '${dateTimeFormat(
                            "MMMEd",
                            getCurrentTimestamp,
                            locale: FFLocalizations.of(context).languageCode,
                          )} | ${dateTimeFormat(
                            "jm",
                            functions
                                .convertToDateTime(widget.classStartTime!),
                            locale: FFLocalizations.of(context).languageCode,
                          )} - ${dateTimeFormat(
                            "jm",
                            functions.convertToDateTime(widget.classEndTime!),
                            locale: FFLocalizations.of(context).languageCode,
                          )}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Material(
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
                                      'Custom',
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
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ].divide(SizedBox(height: 2.0)),
                  ),
                ),
                SizedBox(
                  height: 120.0,
                  child: VerticalDivider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Theme(
                                data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                    visualDensity: VisualDensity.compact,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                  unselectedWidgetColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                child: Checkbox(
                                  value: _model.checkboxValue ??=
                                      containerCustomClassesRecord
                                              ?.attendedClasses
                                              .contains(functions
                                                  .convertToDateTime(widget
                                                      .classStartTime!)) !=
                                          null,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.checkboxValue = newValue!);
                                    if (newValue!) {
                                      logFirebaseEvent(
                                          'CLASS_BLOCK_SECONDARY_Checkbox_htwgpqv1_');
                                      logFirebaseEvent(
                                          'Checkbox_custom_action');
                                      _model.checkInStatus =
                                          await actions.checkInToCustomClasses(
                                        widget.courseID!,
                                        currentUserReference!,
                                        functions.convertToDateTime(
                                            widget.classStartTime!),
                                      );
                                      logFirebaseEvent(
                                          'Checkbox_custom_action');
                                      await actions.markClassAttendance(
                                        widget.courseID!,
                                        functions.convertToDateTime(
                                            widget.classStartTime!),
                                        currentUserUid,
                                        true,
                                        widget.classID!,
                                      );
                                      logFirebaseEvent(
                                          'Checkbox_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _model.checkInStatus!,
                                            style: GoogleFonts.outfit(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                        ),
                                      );

                                      safeSetState(() {});
                                    } else {
                                      logFirebaseEvent(
                                          'CLASS_BLOCK_SECONDARY_Checkbox_htwgpqv1_');
                                      logFirebaseEvent(
                                          'Checkbox_custom_action');
                                      _model.removeAttendanceFeedback =
                                          await actions
                                              .removeCustomClassAttendance(
                                        widget.courseID!,
                                        currentUserReference!,
                                        functions.convertToDateTime(
                                            widget.classStartTime!),
                                      );
                                      logFirebaseEvent(
                                          'Checkbox_custom_action');
                                      await actions.markClassAbsence(
                                        widget.courseID!,
                                        functions.convertToDateTime(
                                            widget.classStartTime!),
                                        currentUserUid,
                                        true,
                                        widget.classID!,
                                      );
                                      logFirebaseEvent(
                                          'Checkbox_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _model.removeAttendanceFeedback!,
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .labelLargeIsCustom,
                                                ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                        ),
                                      );

                                      safeSetState(() {});
                                    }
                                  },
                                  side: (FlutterFlowTheme.of(context)
                                              .primaryText !=
                                          null)
                                      ? BorderSide(
                                          width: 2,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        )
                                      : null,
                                  activeColor: Colors.green,
                                  checkColor: FlutterFlowTheme.of(context).info,
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.18,
                                decoration: BoxDecoration(),
                                child: Text(
                                  valueOrDefault<String>(
                                    _model.attendanceMarked
                                        ? 'Marked Attendance'
                                        : 'Mark Attendance',
                                    'Mark Attendance',
                                  ),
                                  textAlign: TextAlign.center,
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
                                        fontSize: 10.0,
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
