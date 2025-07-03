import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/add_marks_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task_archive_block_model.dart';
export 'task_archive_block_model.dart';

class TaskArchiveBlockWidget extends StatefulWidget {
  const TaskArchiveBlockWidget({
    super.key,
    required this.indexInList,
    required this.taskRecord,
  });

  final int? indexInList;
  final TaskRecordsRow? taskRecord;

  @override
  State<TaskArchiveBlockWidget> createState() => _TaskArchiveBlockWidgetState();
}

class _TaskArchiveBlockWidgetState extends State<TaskArchiveBlockWidget>
    with TickerProviderStateMixin {
  late TaskArchiveBlockModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaskArchiveBlockModel());

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
              (widget.indexInList!) * 400.toDouble(),
              200.0,
            ).ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: valueOrDefault<double>(
              (widget.indexInList!) * 400.toDouble(),
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
    return StreamBuilder<List<TaskNotesRecord>>(
      stream: queryTaskNotesRecord(
        parent: currentUserReference,
        queryBuilder: (taskNotesRecord) => taskNotesRecord.where(
          'taskID',
          isEqualTo: widget.taskRecord?.id,
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
        List<TaskNotesRecord> containerTaskNotesRecordList = snapshot.data!;
        final containerTaskNotesRecord = containerTaskNotesRecordList.isNotEmpty
            ? containerTaskNotesRecordList.first
            : null;

        return Material(
          color: Colors.transparent,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: valueOrDefault<Color>(
                containerTaskNotesRecord?.noteColor,
                FlutterFlowTheme.of(context).primaryBackground,
              ),
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
                color: Color(0x00000000),
                child: ExpandableNotifier(
                  controller: _model.expandableExpandableController,
                  child: ExpandablePanel(
                    header: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          widget.taskRecord?.taskName,
                          'Mathematics III Assignment',
                        ),
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                      ),
                    ),
                    collapsed: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Obtained Marks',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelLargeFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelLargeIsCustom,
                                ),
                          ),
                          RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: valueOrDefault<String>(
                                    containerTaskNotesRecord?.obtainedMarks
                                        .toString(),
                                    '- -',
                                  ),
                                  style: GoogleFonts.outfit(
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                                TextSpan(
                                  text: '/',
                                  style: GoogleFonts.outfit(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                  ),
                                ),
                                TextSpan(
                                  text: valueOrDefault<String>(
                                    containerTaskNotesRecord?.totalMarks
                                        .toString(),
                                    '- -',
                                  ),
                                  style: GoogleFonts.outfit(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelLargeFamily,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelLargeIsCustom,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    expanded: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                containerTaskNotesRecord?.noteDescription,
                                'No Description was added.',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Obtained Marks',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelLargeIsCustom,
                                      ),
                                ),
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          containerTaskNotesRecord
                                              ?.obtainedMarks
                                              .toString(),
                                          '- -',
                                        ),
                                        style: GoogleFonts.outfit(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '/',
                                        style: GoogleFonts.outfit(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          containerTaskNotesRecord?.totalMarks
                                              .toString(),
                                          '- -',
                                        ),
                                        style: GoogleFonts.outfit(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelLargeIsCustom,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    containerTaskNotesRecord?.examDetails,
                                    'No additional information provided.',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelMediumIsCustom,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  widget.taskRecord?.taskType ==
                                          RecordType.assignment.name
                                      ? 'Deadline: ${dateTimeFormat(
                                          "jm",
                                          widget.taskRecord?.taskDueDate,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )}, ${dateTimeFormat(
                                          "yMMMd",
                                          widget.taskRecord?.taskDueDate,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )}'
                                      : '${dateTimeFormat(
                                          "yMMMd",
                                          widget.taskRecord?.taskStartTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )}, Timings: ${dateTimeFormat(
                                          "jm",
                                          widget.taskRecord?.taskStartTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )} - ${dateTimeFormat(
                                          "jm",
                                          widget.taskRecord?.taskEndTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        )}',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelMediumIsCustom,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'TASK_ARCHIVE_BLOCK_Icon_0j1obru4_ON_TAP');
                                    logFirebaseEvent('Icon_bottom_sheet');
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: AddMarksWidget(
                                            taskRecord: widget.taskRecord!,
                                            documentExists:
                                                containerTaskNotesRecord !=
                                                    null,
                                            taskNotesRef:
                                                containerTaskNotesRecord,
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Icon(
                                    FFIcons.keditPencil01,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ],
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
              ).animateOnPageLoad(
                  animationsMap['expandableOnPageLoadAnimation']!),
            ),
          ),
        );
      },
    );
  }
}
