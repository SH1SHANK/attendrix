import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'attendancebar_model.dart';
export 'attendancebar_model.dart';

class AttendancebarWidget extends StatefulWidget {
  const AttendancebarWidget({super.key});

  @override
  State<AttendancebarWidget> createState() => _AttendancebarWidgetState();
}

class _AttendancebarWidgetState extends State<AttendancebarWidget> {
  late AttendancebarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendancebarModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    'Overall Attendance:',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
            AuthUserStreamWidget(
              builder: (context) => StreamBuilder<List<ClassDetailsRecord>>(
                stream: FFAppState().attendanceOverview(
                  requestFn: () => queryClassDetailsRecord(
                    queryBuilder: (classDetailsRecord) =>
                        classDetailsRecord.where(
                      'batch',
                      isEqualTo: valueOrDefault(currentUserDocument?.batch, ''),
                    ),
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: SpinKitCircle(
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                      ),
                    );
                  }
                  List<ClassDetailsRecord> columnClassDetailsRecordList =
                      snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(columnClassDetailsRecordList.length,
                        (columnIndex) {
                      final columnClassDetailsRecord =
                          columnClassDetailsRecordList[columnIndex];
                      return Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      columnClassDetailsRecord.courseName,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: FutureBuilder<int>(
                                    future: FFAppState().attendanceRecordCount(
                                      requestFn: () =>
                                          queryAttendanceRecordRecordCount(
                                        queryBuilder:
                                            (attendanceRecordRecord) =>
                                                attendanceRecordRecord
                                                    .where(
                                                      'userId',
                                                      isEqualTo: currentUserUid,
                                                    )
                                                    .where(
                                                      'course_name',
                                                      isEqualTo:
                                                          columnClassDetailsRecord
                                                              .courseName,
                                                    ),
                                      ),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 20.0,
                                            height: 20.0,
                                            child: SpinKitCircle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                        );
                                      }
                                      int containerCount = snapshot.data!;

                                      return Container(
                                        width: 318.0,
                                        height: 15.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Align(
                                          alignment:
                                              const AlignmentDirectional(0.1, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: FutureBuilder<int>(
                                              future:
                                                  FFAppState().totalClassCount(
                                                requestFn: () =>
                                                    queryTimetableRecordCount(
                                                  queryBuilder:
                                                      (timetableRecord) =>
                                                          timetableRecord
                                                              .where(
                                                                'batch',
                                                                isEqualTo: valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.batch,
                                                                    ''),
                                                              )
                                                              .where(
                                                                'classDate',
                                                                isLessThanOrEqualTo:
                                                                    getCurrentTimestamp,
                                                              )
                                                              .where(
                                                                'classStatus',
                                                                isEqualTo: ClassStatus
                                                                    .isScheduled
                                                                    .serialize(),
                                                              )
                                                              .where(
                                                                'course_name',
                                                                isEqualTo:
                                                                    columnClassDetailsRecord
                                                                        .courseName,
                                                              ),
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      child: SpinKitCircle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 20.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                int progressBarCount =
                                                    snapshot.data!;

                                                return LinearPercentIndicator(
                                                  percent: functions.attendance(
                                                      progressBarCount,
                                                      containerCount),
                                                  width: 300.0,
                                                  lineHeight: 7.0,
                                                  animation: true,
                                                  animateFromLastPercent: true,
                                                  progressColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .accent3,
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary,
                                                  barRadius:
                                                      const Radius.circular(100.0),
                                                  padding: EdgeInsets.zero,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ].divide(const SizedBox(height: 12.0)),
        ),
      ),
    );
  }
}
