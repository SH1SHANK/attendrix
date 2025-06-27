import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_missed_model.dart';
export 'class_block_missed_model.dart';

class ClassBlockMissedWidget extends StatefulWidget {
  const ClassBlockMissedWidget({
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
  final DateTime? classStartTime;
  final DateTime? classEndTime;
  final bool isCustomClass;

  @override
  State<ClassBlockMissedWidget> createState() => _ClassBlockMissedWidgetState();
}

class _ClassBlockMissedWidgetState extends State<ClassBlockMissedWidget> {
  late ClassBlockMissedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockMissedModel());

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
      height: 45.0,
      decoration: BoxDecoration(
        color: Color(0xFF7B6FF8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.courseName,
                      'CourseName Undefined',
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 12.0, 0.0),
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
                                widget.classStartTime,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                            TextSpan(
                              text: ', ',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0,
                              ),
                            ),
                            TextSpan(
                              text: dateTimeFormat(
                                "jm",
                                widget.classStartTime,
                                locale:
                                    FFLocalizations.of(context).languageCode,
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
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            TextSpan(
                              text: ' - ',
                              style: GoogleFonts.outfit(
                                color: FlutterFlowTheme.of(context).info,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: dateTimeFormat(
                                "jm",
                                widget.classEndTime,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              style: GoogleFonts.outfit(
                                color: FlutterFlowTheme.of(context).info,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            )
                          ],
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
          ],
        ),
      ),
    );
  }
}
