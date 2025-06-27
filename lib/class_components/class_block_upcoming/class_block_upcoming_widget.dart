import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_upcoming_model.dart';
export 'class_block_upcoming_model.dart';

class ClassBlockUpcomingWidget extends StatefulWidget {
  const ClassBlockUpcomingWidget({
    super.key,
    required this.classRecord,
  });

  final TimetableRecordsRow? classRecord;

  @override
  State<ClassBlockUpcomingWidget> createState() =>
      _ClassBlockUpcomingWidgetState();
}

class _ClassBlockUpcomingWidgetState extends State<ClassBlockUpcomingWidget> {
  late ClassBlockUpcomingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockUpcomingModel());

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
      width: MediaQuery.sizeOf(context).width,
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
              width: MediaQuery.sizeOf(context).width * 0.62,
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
                            widget.classRecord?.courseName,
                            'Machine Learning for Data Science and Analytics',
                          ),
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
                      if (CourseTypeStruct.maybeFromMap(
                                  widget.classRecord?.courseType)
                              ?.courseType ==
                          'elective')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              width: 100.0,
                              height: 20.0,
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
                                    () {
                                      if (valueOrDefault<String>(
                                            CourseTypeStruct.maybeFromMap(
                                                    widget.classRecord
                                                        ?.courseType)
                                                ?.electiveCategory,
                                            'null',
                                          ) ==
                                          'OE') {
                                        return 'Open Elective';
                                      } else if (valueOrDefault<String>(
                                            CourseTypeStruct.maybeFromMap(
                                                    widget.classRecord
                                                        ?.courseType)
                                                ?.electiveCategory,
                                            'null',
                                          ) ==
                                          'DE') {
                                        return 'Department Elective';
                                      } else if (valueOrDefault<String>(
                                            CourseTypeStruct.maybeFromMap(
                                                    widget.classRecord
                                                        ?.courseType)
                                                ?.electiveCategory,
                                            'null',
                                          ) ==
                                          'DE') {
                                        return 'Digital Automation';
                                      } else if (valueOrDefault<String>(
                                            CourseTypeStruct.maybeFromMap(
                                                    widget.classRecord
                                                        ?.courseType)
                                                ?.electiveCategory,
                                            'null',
                                          ) ==
                                          'HM') {
                                        return 'Humanities Elective';
                                      } else {
                                        return 'Elective';
                                      }
                                    }(),
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
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                    child: Text(
                      '${dateTimeFormat(
                        "MMMd",
                        widget.classRecord?.classStartTime,
                        locale: FFLocalizations.of(context).languageCode,
                      )} | ${dateTimeFormat(
                        "jm",
                        widget.classRecord?.classStartTime,
                        locale: FFLocalizations.of(context).languageCode,
                      )} - ${dateTimeFormat(
                        "jm",
                        widget.classRecord?.classEndTime,
                        locale: FFLocalizations.of(context).languageCode,
                      )}',
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
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.55,
                    decoration: BoxDecoration(),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
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
                                    'Elective',
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
                              width: 100.0,
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
                              width: 100.0,
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
                        if (widget.classRecord?.isPlusSlot ?? true)
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
                ]
                    .addToStart(SizedBox(height: 5.0))
                    .addToEnd(SizedBox(height: 5.0)),
              ),
            ),
            SizedBox(
              height: 110.0,
              child: VerticalDivider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      decoration: BoxDecoration(),
                      child: Text(
                        valueOrDefault<String>(
                          functions.relativeTime(
                              widget.classRecord!.classStartTime!),
                          'Next Monday',
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
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
    );
  }
}
