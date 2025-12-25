import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/class_components/course_attendance/course_attendance_widget.dart';
import '/components/c_g_p_a_calculator_widget.dart';
import '/custom_dialogs/attendance_calculator/attendance_calculator_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'attendance_model.dart';
export 'attendance_model.dart';

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({super.key});

  static String routeName = 'attendance';
  static String routePath = 'attendance';

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  late AttendanceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendanceModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'attendance'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
        title: 'attendance',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  FFIcons.karrowLeft,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  logFirebaseEvent('ATTENDANCE_PAGE_arrowLeft_ICN_ON_TAP');
                  logFirebaseEvent('IconButton_navigate_back');
                  context.pop();
                },
              ),
              title: Text(
                'Attendance',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineMediumFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 24.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 0.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            flex: 1,
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'ATTENDANCE_PAGE_SYLLABUS_BTN_ON_TAP');
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Feature currently unavailable!',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLargeFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyLargeIsCustom,
                                          ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              },
                              text: 'Syllabus',
                              icon: Icon(
                                FFIcons.kbooks,
                                size: 22.0,
                              ),
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 35.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconColor: FlutterFlowTheme.of(context).info,
                                color: Color(0xBCEE8B60),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'ATTENDANCE_PAGE_ANALYTICS_BTN_ON_TAP');
                                  logFirebaseEvent('Button_navigate_to');

                                  context.pushNamed(AnalyticsWidget.routeName);
                                },
                                text: 'Analytics',
                                icon: Icon(
                                  FFIcons.kpresentationAnalytics,
                                  size: 22.0,
                                ),
                                options: FFButtonOptions(
                                  width: 300.0,
                                  height: 35.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconColor: FlutterFlowTheme.of(context).info,
                                  color: Color(0xBE7B6FF8),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'ATTENDANCE_C_G_P_A_CALCULATOR_BTN_ON_TAP');
                                    logFirebaseEvent('Button_alert_dialog');
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: CGPACalculatorWidget(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  text: 'CGPA Calculator',
                                  icon: Icon(
                                    FFIcons.kcalculatorComputeMathAlt,
                                    size: 22.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 35.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor:
                                        FlutterFlowTheme.of(context).info,
                                    color: Color(0xBD37D437),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Builder(
                            builder: (context) {
                              final course = (currentUserDocument
                                          ?.coursesEnrolled
                                          .toList() ??
                                      [])
                                  .toList()
                                  .take(10)
                                  .toList();

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: course.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 4.0),
                                itemBuilder: (context, courseIndex) {
                                  final courseItem = course[courseIndex];
                                  return Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'ATTENDANCE_Container_0d086bn0_ON_TAP');
                                        logFirebaseEvent(
                                            'courseAttendance_alert_dialog');
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child:
                                                    AttendanceCalculatorWidget(
                                                  courseRecord: courseItem,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: wrapWithModel(
                                        model: _model.courseAttendanceModels1
                                            .getModel(
                                          courseItem.courseID,
                                          courseIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: CourseAttendanceWidget(
                                          key: Key(
                                            'Key0d0_${courseItem.courseID}',
                                          ),
                                          courseData: courseItem,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      if (valueOrDefault<bool>(
                        FFAppState().customClassesAlldays.isNotEmpty,
                        false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: StreamBuilder<List<CustomClassesRecord>>(
                            stream: FFAppState().customClasses(
                              uniqueQueryKey: 'customclasses',
                              requestFn: () => queryCustomClassesRecord(
                                parent: currentUserReference,
                                queryBuilder: (customClassesRecord) =>
                                    customClassesRecord.where(
                                  'startDate',
                                  isLessThanOrEqualTo: getCurrentTimestamp,
                                ),
                                limit: 8,
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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 25.0,
                                    ),
                                  ),
                                );
                              }
                              List<CustomClassesRecord>
                                  listViewCustomClassesRecordList =
                                  snapshot.data!;

                              return ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  20.0,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    listViewCustomClassesRecordList.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 4.0),
                                itemBuilder: (context, listViewIndex) {
                                  final listViewCustomClassesRecord =
                                      listViewCustomClassesRecordList[
                                          listViewIndex];
                                  return Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'ATTENDANCE_Container_aznmuv1u_ON_TAP');
                                        logFirebaseEvent(
                                            'courseAttendance_alert_dialog');
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child:
                                                    AttendanceCalculatorWidget(
                                                  courseRecord:
                                                      CoursesEnrolledStruct(
                                                    courseID:
                                                        listViewCustomClassesRecord
                                                            .courseID,
                                                    courseName:
                                                        listViewCustomClassesRecord
                                                            .courseName,
                                                    courseType:
                                                        CourseTypeStruct(
                                                      courseType: 'custom',
                                                      isLab: false,
                                                    ),
                                                    attendedClasses:
                                                        valueOrDefault<int>(
                                                      listViewCustomClassesRecord
                                                          .attendedClasses
                                                          .length,
                                                      0,
                                                    ),
                                                    totalClasses:
                                                        valueOrDefault<int>(
                                                      functions.calculateTotalCustomClasses(
                                                          listViewCustomClassesRecord
                                                              .startDate!,
                                                          listViewCustomClassesRecord
                                                              .slotData
                                                              .slotMetadata
                                                              .toList()),
                                                      0,
                                                    ),
                                                    isEditable: true,
                                                    credits: 3,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: wrapWithModel(
                                        model: _model.courseAttendanceModels2
                                            .getModel(
                                          listViewCustomClassesRecord
                                              .reference.id,
                                          listViewIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        updateOnChange: true,
                                        child: CourseAttendanceWidget(
                                          key: Key(
                                            'Keyazn_${listViewCustomClassesRecord.reference.id}',
                                          ),
                                          courseData: CoursesEnrolledStruct(
                                            courseID:
                                                listViewCustomClassesRecord
                                                    .courseID,
                                            courseName:
                                                listViewCustomClassesRecord
                                                    .courseName,
                                            courseType: CourseTypeStruct(
                                              courseType: 'custom',
                                              isLab: false,
                                            ),
                                            attendedClasses:
                                                valueOrDefault<int>(
                                              listViewCustomClassesRecord
                                                  .attendedClasses.length,
                                              0,
                                            ),
                                            totalClasses: valueOrDefault<int>(
                                                  functions.calculateTotalCustomClasses(
                                                      listViewCustomClassesRecord
                                                          .startDate!,
                                                      listViewCustomClassesRecord
                                                          .slotData.slotMetadata
                                                          .toList()),
                                                  0,
                                                ) -
                                                valueOrDefault<int>(
                                                  listViewCustomClassesRecord
                                                      .cancelledClasses.length,
                                                  0,
                                                ),
                                            isEditable: true,
                                            credits: 3,
                                          ),
                                          isCustomClass: true,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ].addToEnd(SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
