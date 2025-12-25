import '/backend/supabase/supabase.dart';
import '/bottom_sheets/course_search/course_search_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'elective_block_model.dart';
export 'elective_block_model.dart';

class ElectiveBlockWidget extends StatefulWidget {
  const ElectiveBlockWidget({
    super.key,
    String? electiveCategory,
    this.electiveCatelogUnfiltered,
    this.addElective,
    this.removeElective,
    this.isElectiveSkipped,
    bool? electiveSkipped,
  })  : this.electiveCategory = electiveCategory ?? 'OE',
        this.electiveSkipped = electiveSkipped ?? false;

  final String electiveCategory;
  final List<CourseRecordsRow>? electiveCatelogUnfiltered;
  final Future Function(CourseRecordsRow electiveRecord)? addElective;
  final Future Function(CourseRecordsRow electiveRecord)? removeElective;
  final Future Function(String electiveCategory)? isElectiveSkipped;
  final bool electiveSkipped;

  @override
  State<ElectiveBlockWidget> createState() => _ElectiveBlockWidgetState();
}

class _ElectiveBlockWidgetState extends State<ElectiveBlockWidget> {
  late ElectiveBlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ElectiveBlockModel());

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
        if (valueOrDefault<bool>(
          !_model.isElectiveSelected &&
              !_model.isElectiveSelectionSkipped &&
              !widget.electiveSkipped,
          true,
        )) {
          return Builder(
            builder: (context) => InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('ELECTIVE_BLOCK_Container_825b7ubl_ON_TAP');
                if (!valueOrDefault<bool>(
                  _model.isElectiveSelected ||
                      _model.isElectiveSelectionSkipped,
                  true,
                )) {
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
                        child: CourseSearchWidget(
                          electiveCatelog: widget.electiveCatelogUnfiltered!
                              .where((e) =>
                                  CourseTypeStruct.maybeFromMap(e.courseType)
                                      ?.electiveCategory ==
                                  widget.electiveCategory)
                              .toList(),
                          electiveType: widget.electiveCategory,
                          callback: (courseRecord, skipSelection) async {
                            if (skipSelection == true) {
                              logFirebaseEvent('_update_component_state');
                              _model.isElectiveSelectionSkipped = true;
                              _model.isElectiveSelected = false;
                              safeSetState(() {});
                            } else {
                              logFirebaseEvent('_update_component_state');
                              _model.isElectiveSelectionSkipped = false;
                              _model.isElectiveSelected = true;
                              _model.selectedElectiveRecord = courseRecord;
                              safeSetState(() {});
                            }
                          },
                        ),
                      );
                    },
                  );

                  if (_model.isElectiveSelectionSkipped) {
                    logFirebaseEvent('Container_execute_callback');
                    await widget.isElectiveSkipped?.call(
                      widget.electiveCategory,
                    );
                  }
                }
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
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kcompass,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: AutoSizeText(
                                    valueOrDefault<String>(
                                      () {
                                        if ((widget.electiveCategory ==
                                                'OE') ||
                                            (widget.electiveCategory ==
                                                'DE')) {
                                          return 'Choose Your Open Elective';
                                        } else if (widget.electiveCategory ==
                                            'DA') {
                                          return 'Choose Your Digital Automation Elective';
                                        } else {
                                          return 'Choose Your Elective';
                                        }
                                      }(),
                                      'Choose Your Elective',
                                    ),
                                    maxLines: 1,
                                    minFontSize: 8.0,
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
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
        } else if (valueOrDefault<bool>(
          _model.isElectiveSelected &&
              !_model.isElectiveSelectionSkipped &&
              !widget.electiveSkipped,
          true,
        )) {
          return Material(
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
                    padding: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 0.0, 6.0),
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
                              _model.selectedElectiveRecord?.courseName,
                              'Course Name',
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
                                    _model.selectedElectiveRecord!.courseID
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
                                    _model.selectedElectiveRecord!.courseID
                                        .substring(9, 11),
                                    'ME1001E',
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
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'ELECTIVE_BLOCK_COMP_Icon_4e9vpskf_ON_TAP');
                        logFirebaseEvent('Icon_execute_callback');
                        await widget.removeElective?.call(
                          _model.selectedElectiveRecord!,
                        );
                        logFirebaseEvent('Icon_update_component_state');
                        _model.isElectiveSelected = false;
                        _model.selectedElectiveRecord = null;
                        _model.isElectiveSelectionSkipped = false;
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
          );
        } else {
          return Material(
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
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
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
                            ' Elective Selection Skipped',
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
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'ELECTIVE_BLOCK_COMP_Icon_mw4101je_ON_TAP');
                            logFirebaseEvent('Icon_execute_callback');
                            await widget.removeElective?.call(
                              _model.selectedElectiveRecord!,
                            );
                            logFirebaseEvent('Icon_update_component_state');
                            _model.isElectiveSelected = false;
                            _model.isElectiveSelectionSkipped = false;
                            _model.selectedElectiveRecord = null;
                            safeSetState(() {});
                          },
                          child: Icon(
                            Icons.sync_outlined,
                            color: FlutterFlowTheme.of(context).info,
                            size: 24.0,
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
      },
    );
  }
}
