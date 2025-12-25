import '/backend/schema/structs/index.dart';
import '/components/attendance_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'course_attendance_model.dart';
export 'course_attendance_model.dart';

class CourseAttendanceWidget extends StatefulWidget {
  const CourseAttendanceWidget({
    super.key,
    required this.courseData,
    bool? isCustomClass,
  }) : this.isCustomClass = isCustomClass ?? false;

  final CoursesEnrolledStruct? courseData;
  final bool isCustomClass;

  @override
  State<CourseAttendanceWidget> createState() => _CourseAttendanceWidgetState();
}

class _CourseAttendanceWidgetState extends State<CourseAttendanceWidget> {
  late CourseAttendanceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CourseAttendanceModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 8.0, 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AutoSizeText(
                          valueOrDefault<String>(
                            widget.courseData?.courseName,
                            '[courseName]',
                          ),
                          maxLines: 1,
                          minFontSize: 10.0,
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                        if (widget.isCustomClass)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                6.0, 0.0, 0.0, 0.0),
                            child: Container(
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: Color(0x76F94F06),
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                  color: Color(0x80F44D04),
                                  width: 2.0,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 8.0, 0.0),
                                  child: Text(
                                    'Custom',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (!valueOrDefault<bool>(
                      widget.isCustomClass,
                      true,
                    ))
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'COURSE_ATTENDANCE_Icon_olt1lecs_ON_TAP');
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
                                  child: AttendanceDropdownWidget(
                                    courseID: widget.courseData!.courseID,
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            FFIcons.kdotsThreeBold,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.courseData?.attendedClasses.toString(),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        TextSpan(
                          text: '/',
                          style: GoogleFonts.outfit(
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.courseData?.totalClasses.toString(),
                            '0',
                          ),
                          style: GoogleFonts.outfit(
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Attended',
                          style: GoogleFonts.outfit(
                            color: FlutterFlowTheme.of(context).tertiary,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelSmallIsCustom,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                    child: RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: valueOrDefault<String>(
                              ((int var1, int var2) {
                                return var2 == 0
                                    ? 0.0
                                    : double.parse(((var1 / var2) * 100)
                                        .toStringAsFixed(1));
                              }(widget.courseData!.attendedClasses,
                                      widget.courseData!.totalClasses))
                                  .toString(),
                              '0',
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          TextSpan(
                            text: '%',
                            style: GoogleFonts.outfit(
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelSmallIsCustom,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              LinearPercentIndicator(
                percent: valueOrDefault<double>(
                  (int var1, int var2) {
                    return var2 == 0
                        ? 0.0
                        : double.parse((var1 / var1).toStringAsFixed(2));
                  }(widget.courseData!.attendedClasses,
                      widget.courseData!.totalClasses),
                  0.0,
                ),
                lineHeight: 12.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: valueOrDefault<Color>(
                  FFAppConstants.colours.elementAtOrNull(
                      functions.randomNumberGenerator(
                          0, 9, widget.courseData!.courseID)),
                  FlutterFlowTheme.of(context).velvetSky,
                ),
                backgroundColor: FlutterFlowTheme.of(context).accent1,
                center: Text(
                  '${valueOrDefault<String>(
                    ((int var1, int var2) {
                      return var2 == 0
                          ? 0.0
                          : double.parse(
                              ((var1 / var2) * 100).toStringAsFixed(1));
                    }(widget.courseData!.attendedClasses,
                            widget.courseData!.totalClasses))
                        .toString(),
                    '0',
                  )}%',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 8.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                      ),
                ),
                barRadius: Radius.circular(16.0),
                padding: EdgeInsets.zero,
              ),
              Align(
                alignment: AlignmentDirectional(-1.0, -1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 4.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      functions.generateAttendanceRemarks(
                          widget.courseData!.courseType.isLab,
                          valueOrDefault<int>(
                            widget.courseData?.totalClasses,
                            0,
                          ),
                          valueOrDefault<int>(
                            widget.courseData?.attendedClasses,
                            0,
                          )),
                      'Ghosted all your classes? JK, no classes tracked yet 👻.',
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 10.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
