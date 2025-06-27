import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/edit_tasks_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'assignment_block_model.dart';
export 'assignment_block_model.dart';

class AssignmentBlockWidget extends StatefulWidget {
  const AssignmentBlockWidget({
    super.key,
    required this.taskRecord,
    int? indexInList,
  }) : this.indexInList = indexInList ?? 0;

  final TaskRecordsRow? taskRecord;
  final int indexInList;

  @override
  State<AssignmentBlockWidget> createState() => _AssignmentBlockWidgetState();
}

class _AssignmentBlockWidgetState extends State<AssignmentBlockWidget>
    with TickerProviderStateMixin {
  late AssignmentBlockModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssignmentBlockModel());

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);
    animationsMap.addAll({
      'expandableOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: valueOrDefault<double>(
              widget.indexInList * 400.toDouble(),
              200.0,
            ).ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: valueOrDefault<double>(
              widget.indexInList * 400.toDouble(),
              200.0,
            ).ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 30.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
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
    return Material(
      color: Colors.transparent,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
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
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Container(
            width: double.infinity,
            color: FlutterFlowTheme.of(context).primaryBackground,
            child: ExpandableNotifier(
              controller: _model.expandableExpandableController,
              child: ExpandablePanel(
                header: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.taskRecord?.taskName,
                      'Mathematics Assignment I',
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleLargeFamily,
                          color: Colors.black,
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleLargeIsCustom,
                        ),
                  ),
                ),
                collapsed: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                        child: Text(
                          widget.taskRecord?.taskType ==
                                  TaskType.assignment.name
                              ? 'Deadline: ${valueOrDefault<String>(
                                  dateTimeFormat(
                                    "MMMMEEEEd",
                                    widget.taskRecord?.taskDueDate,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  'Friday, May 23',
                                )} - ${dateTimeFormat(
                                  "jm",
                                  widget.taskRecord?.taskDueDate,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                )}'
                              : 'Exam Time: ${valueOrDefault<String>(
                                  dateTimeFormat(
                                    "yMMMd",
                                    widget.taskRecord?.taskStartTime,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  'May 23, 2025',
                                )} | ${valueOrDefault<String>(
                                  dateTimeFormat(
                                    "jm",
                                    widget.taskRecord?.taskStartTime,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  '2:00 PM',
                                )} - ${valueOrDefault<String>(
                                  dateTimeFormat(
                                    "jm",
                                    widget.taskRecord?.taskEndTime,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  '2:30 PM',
                                )}',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                      ),
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'ASSIGNMENT_BLOCK_Icon_04gsl91m_ON_TAP');
                            logFirebaseEvent('Icon_alert_dialog');
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: EditTasksWidget(
                                    refRow: widget.taskRecord!,
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            FFIcons.ksetting,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                expanded: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.taskRecord?.taskType == TaskType.assignment.name
                            ? 'Assignment Details:'
                            : 'Exam Time:',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            FFIcons.kclock,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              widget.taskRecord?.taskType ==
                                      TaskType.assignment.name
                                  ? 'Deadline: ${dateTimeFormat(
                                      "EEEE, MMMM d yyyy – h:mm a",
                                      widget.taskRecord?.taskDueDate,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    )}'
                                  : 'Start: ${dateTimeFormat(
                                      "yMMMd",
                                      widget.taskRecord?.taskStartTime,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    )} - ${dateTimeFormat(
                                      "jm",
                                      widget.taskRecord?.taskStartTime,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    )}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.taskRecord?.taskType !=
                          TaskType.assignment.name)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              FFIcons.kbxsStopwatch,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 18.0,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'End: ${dateTimeFormat(
                                  "yMMMd",
                                  widget.taskRecord?.taskEndTime,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                )} - ${dateTimeFormat(
                                  "jm",
                                  widget.taskRecord?.taskEndTime,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                )}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
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
                            EdgeInsetsDirectional.fromSTEB(2.0, 4.0, 0.0, 0.0),
                        child: Text(
                          widget.taskRecord?.taskType ==
                                  TaskType.assignment.name
                              ? 'Assignment Description: '
                              : 'Exam Syllabus: ',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineSmallIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.taskRecord?.taskDescription,
                            'The syllabus for this task has not been defined yet. Please refer to official departmental resources or contact the course instructor for more information.',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineSmallIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(2.0, 4.0, 0.0, 0.0),
                        child: Text(
                          widget.taskRecord?.taskType ==
                                  TaskType.assignment.name
                              ? 'Submission Venue: '
                              : 'Exam Venue: ',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineSmallIsCustom,
                              ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            FFIcons.kmapPin,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.taskRecord?.taskVenue,
                                'NLHC 301',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      if (valueOrDefault<bool>(
                        widget.taskRecord?.taskAssets != null &&
                            widget.taskRecord?.taskAssets != '',
                        false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: widget.taskRecord?.taskType ==
                                    TaskType.assignment.name
                                ? 'View Assignment'
                                : 'View Exam Syllabus',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                theme: ExpandableThemeData(
                  tapHeaderToExpand: true,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: true,
                  expandIcon: FFIcons.karrowDownSM,
                  collapseIcon: FFIcons.karrowUpSM,
                  iconSize: 24.0,
                ),
              ),
            ),
          ).animateOnPageLoad(animationsMap['expandableOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
