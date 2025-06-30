import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/task_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task_archive_block_model.dart';
export 'task_archive_block_model.dart';

class TaskArchiveBlockWidget extends StatefulWidget {
  const TaskArchiveBlockWidget({
    super.key,
    this.taskID,
    required this.taskType,
    required this.taskRecord,
  });

  final String? taskID;
  final RecordType? taskType;
  final TaskRecordsRow? taskRecord;

  @override
  State<TaskArchiveBlockWidget> createState() => _TaskArchiveBlockWidgetState();
}

class _TaskArchiveBlockWidgetState extends State<TaskArchiveBlockWidget> {
  late TaskArchiveBlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaskArchiveBlockModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PersonalRecordsRecord>>(
      stream: FFAppState().taskArchives(
        uniqueQueryKey: valueOrDefault<String>(
          widget.taskID,
          'taskID',
        ),
        requestFn: () => queryPersonalRecordsRecord(
          parent: currentUserReference,
          queryBuilder: (personalRecordsRecord) => personalRecordsRecord.where(
            'record_id',
            isEqualTo: widget.taskID,
          ),
          singleRecord: true,
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
        List<PersonalRecordsRecord> containerPersonalRecordsRecordList =
            snapshot.data!;
        final containerPersonalRecordsRecord =
            containerPersonalRecordsRecordList.isNotEmpty
                ? containerPersonalRecordsRecordList.first
                : null;

        return Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.taskRecord?.taskName,
                          'taskName Not Defined',
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
                      RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: valueOrDefault<String>(
                                containerPersonalRecordsRecord?.marksObtained
                                    .toString(),
                                '- ',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelLargeFamily,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelLargeIsCustom,
                                  ),
                            ),
                            TextSpan(
                              text: '/',
                              style: GoogleFonts.outfit(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                            TextSpan(
                              text: valueOrDefault<String>(
                                containerPersonalRecordsRecord?.totalMarks
                                    .toString(),
                                '-',
                              ),
                              style: GoogleFonts.outfit(
                                color: FlutterFlowTheme.of(context).primaryText,
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
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.taskType == RecordType.assignment
                            ? 'Assignment - ${valueOrDefault<String>(
                                containerPersonalRecordsRecord
                                    ?.tags.firstOrNull,
                                ' - ',
                              )}'
                            : 'Exam - ${valueOrDefault<String>(
                                containerPersonalRecordsRecord
                                    ?.tags.firstOrNull,
                                '-',
                              )}',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                      child: Text(
                        widget.taskType == RecordType.assignment
                            ? 'Deadline: ${valueOrDefault<String>(
                                dateTimeFormat(
                                  "yMMMd",
                                  widget.taskRecord?.taskDueDate,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                'taskName Not Defined',
                              )}, ${valueOrDefault<String>(
                                dateTimeFormat(
                                  "jm",
                                  widget.taskRecord?.taskDueDate,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                'taskName Not Defined',
                              )}'
                            : '${valueOrDefault<String>(
                                dateTimeFormat(
                                  "yMMMd",
                                  widget.taskRecord?.taskStartTime,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                'taskName Not Defined',
                              )}, Timings: ${valueOrDefault<String>(
                                dateTimeFormat(
                                  "jm",
                                  widget.taskRecord?.taskDueDate,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                'taskName Not Defined',
                              )} - ${dateTimeFormat(
                                "jm",
                                widget.taskRecord?.taskEndTime,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              )}',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                      ),
                    ),
                    if ((containerPersonalRecordsRecord != null) == false)
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 8.0, 8.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'TASK_ARCHIVE_BLOCK_Icon_1r810dp8_ON_TAP');
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
                                    child: TaskDropdownWidget(
                                      taskID: widget.taskID,
                                      courseID: widget.taskRecord?.courseID,
                                      taskStartTime:
                                          widget.taskRecord?.taskStartTime,
                                      taskName: widget.taskRecord?.taskName,
                                      taskType: widget.taskType,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              FFIcons.keditPencil01,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
