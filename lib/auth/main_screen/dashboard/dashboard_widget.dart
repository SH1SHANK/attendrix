import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/attendancebar/attendancebar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({
    super.key,
    this.upcomingClasses,
  });

  final String? upcomingClasses;

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  late DashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());

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
        title: 'dashboard',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFFF6F6F6),
            floatingActionButton: Visibility(
              visible: currentUserDocument?.role != UserRole.student,
              child: Align(
                alignment: const AlignmentDirectional(1.0, 1.0),
                child: AuthUserStreamWidget(
                  builder: (context) => FloatingActionButton(
                    onPressed: () async {
                      context.pushNamed('EditClasses');
                    },
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    elevation: 4.0,
                    child: Icon(
                      FFIcons.kcalendarDateAdd,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                23.0, 10.0, 23.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        4.0, 10.0, 0.0, 10.0),
                                    child: RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Today,',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                          ),
                                          TextSpan(
                                            text: valueOrDefault<String>(
                                              dateTimeFormat(
                                                "yMMMd",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ),
                                              'Oct 25, 2024',
                                            ),
                                            style: const TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Align(
                                    alignment: const AlignmentDirectional(1.0, -1.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 3.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed('announements');
                                        },
                                        child: Icon(
                                          FFIcons.kbxsBell,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 5.0, 24.0, 10.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AuthUserStreamWidget(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onDoubleTap: () async {
                                                context.pushNamed(
                                                  'profile',
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .leftToRight,
                                                    ),
                                                  },
                                                );
                                              },
                                              child: RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'Hi,',
                                                      style: TextStyle(),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          currentUserDisplayName,
                                                      style: const TextStyle(),
                                                    ),
                                                    const TextSpan(
                                                      text: '!',
                                                      style: TextStyle(),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            const Color(0xFF12151C),
                                                        fontSize: 22.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Let\'s manage your attendance',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: const Color(0xFF5A5C60),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0x4C105DFB),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed('profile');
                                            },
                                            child: Hero(
                                              tag: 'profilepic',
                                              transitionOnUserGestures: true,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                child: Image.asset(
                                                  'assets/images/User_Icon_(1).png',
                                                  width: 40.0,
                                                  height: 40.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 10.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Upcoming Classes',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0xFF12151C),
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      AuthUserStreamWidget(
                                        builder: (context) => StreamBuilder<
                                            List<TimetableRecord>>(
                                          stream:
                                              FFAppState().upcomingClassDetails(
                                            uniqueQueryKey:
                                                valueOrDefault<String>(
                                              widget.upcomingClasses,
                                              'upcomingClasses',
                                            ),
                                            requestFn: () =>
                                                queryTimetableRecord(
                                              queryBuilder: (timetableRecord) =>
                                                  timetableRecord
                                                      .where(
                                                        'classDate',
                                                        isGreaterThanOrEqualTo:
                                                            getCurrentTimestamp,
                                                      )
                                                      .where(
                                                        'classStatus',
                                                        isEqualTo: ClassStatus
                                                            .isScheduled
                                                            .serialize(),
                                                      )
                                                      .where(
                                                        'batch',
                                                        isEqualTo: valueOrDefault(
                                                            currentUserDocument
                                                                ?.batch,
                                                            ''),
                                                      )
                                                      .orderBy('classDate'),
                                              limit: 4,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 20.0, 0.0, 20.0),
                                                  child: Image.asset(
                                                    'assets/images/Lottie_Animation_Batch_(1).gif',
                                                    width: 500.0,
                                                    height: 200.0,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<TimetableRecord>
                                                listViewTimetableRecordList =
                                                snapshot.data!;

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewTimetableRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewTimetableRecord =
                                                    listViewTimetableRecordList[
                                                        listViewIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 5.0),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 2.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                    child: AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 100),
                                                      curve: Curves.easeIn,
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 95.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            const Color(0xFF105DFB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    5.0),
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0,
                                                                      -1.0),
                                                              child: Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        16.0,
                                                                        8.0,
                                                                        16.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            AutoSizeText(
                                                                              'The Class is in ${functions.calculateTimeRemaining(listViewTimetableRecord.classDate?.toString())}'.maybeHandleOverflow(
                                                                                maxChars: 31,
                                                                                replacement: '…',
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                              minFontSize: 6.0,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                            AutoSizeText(
                                                                              valueOrDefault<String>(
                                                                                'Next Up: ${listViewTimetableRecord.courseName}',
                                                                                'Next Up: [course_name]',
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                              minFontSize: 12.0,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                            AnimatedDefaultTextStyle(
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                              duration: const Duration(milliseconds: 600),
                                                                              curve: Curves.bounceOut,
                                                                              child: Text(
                                                                                'Class Time: ${dateTimeFormat(
                                                                                  "jm",
                                                                                  listViewTimetableRecord.classDate,
                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                )}',
                                                                                textAlign: TextAlign.start,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
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
                                            );
                                          },
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 10.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Check-In Today\'s Classes',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0xFF12151C),
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      AuthUserStreamWidget(
                                        builder: (context) => StreamBuilder<
                                            List<TimetableRecord>>(
                                          stream: _model.checkinClass(
                                            uniqueQueryKey: '',
                                            requestFn: () =>
                                                queryTimetableRecord(
                                              queryBuilder: (timetableRecord) =>
                                                  timetableRecord
                                                      .where(
                                                        'classStatus',
                                                        isEqualTo: ClassStatus
                                                            .isScheduled
                                                            .serialize(),
                                                      )
                                                      .where(
                                                        'scheduledDate',
                                                        isEqualTo:
                                                            dateTimeFormat(
                                                          "d/M/y",
                                                          getCurrentTimestamp,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                      )
                                                      .where(
                                                        'batch',
                                                        isEqualTo: valueOrDefault(
                                                            currentUserDocument
                                                                ?.batch,
                                                            ''),
                                                      )
                                                      .orderBy('classDate'),
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Image.asset(
                                                'assets/images/Lottie_Animation_Batch_(1).gif',
                                                width: 500.0,
                                                height: 240.0,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            List<TimetableRecord>
                                                listViewTimetableRecordList =
                                                snapshot.data!;
                                            if (listViewTimetableRecordList
                                                .isEmpty) {
                                              return Center(
                                                child: Image.asset(
                                                  'assets/images/Whimsical_Loading_Screen_Animation_(1).gif',
                                                  width: 400.0,
                                                  height: 400.0,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              );
                                            }

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewTimetableRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewTimetableRecord =
                                                    listViewTimetableRecordList[
                                                        listViewIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 2.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            const Color(0xFF105DFB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        16.0,
                                                                        16.0,
                                                                        16.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    AnimatedContainer(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              1000),
                                                                      curve: Curves
                                                                          .bounceOut,
                                                                      width:
                                                                          250.0,
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              2.0,
                                                                              0.0),
                                                                          child:
                                                                              StreamBuilder<List<AttendanceRecordRecord>>(
                                                                            stream:
                                                                                FFAppState().checkInDetails(
                                                                              requestFn: () => queryAttendanceRecordRecord(
                                                                                queryBuilder: (attendanceRecordRecord) => attendanceRecordRecord.where(
                                                                                  'ClassId',
                                                                                  isEqualTo: listViewTimetableRecord.classId,
                                                                                ),
                                                                                singleRecord: true,
                                                                              ),
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
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
                                                                              List<AttendanceRecordRecord> checkboxListTileAttendanceRecordRecordList = snapshot.data!;
                                                                              final checkboxListTileAttendanceRecordRecord = checkboxListTileAttendanceRecordRecordList.isNotEmpty ? checkboxListTileAttendanceRecordRecordList.first : null;

                                                                              return Material(
                                                                                color: Colors.transparent,
                                                                                child: Theme(
                                                                                  data: ThemeData(
                                                                                    unselectedWidgetColor: FlutterFlowTheme.of(context).tertiary,
                                                                                  ),
                                                                                  child: CheckboxListTile(
                                                                                    value: _model.checkboxListTileValueMap[listViewTimetableRecord] ??= checkboxListTileAttendanceRecordRecord != null,
                                                                                    onChanged: (listViewTimetableRecord.classDate! > getCurrentTimestamp)
                                                                                        ? null
                                                                                        : (newValue) async {
                                                                                            safeSetState(() => _model.checkboxListTileValueMap[listViewTimetableRecord] = newValue!);
                                                                                            if (newValue!) {
                                                                                              if (checkboxListTileAttendanceRecordRecord != null) {
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  SnackBar(
                                                                                                    content: Text(
                                                                                                      'Already Checked into Class!',
                                                                                                      style: GoogleFonts.getFont(
                                                                                                        'Montserrat',
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                    ),
                                                                                                    duration: const Duration(milliseconds: 4000),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).error,
                                                                                                  ),
                                                                                                );
                                                                                                return;
                                                                                              } else {
                                                                                                await AttendanceRecordRecord.collection.doc().set(createAttendanceRecordRecordData(
                                                                                                      batch: valueOrDefault(currentUserDocument?.batch, ''),
                                                                                                      courseName: listViewTimetableRecord.courseName,
                                                                                                      classDate: listViewTimetableRecord.classDate,
                                                                                                      username: currentUserDisplayName,
                                                                                                      userId: currentUserUid,
                                                                                                      isPresent: true,
                                                                                                      checkinTime: getCurrentTimestamp,
                                                                                                      classId: '${listViewTimetableRecord.batch}-${listViewTimetableRecord.courseName}-${dateTimeFormat(
                                                                                                        "d/M h:mm a",
                                                                                                        listViewTimetableRecord.classDate,
                                                                                                        locale: FFLocalizations.of(context).languageCode,
                                                                                                      )}',
                                                                                                    ));
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  SnackBar(
                                                                                                    content: Text(
                                                                                                      'CheckIn Successful!',
                                                                                                      style: TextStyle(
                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                      ),
                                                                                                    ),
                                                                                                    duration: const Duration(milliseconds: 4000),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                  ),
                                                                                                );
                                                                                              }
                                                                                            } else {
                                                                                              await checkboxListTileAttendanceRecordRecord!.reference.delete();
                                                                                            }
                                                                                          },
                                                                                    title: Text(
                                                                                      listViewTimetableRecord.courseName,
                                                                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                            fontFamily: 'Geomanist',
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            useGoogleFonts: false,
                                                                                          ),
                                                                                    ),
                                                                                    subtitle: Text(
                                                                                      dateTimeFormat(
                                                                                        "jm",
                                                                                        listViewTimetableRecord.classDate!,
                                                                                        locale: FFLocalizations.of(context).languageCode,
                                                                                      ),
                                                                                      textAlign: TextAlign.start,
                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    activeColor: FlutterFlowTheme.of(context).primary,
                                                                                    checkColor: (listViewTimetableRecord.classDate! > getCurrentTimestamp) ? FlutterFlowTheme.of(context).tertiary : FlutterFlowTheme.of(context).info,
                                                                                    dense: false,
                                                                                    controlAffinity: ListTileControlAffinity.trailing,
                                                                                    contentPadding: const EdgeInsets.all(4.0),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 10.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x33000000),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 0.0, 10.0),
                                          child: Text(
                                            'Attendance Overview',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: const Color(0xFF12151C),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    15.0, 0.0, 10.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            const AttendancebarWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              text: 'view all',
                                              options: FFButtonOptions(
                                                width: 60.0,
                                                height: 30.0,
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 8.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => StreamBuilder<
                                            List<ClassDetailsRecord>>(
                                          stream:
                                              FFAppState().attendanceOverview(
                                            uniqueQueryKey:
                                                '$currentUserUid-classDetails',
                                            requestFn: () =>
                                                queryClassDetailsRecord(
                                              queryBuilder:
                                                  (classDetailsRecord) =>
                                                      classDetailsRecord.where(
                                                'batch',
                                                isEqualTo: valueOrDefault(
                                                    currentUserDocument?.batch,
                                                    ''),
                                              ),
                                              limit: 4,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Image.asset(
                                                'assets/images/Animation_Lottie_Files.gif',
                                                width: 500.0,
                                                height: 275.0,
                                                fit: BoxFit.fitWidth,
                                              );
                                            }
                                            List<ClassDetailsRecord>
                                                columnClassDetailsRecordList =
                                                snapshot.data!;

                                            return SingleChildScrollView(
                                              primary: false,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    columnClassDetailsRecordList
                                                        .length, (columnIndex) {
                                                  final columnClassDetailsRecord =
                                                      columnClassDetailsRecordList[
                                                          columnIndex];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(15.0, 0.0,
                                                                15.0, 15.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            blurRadius: 4.0,
                                                            color: Color(
                                                                0x33000000),
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child:
                                                            FutureBuilder<int>(
                                                          future: FFAppState()
                                                              .attendanceRecordCount(
                                                            uniqueQueryKey:
                                                                '$currentUserUid-attendanceRecord',
                                                            requestFn: () =>
                                                                queryAttendanceRecordRecordCount(
                                                              queryBuilder:
                                                                  (attendanceRecordRecord) =>
                                                                      attendanceRecordRecord
                                                                          .where(
                                                                            'userId',
                                                                            isEqualTo:
                                                                                currentUserUid,
                                                                          )
                                                                          .where(
                                                                            'course_name',
                                                                            isEqualTo:
                                                                                columnClassDetailsRecord.courseName,
                                                                          )
                                                                          .where(
                                                                            'batch',
                                                                            isEqualTo:
                                                                                valueOrDefault(currentUserDocument?.batch, ''),
                                                                          ),
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 20.0,
                                                                  height: 20.0,
                                                                  child:
                                                                      SpinKitCircle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 20.0,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            int columnCount =
                                                                snapshot.data!;

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            7.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Align(
                                                                          alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  columnClassDetailsRecord.courseName,
                                                                                  textAlign: TextAlign.start,
                                                                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        color: const Color(0xFF12151C),
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                ),
                                                                                FutureBuilder<int>(
                                                                                  future: queryTimetableRecordCount(
                                                                                    queryBuilder: (timetableRecord) => timetableRecord
                                                                                        .where(
                                                                                          'batch',
                                                                                          isEqualTo: valueOrDefault(currentUserDocument?.batch, ''),
                                                                                        )
                                                                                        .where(
                                                                                          'course_name',
                                                                                          isEqualTo: columnClassDetailsRecord.courseName,
                                                                                        )
                                                                                        .where(
                                                                                          'classStatus',
                                                                                          isEqualTo: ClassStatus.isScheduled.serialize(),
                                                                                        )
                                                                                        .where(
                                                                                          'classDate',
                                                                                          isLessThanOrEqualTo: getCurrentTimestamp,
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
                                                                                    int textCount = snapshot.data!;

                                                                                    return AnimatedDefaultTextStyle(
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 13.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                      duration: const Duration(milliseconds: 600),
                                                                                      curve: Curves.bounceOut,
                                                                                      child: Text(
                                                                                        'Attended: ${columnCount.toString()} | Total Classes: ${textCount.toString()}',
                                                                                        textAlign: TextAlign.start,
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Flexible(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                const AlignmentDirectional(0.8, 0.1),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                                              child: FutureBuilder<int>(
                                                                                future: FFAppState().totalClassCount(
                                                                                  uniqueQueryKey: '$currentUserUid-ClassCount',
                                                                                  requestFn: () => queryTimetableRecordCount(
                                                                                    queryBuilder: (timetableRecord) => timetableRecord
                                                                                        .where(
                                                                                          'batch',
                                                                                          isEqualTo: valueOrDefault(currentUserDocument?.batch, ''),
                                                                                        )
                                                                                        .where(
                                                                                          'course_name',
                                                                                          isEqualTo: columnClassDetailsRecord.courseName,
                                                                                        )
                                                                                        .where(
                                                                                          'classStatus',
                                                                                          isEqualTo: ClassStatus.isScheduled.serialize(),
                                                                                        )
                                                                                        .where(
                                                                                          'classDate',
                                                                                          isLessThanOrEqualTo: getCurrentTimestamp,
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
                                                                                  int progressBarCount = snapshot.data!;

                                                                                  return CircularPercentIndicator(
                                                                                    percent: valueOrDefault<double>(
                                                                                      functions.attendance(progressBarCount, columnCount),
                                                                                      0.0,
                                                                                    ),
                                                                                    radius: 30.0,
                                                                                    lineWidth: 12.0,
                                                                                    animation: true,
                                                                                    animateFromLastPercent: true,
                                                                                    progressColor: FlutterFlowTheme.of(context).error,
                                                                                    backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                                                                    center: Text(
                                                                                      valueOrDefault<String>(
                                                                                        '${functions.attendancePercentage(progressBarCount, columnCount).toString()}%',
                                                                                        '0',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(const SizedBox(
                                                                  height: 8.0)),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).divide(const SizedBox(height: 5.0)).around(
                                                    const SizedBox(height: 5.0)),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
