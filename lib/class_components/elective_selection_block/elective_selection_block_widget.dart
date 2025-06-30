import '/backend/supabase/supabase.dart';
import '/bottom_sheets/course_search/course_search_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'elective_selection_block_model.dart';
export 'elective_selection_block_model.dart';

class ElectiveSelectionBlockWidget extends StatefulWidget {
  const ElectiveSelectionBlockWidget({
    super.key,
    required this.electiveCoursesCatalog,
    required this.placeholderText,
    required this.placeHolderIcon,
    required this.electiveCategory,
    this.updateCoursesEnrolled,
    this.removeCoursesEnrolled,
  });

  final List<CourseRecordsRow>? electiveCoursesCatalog;
  final String? placeholderText;
  final Widget? placeHolderIcon;
  final String? electiveCategory;
  final Future Function(CourseRecordsRow courseRecord)? updateCoursesEnrolled;
  final Future Function(CourseRecordsRow courseRecord)? removeCoursesEnrolled;

  @override
  State<ElectiveSelectionBlockWidget> createState() =>
      _ElectiveSelectionBlockWidgetState();
}

class _ElectiveSelectionBlockWidgetState
    extends State<ElectiveSelectionBlockWidget> {
  late ElectiveSelectionBlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ElectiveSelectionBlockModel());

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
      builder: (context) {
        if (_model.courseChoosen) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 18.0, 0.0),
            child: Material(
              color: Colors.transparent,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: double.infinity,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 0.0, 6.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                _model.courseRecord?.courseName,
                                '[courseName]',
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
                                    fontSize: 12.0,
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
                                4.0, 0.0, 0.0, 0.0),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Course Code: ',
                                    style: GoogleFonts.outfit(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: valueOrDefault<String>(
                                      _model.courseRecord!.courseID
                                          .substring(0, 7),
                                      'ME1001E',
                                    ),
                                    style: GoogleFonts.outfit(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' | ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Slot: ',
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: valueOrDefault<String>(
                                      _model.courseRecord!.courseID
                                          .substring(9, 11),
                                      'H',
                                    ),
                                    style: GoogleFonts.outfit(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12.0,
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
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'ELECTIVE_SELECTION_BLOCK_Icon_1w1w8wim_O');
                          logFirebaseEvent('Icon_execute_callback');
                          await widget.removeCoursesEnrolled?.call(
                            _model.courseRecord!,
                          );
                          logFirebaseEvent('Icon_update_component_state');
                          _model.userChoosenCourseId = null;
                          _model.courseRecord = null;
                          _model.courseChoosen = false;
                          safeSetState(() {});
                        },
                        child: Icon(
                          Icons.highlight_off_outlined,
                          color: FlutterFlowTheme.of(context).error,
                          size: 26.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (!_model.courseChoosen &&
            valueOrDefault<bool>(
              _model.skipElectiveSelection,
              false,
            )) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 18.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ELECTIVE_SELECTION_BLOCK_Container_aky5e');
                logFirebaseEvent('Container_bottom_sheet');
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: CourseSearchWidget(
                        electiveCatelog: widget.electiveCoursesCatalog!
                            .where((e) =>
                                CourseTypeStruct.maybeFromMap(e.courseType)
                                    ?.electiveCategory ==
                                widget.electiveCategory)
                            .toList(),
                        electiveType: widget.electiveCategory!,
                        callback: (courseId, skipSelection) async {
                          logFirebaseEvent('_backend_call');
                          _model.courseRecordRow =
                              await CourseRecordsTable().queryRows(
                            queryFn: (q) => q.eqOrNull(
                              'courseID',
                              courseId,
                            ),
                          );
                          if (skipSelection!) {
                            logFirebaseEvent('_update_component_state');
                            _model.courseChoosen = false;
                            _model.skipElectiveSelection = true;
                            safeSetState(() {});
                          } else {
                            logFirebaseEvent('_update_component_state');
                            _model.courseRecord =
                                _model.courseRecordRow?.firstOrNull;
                            _model.courseChoosen = true;
                            _model.userChoosenCourseId = courseId;
                            _model.skipElectiveSelection = false;
                            safeSetState(() {});
                          }
                        },
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));

                if (!_model.skipElectiveSelection) {
                  logFirebaseEvent('Container_execute_callback');
                  await widget.updateCoursesEnrolled?.call(
                    _model.courseRecord!,
                  );
                }

                safeSetState(() {});
              },
              child: Material(
                color: Colors.transparent,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                '${widget.electiveCategory} Elective Selection Skipped',
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
                                      fontSize: 14.0,
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
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 15.0, 0.0),
                            child: Icon(
                              Icons.sync_outlined,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (valueOrDefault<bool>(
          !_model.courseChoosen && !_model.skipElectiveSelection,
          true,
        )) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 18.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ELECTIVE_SELECTION_BLOCK_Container_rwo1y');
                logFirebaseEvent('Container_bottom_sheet');
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: CourseSearchWidget(
                        electiveCatelog: widget.electiveCoursesCatalog!
                            .where((e) =>
                                CourseTypeStruct.maybeFromMap(e.courseType)
                                    ?.electiveCategory ==
                                widget.electiveCategory)
                            .toList(),
                        electiveType: widget.electiveCategory!,
                        callback: (courseId, skipSelection) async {
                          logFirebaseEvent('_backend_call');
                          _model.courseRecordRow2 =
                              await CourseRecordsTable().queryRows(
                            queryFn: (q) => q.eqOrNull(
                              'courseID',
                              courseId,
                            ),
                          );
                          if (!skipSelection!) {
                            logFirebaseEvent('_update_component_state');
                            _model.courseRecord =
                                _model.courseRecordRow2?.firstOrNull;
                            _model.courseChoosen = true;
                            _model.userChoosenCourseId = courseId;
                            safeSetState(() {});
                          }
                        },
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));

                if (!_model.skipElectiveSelection) {
                  logFirebaseEvent('Container_execute_callback');
                  await widget.updateCoursesEnrolled?.call(
                    _model.courseRecord!,
                  );
                }

                safeSetState(() {});
              },
              child: Material(
                color: Colors.transparent,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            widget.placeHolderIcon!,
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.placeholderText,
                                  'Choose Your Elective',
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
                                      fontSize: 14.0,
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
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 15.0, 0.0),
                            child: Icon(
                              FFIcons.karrowRight,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 18.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ELECTIVE_SELECTION_BLOCK_Container_zvbww');
                logFirebaseEvent('Container_bottom_sheet');
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: CourseSearchWidget(
                        electiveCatelog: widget.electiveCoursesCatalog!
                            .where((e) =>
                                CourseTypeStruct.maybeFromMap(e.courseType)
                                    ?.electiveCategory ==
                                widget.electiveCategory)
                            .toList(),
                        electiveType: widget.electiveCategory!,
                        callback: (courseId, skipSelection) async {
                          logFirebaseEvent('_backend_call');
                          _model.courseRecordRow3 =
                              await CourseRecordsTable().queryRows(
                            queryFn: (q) => q.eqOrNull(
                              'courseID',
                              courseId,
                            ),
                          );
                          if (skipSelection!) {
                            logFirebaseEvent('_update_component_state');
                            _model.courseChoosen = false;
                            _model.skipElectiveSelection = true;
                            safeSetState(() {});
                          } else {
                            logFirebaseEvent('_update_component_state');
                            _model.courseRecord =
                                _model.courseRecordRow3?.firstOrNull;
                            _model.courseChoosen = true;
                            _model.userChoosenCourseId = courseId;
                            _model.skipElectiveSelection = false;
                            safeSetState(() {});
                          }
                        },
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));

                if (!_model.skipElectiveSelection) {
                  logFirebaseEvent('Container_execute_callback');
                  await widget.updateCoursesEnrolled?.call(
                    _model.courseRecord!,
                  );
                }

                safeSetState(() {});
              },
              child: Material(
                color: Colors.transparent,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                '${widget.electiveCategory} Elective Selection Skipped',
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
                                      fontSize: 14.0,
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
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 15.0, 0.0),
                            child: Icon(
                              Icons.sync_outlined,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
