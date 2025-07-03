import '/auth/firebase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/backend/schema/structs/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_primary_model.dart';
export 'class_block_primary_model.dart';

class ClassBlockPrimaryWidget extends StatefulWidget {
  const ClassBlockPrimaryWidget({
    super.key,
    required this.classRecord,
  });

  final TimetableRecordsRow? classRecord;

  @override
  State<ClassBlockPrimaryWidget> createState() =>
      _ClassBlockPrimaryWidgetState();
}

class _ClassBlockPrimaryWidgetState extends State<ClassBlockPrimaryWidget> {
  late ClassBlockPrimaryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockPrimaryModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AttendanceRecordsRow>>(
      future: FFAppState().individualAttendanceRecord(
        uniqueQueryKey: '${widget.classRecord?.classID}_${currentUserUid}',
        overrideCache: _model.rebuildComponent,
        requestFn: () => AttendanceRecordsTable().querySingleRow(
          queryFn: (q) => q
              .eqOrNull(
                'classID',
                widget.classRecord?.classID,
              )
              .eqOrNull(
                'userID',
                currentUserUid,
              ),
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
        List<AttendanceRecordsRow> containerAttendanceRecordsRowList =
            snapshot.data!;

        final containerAttendanceRecordsRow =
            containerAttendanceRecordsRowList.isNotEmpty
                ? containerAttendanceRecordsRowList.first
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.15,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              dateTimeFormat(
                                "hh:mm",
                                widget.classRecord?.classStartTime,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              '12:00',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              dateTimeFormat(
                                "a",
                                widget.classRecord?.classStartTime,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              'AM',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 110.0,
                    child: VerticalDivider(
                      thickness: 2.0,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.55,
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
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              decoration: BoxDecoration(),
                              child: AutoSizeText(
                                valueOrDefault<String>(
                                  widget.classRecord?.courseName,
                                  'Machine Learning for Data Science and Analytics',
                                ),
                                minFontSize: 12.0,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 16.0,
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 2.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (CourseTypeStruct.maybeFromMap(
                                          widget.classRecord?.courseType)
                                      ?.isLab ??
                                  true)
                                Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    width: 80.0,
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
                                          'Lab',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                              if (CourseTypeStruct.maybeFromMap(
                                          widget.classRecord?.courseType)
                                      ?.courseType ==
                                  'elective')
                                Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    width: 80.0,
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
                                          'Elective',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                              if (CourseTypeStruct.maybeFromMap(
                                          widget.classRecord?.courseType)
                                      ?.courseType ==
                                  'custom')
                                Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    width: 80.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF3E8FF),
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFAC66F8),
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
                                                      FlutterFlowTheme.of(
                                                              context)
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
                              if (CourseTypeStruct.maybeFromMap(
                                          widget.classRecord?.courseType)
                                      ?.courseType ==
                                  'core')
                                Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    width: 80.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF3E8FF),
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFFAC66F8),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            7.0, 0.0, 7.0, 0.0),
                                        child: Text(
                                          'Regular',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                              if (widget.classRecord?.isPlusSlot ?? true)
                                Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    width: 80.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE6E0FF),
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xCA8163FA),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            7.0, 0.0, 7.0, 0.0),
                                        child: Text(
                                          'Plus Slot',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                      ]
                          .addToStart(SizedBox(height: 5.0))
                          .addToEnd(SizedBox(height: 5.0)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.24,
                  height: 100.0,
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
                              containerAttendanceRecordsRow?.classID ==
                                  widget.classRecord?.classID,
                          onChanged: (newValue) async {
                            safeSetState(
                                () => _model.checkboxValue = newValue!);
                            if (newValue!) {
                              logFirebaseEvent(
                                  'CLASS_BLOCK_PRIMARY_Checkbox_jx89frfk_ON');
                              logFirebaseEvent('Checkbox_action_block');
                              _model.attendanceFeedback =
                                  await action_blocks.checkInAttendanceProtocal(
                                context,
                                classID: widget.classRecord?.classID,
                                courseID: widget.classRecord?.courseID,
                                classStartTime:
                                    widget.classRecord?.classStartTime,
                              );
                              logFirebaseEvent('Checkbox_show_snack_bar');
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _model.attendanceFeedback!,
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
                              logFirebaseEvent(
                                  'Checkbox_update_component_state');
                              _model.rebuildComponent = true;
                              safeSetState(() {});

                              safeSetState(() {});
                            } else {
                              logFirebaseEvent(
                                  'CLASS_BLOCK_PRIMARY_Checkbox_jx89frfk_ON');
                              logFirebaseEvent(
                                  'Checkbox_update_component_state');
                              _model.rebuildComponent = false;
                              safeSetState(() {});
                              logFirebaseEvent('Checkbox_action_block');
                              await action_blocks.checkOutAttendanceProtocol(
                                context,
                                userID: currentUserUid,
                                enrolledCourses: (currentUserDocument
                                            ?.coursesEnrolled
                                            .toList() ??
                                        [])
                                    .map((e) => e.courseID)
                                    .toList(),
                                classID: widget.classRecord?.classID,
                                courseID: widget.classRecord?.courseID,
                                classStartTime:
                                    widget.classRecord?.classStartTime,
                                classEndTime: widget.classRecord?.classEndTime,
                                courseName: widget.classRecord?.courseName,
                              );
                              safeSetState(() {});
                              logFirebaseEvent(
                                  'Checkbox_update_component_state');
                              _model.rebuildComponent = true;
                              safeSetState(() {});
                            }
                          },
                          side: (FlutterFlowTheme.of(context).primaryText !=
                                  null)
                              ? BorderSide(
                                  width: 2,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                            containerAttendanceRecordsRow?.classID ==
                                    widget.classRecord?.classID
                                ? 'Marked Attendance'
                                : 'Mark Attendance',
                            'Mark Attendance',
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
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
            ],
          ),
        );
      },
    );
  }
}
