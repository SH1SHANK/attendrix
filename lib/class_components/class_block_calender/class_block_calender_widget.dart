import '/backend/supabase/supabase.dart';
import '/components/calender_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_calender_model.dart';
export 'class_block_calender_model.dart';

class ClassBlockCalenderWidget extends StatefulWidget {
  const ClassBlockCalenderWidget({
    super.key,
    this.timetableRecord,
  });

  final TimetableRecordsRow? timetableRecord;

  @override
  State<ClassBlockCalenderWidget> createState() =>
      _ClassBlockCalenderWidgetState();
}

class _ClassBlockCalenderWidgetState extends State<ClassBlockCalenderWidget> {
  late ClassBlockCalenderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockCalenderModel());

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
      width: MediaQuery.sizeOf(context).width * 0.85,
      height: valueOrDefault<double>(
        functions.elapsedTime(widget.timetableRecord!.classStartTime!,
                widget.timetableRecord!.classEndTime!, 'MM') *
            2,
        100.0,
      ),
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          FFAppConstants.colours.elementAtOrNull(functions
              .randomNumberGenerator(0, 9, widget.timetableRecord!.courseID)),
          FlutterFlowTheme.of(context).velvetSky,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 5.0, 6.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AutoSizeText(
                    valueOrDefault<String>(
                      widget.timetableRecord?.courseName,
                      'Machine Learning for Data Science and Analytics',
                    ),
                    maxLines: 2,
                    minFontSize: 10.0,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                Builder(
                  builder: (context) => Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'CLASS_BLOCK_CALENDER_Icon_vr0baviy_ON_TA');
                        logFirebaseEvent('Icon_alert_dialog');
                        await showAlignedDialog(
                          context: context,
                          isGlobal: false,
                          avoidOverflow: true,
                          targetAnchor: AlignmentDirectional(-1.0, 1.0)
                              .resolve(Directionality.of(context)),
                          followerAnchor: AlignmentDirectional(1.0, -1.0)
                              .resolve(Directionality.of(context)),
                          builder: (dialogContext) {
                            return Material(
                              color: Colors.transparent,
                              child: CalenderDropdownWidget(
                                classID: widget.timetableRecord!.classID,
                                courseID: widget.timetableRecord!.courseID,
                                classStartTime:
                                    widget.timetableRecord!.classStartTime!,
                                className: widget.timetableRecord!.courseName!,
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.info_sharp,
                        color: FlutterFlowTheme.of(context).info,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: valueOrDefault<String>(
                          dateTimeFormat(
                            "jm",
                            widget.timetableRecord?.classStartTime,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '10:00 AM',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).info,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      TextSpan(
                        text: ' - ',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(
                        text: valueOrDefault<String>(
                          dateTimeFormat(
                            "jm",
                            widget.timetableRecord?.classEndTime,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '11:00 AM',
                        ),
                        style: GoogleFonts.outfit(
                          color: FlutterFlowTheme.of(context).info,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(
                        text: ' | ',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(
                        text: 'slot: ',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(
                        text: valueOrDefault<String>(
                          widget.timetableRecord!.courseID.substring(9, 11),
                          'H1',
                        ),
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).tertiary,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ],
            ),
          ),
          if (valueOrDefault<double>(
                functions.elapsedTime(widget.timetableRecord!.classStartTime!,
                        widget.timetableRecord!.classEndTime!, 'MM') *
                    2,
                100.0,
              ) >
              150.0)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(14.0, 2.0, 12.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FFIcons.klocationMapPin1,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 14.0,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        widget.timetableRecord?.classVenue,
                        'NLHC 301',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 12.0,
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (widget.timetableRecord?.isPlusSlot ?? true)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: 100.0,
                        height: 32.0,
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
                                      fontStyle: FlutterFlowTheme.of(context)
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
                if (CourseTypeStruct.maybeFromMap(
                            widget.timetableRecord?.courseType)
                        ?.isLab ??
                    true)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: 100.0,
                        height: 32.0,
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
                                      fontStyle: FlutterFlowTheme.of(context)
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
                if (CourseTypeStruct.maybeFromMap(
                            widget.timetableRecord?.courseType)
                        ?.courseType ==
                    'elective')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: 100.0,
                        height: 32.0,
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
                                      fontStyle: FlutterFlowTheme.of(context)
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
                if (CourseTypeStruct.maybeFromMap(
                            widget.timetableRecord?.courseType)
                        ?.courseType ==
                    'custom')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: 100.0,
                        height: 32.0,
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
                                      fontStyle: FlutterFlowTheme.of(context)
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
                if (CourseTypeStruct.maybeFromMap(
                            widget.timetableRecord?.courseType)
                        ?.courseType ==
                    'core')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: 100.0,
                        height: 32.0,
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
                                      fontStyle: FlutterFlowTheme.of(context)
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
