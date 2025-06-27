import '/auth/firebase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'enrolled_courses_model.dart';
export 'enrolled_courses_model.dart';

class EnrolledCoursesWidget extends StatefulWidget {
  const EnrolledCoursesWidget({super.key});

  static String routeName = 'enrolledCourses';
  static String routePath = 'enrolledCourses';

  @override
  State<EnrolledCoursesWidget> createState() => _EnrolledCoursesWidgetState();
}

class _EnrolledCoursesWidgetState extends State<EnrolledCoursesWidget>
    with TickerProviderStateMixin {
  late EnrolledCoursesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnrolledCoursesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'enrolledCourses'});
    animationsMap.addAll({
      'listViewOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'listViewOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'enrolledCourses',
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
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                  logFirebaseEvent('ENROLLED_COURSES_arrowLeft_ICN_ON_TAP');
                  logFirebaseEvent('IconButton_navigate_back');
                  context.pop();
                },
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 0.0),
                      child: Text(
                        'Your courses for this semester:',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .headlineMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .headlineMediumIsCustom,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(18.0, 8.0, 0.0, 8.0),
                      child: Text(
                        'Core Subjects:',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                      ),
                    ),
                    AuthUserStreamWidget(
                      builder: (context) =>
                          FutureBuilder<List<CourseRecordsRow>>(
                        future: _model.userCoreCourses(
                          uniqueQueryKey: '${currentUserUid}_coreCourses',
                          requestFn: () => CourseRecordsTable().queryRows(
                            queryFn: (q) => q.inFilterOrNull(
                              'courseID',
                              (currentUserDocument?.coursesEnrolled.toList() ??
                                      [])
                                  .where(
                                      (e) => e.courseType.courseType == 'core')
                                  .toList()
                                  .map((e) => e.courseID)
                                  .toList(),
                            ),
                            limit: 4,
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
                          List<CourseRecordsRow> listViewCourseRecordsRowList =
                              snapshot.data!;

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewCourseRecordsRowList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewCourseRecordsRow =
                                  listViewCourseRecordsRowList[listViewIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 4.0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4.0, 4.0, 0.0, 6.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                listViewCourseRecordsRow
                                                    .courseName,
                                                'Advanced Mathematics',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 0.0),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Course Code: ',
                                                    style: GoogleFonts.outfit(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      listViewCourseRecordsRow
                                                          .courseID
                                                          .substring(0, 7),
                                                      'ME1001E',
                                                    ),
                                                    style: GoogleFonts.outfit(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 11.0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' | ',
                                                    style: TextStyle(),
                                                  ),
                                                  TextSpan(
                                                    text: 'Credits: ',
                                                    style: GoogleFonts.outfit(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      listViewCourseRecordsRow
                                                          .credits
                                                          ?.toString(),
                                                      '3',
                                                    ),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 11.0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' | ',
                                                    style: TextStyle(),
                                                  ),
                                                  TextSpan(
                                                    text: 'Category: ',
                                                    style: GoogleFonts.outfit(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      () {
                                                        if (valueOrDefault<
                                                                String>(
                                                              listViewCourseRecordsRow
                                                                  .courseID
                                                                  .substring(
                                                                      7, 9),
                                                              'ME1001E',
                                                            ) ==
                                                            'DE') {
                                                          return 'Department Elective';
                                                        } else if (valueOrDefault<
                                                                String>(
                                                              listViewCourseRecordsRow
                                                                  .courseID
                                                                  .substring(
                                                                      7, 9),
                                                              'ME1001E',
                                                            ) ==
                                                            'IC') {
                                                          return 'Institute Core';
                                                        } else if (valueOrDefault<
                                                                String>(
                                                              valueOrDefault<
                                                                  String>(
                                                                listViewCourseRecordsRow
                                                                    .courseID
                                                                    .substring(
                                                                        7, 9),
                                                                'ME1001E',
                                                              ).substring(7, 9),
                                                              'ME1001E',
                                                            ) ==
                                                            'PC') {
                                                          return 'Programme Core';
                                                        } else {
                                                          return 'Institute Core';
                                                        }
                                                      }(),
                                                      'Programme Core',
                                                    ),
                                                    style: GoogleFonts.outfit(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 11.0,
                                                    ),
                                                  )
                                                ],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).animateOnPageLoad(
                              animationsMap['listViewOnPageLoadAnimation1']!);
                        },
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  StyledDivider(
                                    thickness: 2.0,
                                    indent: 10.0,
                                    endIndent: 10.0,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    lineStyle: DividerLineStyle.dashed,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          18.0, 4.0, 0.0, 8.0),
                                      child: Text(
                                        'Electives:',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                                  AuthUserStreamWidget(
                                    builder: (context) =>
                                        FutureBuilder<List<CourseRecordsRow>>(
                                      future: _model.userElectiveCourses(
                                        uniqueQueryKey:
                                            '${currentUserUid}_electiveCourses',
                                        requestFn: () =>
                                            CourseRecordsTable().queryRows(
                                          queryFn: (q) => q.inFilterOrNull(
                                            'courseID',
                                            (currentUserDocument
                                                        ?.coursesEnrolled
                                                        .toList() ??
                                                    [])
                                                .where((e) =>
                                                    e.courseType.courseType ==
                                                    'elective')
                                                .toList()
                                                .map((e) => e.courseID)
                                                .toList(),
                                          ),
                                          limit: 4,
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 25.0,
                                              ),
                                            ),
                                          );
                                        }
                                        List<CourseRecordsRow>
                                            listViewCourseRecordsRowList =
                                            snapshot.data!;

                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              listViewCourseRecordsRowList
                                                  .length,
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewCourseRecordsRow =
                                                listViewCourseRecordsRowList[
                                                    listViewIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 4.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 4.0,
                                                                0.0, 6.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              listViewCourseRecordsRow
                                                                  .courseName,
                                                              'Advanced Mathematics',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .outfit(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Course Code: ',
                                                                  style:
                                                                      GoogleFonts
                                                                          .outfit(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10.0,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    listViewCourseRecordsRow
                                                                        .courseID
                                                                        .substring(
                                                                            0,
                                                                            7),
                                                                    'ME1001E',
                                                                  ),
                                                                  style:
                                                                      GoogleFonts
                                                                          .outfit(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        11.0,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: ' | ',
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      'Credits: ',
                                                                  style:
                                                                      GoogleFonts
                                                                          .outfit(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10.0,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    listViewCourseRecordsRow
                                                                        .credits
                                                                        ?.toString(),
                                                                    '3',
                                                                  ),
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        11.0,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: ' | ',
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      'Category: ',
                                                                  style:
                                                                      GoogleFonts
                                                                          .outfit(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10.0,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    () {
                                                                      if (valueOrDefault<
                                                                              String>(
                                                                            listViewCourseRecordsRow.courseID.substring(7,
                                                                                9),
                                                                            'ME1001E',
                                                                          ) ==
                                                                          'DE') {
                                                                        return 'Department Elective';
                                                                      } else if (valueOrDefault<
                                                                              String>(
                                                                            listViewCourseRecordsRow.courseID.substring(7,
                                                                                9),
                                                                            'ME1001E',
                                                                          ) ==
                                                                          'IC') {
                                                                        return 'Institute Core';
                                                                      } else if (valueOrDefault<
                                                                              String>(
                                                                            listViewCourseRecordsRow.courseID.substring(7,
                                                                                9),
                                                                            'ME1001E',
                                                                          ) ==
                                                                          'PC') {
                                                                        return 'Programme Core';
                                                                      } else {
                                                                        return 'Institute Core';
                                                                      }
                                                                    }(),
                                                                    'Programme Core',
                                                                  ),
                                                                  style:
                                                                      GoogleFonts
                                                                          .outfit(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        11.0,
                                                                  ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .bodyMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).animateOnPageLoad(animationsMap[
                                            'listViewOnPageLoadAnimation2']!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
