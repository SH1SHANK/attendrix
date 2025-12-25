import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/add_assignment_widget.dart';
import '/components/add_exam_widget.dart';
import '/components/assignment_block_widget.dart';
import '/empty_list_comp/empty_class/empty_class_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tasks_model.dart';
export 'tasks_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  static String routeName = 'tasks';
  static String routePath = 'tasks';

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget>
    with TickerProviderStateMixin {
  late TasksModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TasksModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'tasks'});
    _model.mainBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
        title: 'tasks',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton.extended(
                onPressed: () async {
                  logFirebaseEvent('TASKS_FloatingActionButton_6mqvga1m_ON_T');
                  if (_model.mainBarCurrentIndex == 1) {
                    logFirebaseEvent('FloatingActionButton_alert_dialog');
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(dialogContext).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: AddExamWidget(),
                          ),
                        );
                      },
                    );
                  } else {
                    logFirebaseEvent('FloatingActionButton_alert_dialog');
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(dialogContext).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: AddAssignmentWidget(),
                          ),
                        );
                      },
                    );
                  }
                },
                backgroundColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(
                  Icons.add_rounded,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                elevation: 8.0,
                label: Text(
                  _model.mainBarCurrentIndex == 1
                      ? 'Add Exam'
                      : 'Add Assignment',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                      ),
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 50.0,
                icon: Icon(
                  FFIcons.karrowChevronLeft,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 28.0,
                ),
                onPressed: () async {
                  logFirebaseEvent('TASKS_PAGE_arrowChevronLeft_ICN_ON_TAP');
                  logFirebaseEvent('IconButton_navigate_back');
                  context.pop();
                },
              ),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Assignments & Exams',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('TASKS_PAGE_Icon_ac9yem0k_ON_TAP');
                      logFirebaseEvent('Icon_navigate_to');

                      context.pushNamed(TaskArchivesWidget.routeName);
                    },
                    child: Icon(
                      FFIcons.knoteBold,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AuthUserStreamWidget(
                  builder: (context) => FutureBuilder<List<TaskRecordsRow>>(
                    future: TaskRecordsTable().querySingleRow(
                      queryFn: (q) => q
                          .inFilterOrNull(
                            'courseID',
                            (currentUserDocument?.coursesEnrolled.toList() ??
                                    [])
                                .map((e) => e.courseID)
                                .toList(),
                          )
                          .gtOrNull(
                            'taskStartTime',
                            supaSerialize<DateTime>(getCurrentTimestamp),
                          )
                          .order('taskStartTime', ascending: true),
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
                      List<TaskRecordsRow> containerTaskRecordsRowList =
                          snapshot.data!;

                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final containerTaskRecordsRow =
                          containerTaskRecordsRowList.isNotEmpty
                              ? containerTaskRecordsRowList.first
                              : null;

                      return Container(
                        width: double.infinity,
                        height: 170.0,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 12.0, 12.0, 12.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 160.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
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
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Upcoming:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w800,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          containerTaskRecordsRow?.taskName,
                                          'TaskName Undefined',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      if (containerTaskRecordsRow?.taskType ==
                                          TaskType.assignment.name)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 2.0),
                                          child: Text(
                                            '${dateTimeFormat(
                                              "yMMMd",
                                              containerTaskRecordsRow
                                                  ?.taskDueDate,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )} - ${dateTimeFormat(
                                              "jm",
                                              containerTaskRecordsRow
                                                  ?.taskDueDate,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 11.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      if (containerTaskRecordsRow?.taskType !=
                                          TaskType.assignment.name)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 2.0),
                                          child: Text(
                                            '${dateTimeFormat(
                                              "yMMMd",
                                              containerTaskRecordsRow
                                                  ?.taskStartTime,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )} - ${dateTimeFormat(
                                              "jm",
                                              containerTaskRecordsRow
                                                  ?.taskStartTime,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 11.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      Divider(
                                        thickness: 1.5,
                                        indent: 4.0,
                                        endIndent: 4.0,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 4.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    containerTaskRecordsRow
                                                                ?.taskType ==
                                                            TaskType
                                                                .assignment.name
                                                        ? 'Assignment Deadline: '
                                                        : 'Exam Starts In:',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 11.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    containerTaskRecordsRow
                                                                ?.taskType ==
                                                            TaskType
                                                                .assignment.name
                                                        ? functions
                                                            .relativeTimeLonger(
                                                                containerTaskRecordsRow!
                                                                    .taskDueDate!)
                                                        : functions.relativeTimeLonger(
                                                            containerTaskRecordsRow!
                                                                .taskStartTime!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .outfit(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              FFIcons.kclockCountdownBold,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 32.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                        .addToStart(SizedBox(height: 5.0))
                                        .addToEnd(SizedBox(height: 5.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primary,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                          unselectedLabelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                          indicatorColor: FlutterFlowTheme.of(context).primary,
                          tabs: [
                            Tab(
                              text: 'Assignments',
                            ),
                            Tab(
                              text: 'Exams',
                            ),
                          ],
                          controller: _model.mainBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.mainBarController,
                          children: [
                            KeepAliveWidgetWrapper(
                              builder: (context) => SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 6.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) =>
                                            FutureBuilder<List<TaskRecordsRow>>(
                                          future: (_model.requestCompleter2 ??=
                                                  Completer<
                                                      List<TaskRecordsRow>>()
                                                    ..complete(
                                                        TaskRecordsTable()
                                                            .queryRows(
                                                      queryFn: (q) => q
                                                          .inFilterOrNull(
                                                            'courseID',
                                                            (currentUserDocument
                                                                        ?.coursesEnrolled
                                                                        .toList() ??
                                                                    [])
                                                                .map((e) =>
                                                                    e.courseID)
                                                                .toList(),
                                                          )
                                                          .eqOrNull(
                                                            'taskType',
                                                            TaskType.assignment
                                                                .name,
                                                          )
                                                          .gtOrNull(
                                                            'taskDueDate',
                                                            supaSerialize<
                                                                    DateTime>(
                                                                getCurrentTimestamp),
                                                          )
                                                          .order(
                                                              'taskStartTime',
                                                              ascending: true),
                                                      limit: 4,
                                                    )))
                                              .future,
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 25.0,
                                                  height: 25.0,
                                                  child: SpinKitFadingCube(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 25.0,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<TaskRecordsRow>
                                                listViewTaskRecordsRowList =
                                                snapshot.data!;

                                            if (listViewTaskRecordsRowList
                                                .isEmpty) {
                                              return EmptyClassWidget(
                                                imageUrl:
                                                    'https://cdn-icons-gif.flaticon.com/16104/16104409.gif',
                                                title: 'No Assignments Yet!',
                                                description:
                                                    'You’re all caught up. When new assignments are posted, they’ll appear here — stay tuned and stay ahead!',
                                              );
                                            }

                                            return RefreshIndicator(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .velvetSky,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                              strokeWidth: 3.5,
                                              onRefresh: () async {
                                                logFirebaseEvent(
                                                    'TASKS_ListView_v5nr7lsv_ON_PULL_TO_REFRE');
                                                logFirebaseEvent(
                                                    'ListView_refresh_database_request');
                                                safeSetState(() => _model
                                                    .requestCompleter2 = null);
                                                await _model
                                                    .waitForRequestCompleted2();
                                              },
                                              child: ListView.separated(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  5.0,
                                                  0,
                                                  0,
                                                ),
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    listViewTaskRecordsRowList
                                                        .length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder:
                                                    (context, listViewIndex) {
                                                  final listViewTaskRecordsRow =
                                                      listViewTaskRecordsRowList[
                                                          listViewIndex];
                                                  return wrapWithModel(
                                                    model: _model
                                                        .assignmentBlockModels1
                                                        .getModel(
                                                      listViewTaskRecordsRow.id,
                                                      listViewIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        AssignmentBlockWidget(
                                                      key: Key(
                                                        'Key7p4_${listViewTaskRecordsRow.id}',
                                                      ),
                                                      taskRecord:
                                                          listViewTaskRecordsRow,
                                                      indexInList:
                                                          listViewIndex,
                                                    ),
                                                  );
                                                },
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
                            KeepAliveWidgetWrapper(
                              builder: (context) => SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 6.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) =>
                                            FutureBuilder<List<TaskRecordsRow>>(
                                          future: (_model.requestCompleter1 ??=
                                                  Completer<
                                                      List<TaskRecordsRow>>()
                                                    ..complete(
                                                        TaskRecordsTable()
                                                            .queryRows(
                                                      queryFn: (q) => q
                                                          .inFilterOrNull(
                                                            'courseID',
                                                            (currentUserDocument
                                                                        ?.coursesEnrolled
                                                                        .toList() ??
                                                                    [])
                                                                .map((e) =>
                                                                    e.courseID)
                                                                .toList(),
                                                          )
                                                          .eqOrNull(
                                                            'taskType',
                                                            TaskType.exam.name,
                                                          )
                                                          .gtOrNull(
                                                            'taskStartTime',
                                                            supaSerialize<
                                                                    DateTime>(
                                                                getCurrentTimestamp),
                                                          )
                                                          .order(
                                                              'taskStartTime',
                                                              ascending: true),
                                                      limit: 4,
                                                    )))
                                              .future,
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 25.0,
                                                  height: 25.0,
                                                  child: SpinKitFadingCube(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 25.0,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<TaskRecordsRow>
                                                listViewTaskRecordsRowList =
                                                snapshot.data!;

                                            if (listViewTaskRecordsRowList
                                                .isEmpty) {
                                              return EmptyClassWidget(
                                                imageUrl:
                                                    'https://cdn-icons-gif.flaticon.com/16678/16678375.gif',
                                                title: ' No Upcoming Exams!',
                                                description:
                                                    'Enjoy the calm! Your exam schedule will show up here as soon as it’s available. Keep preparing and stay confident!',
                                              );
                                            }

                                            return RefreshIndicator(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .velvetSky,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                              strokeWidth: 3.5,
                                              onRefresh: () async {
                                                logFirebaseEvent(
                                                    'TASKS_ListView_tk90c255_ON_PULL_TO_REFRE');
                                                logFirebaseEvent(
                                                    'ListView_refresh_database_request');
                                                safeSetState(() => _model
                                                    .requestCompleter1 = null);
                                                await _model
                                                    .waitForRequestCompleted1();
                                              },
                                              child: ListView.separated(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  5.0,
                                                  0,
                                                  0,
                                                ),
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    listViewTaskRecordsRowList
                                                        .length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 5.0),
                                                itemBuilder:
                                                    (context, listViewIndex) {
                                                  final listViewTaskRecordsRow =
                                                      listViewTaskRecordsRowList[
                                                          listViewIndex];
                                                  return wrapWithModel(
                                                    model: _model
                                                        .assignmentBlockModels2
                                                        .getModel(
                                                      listViewTaskRecordsRow.id,
                                                      listViewIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        AssignmentBlockWidget(
                                                      key: Key(
                                                        'Keyosu_${listViewTaskRecordsRow.id}',
                                                      ),
                                                      taskRecord:
                                                          listViewTaskRecordsRow,
                                                      indexInList:
                                                          listViewIndex,
                                                    ),
                                                  );
                                                },
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
