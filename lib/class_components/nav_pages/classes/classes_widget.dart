import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/class_components/class_block_custom/class_block_custom_widget.dart';
import '/class_components/class_block_general/class_block_general_widget.dart';
import '/class_components/class_block_missed/class_block_missed_widget.dart';
import '/components/empty_calender_widget.dart';
import '/empty_list_comp/empty_class/empty_class_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'classes_model.dart';
export 'classes_model.dart';

class ClassesWidget extends StatefulWidget {
  const ClassesWidget({super.key});

  static String routeName = 'classes';
  static String routePath = 'classes';

  @override
  State<ClassesWidget> createState() => _ClassesWidgetState();
}

class _ClassesWidgetState extends State<ClassesWidget>
    with TickerProviderStateMixin {
  late ClassesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassesModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'classes'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CLASSES_PAGE_classes_ON_INIT_STATE');
      logFirebaseEvent('classes_custom_action');
      _model.missedClassesLoad = await actions.getMissedClasses(
        currentUserUid,
        (currentUserDocument?.coursesEnrolled.toList() ?? [])
            .map((e) => e.courseID)
            .toList()
            .toList(),
        false,
      );
      logFirebaseEvent('classes_custom_action');
      _model.customClassesQuery = await actions.fetchAllClasses(
        currentUserReference!,
      );
      logFirebaseEvent('classes_update_page_state');
      _model.missedClasses =
          _model.missedClassesLoad!.toList().cast<ClassRowStruct>();
      _model.customClasses =
          _model.customClassesQuery!.toList().cast<ClassRowStruct>();
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
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
        title: 'classes',
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
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Classes',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          fontSize: 26.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineSmallIsCustom,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Text(
                            valueOrDefault<String>(
                              valueOrDefault(currentUserDocument?.amplix, 0)
                                  .toString(),
                              '0',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 15.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Magic_Icon_Pack.png',
                              width: 25.0,
                              height: 25.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Text(
                            valueOrDefault<String>(
                              valueOrDefault(
                                      currentUserDocument?.currentStreak, 0)
                                  .toString(),
                              '0',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 5.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Fire_Animated_Icon_(1).gif',
                              width: 25.0,
                              height: 28.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(-1.0, 0),
                      child: FlutterFlowButtonTabBar(
                        useToggleButtonStyle: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                        unselectedLabelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                        labelColor: FlutterFlowTheme.of(context).primaryText,
                        unselectedLabelColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        backgroundColor: FlutterFlowTheme.of(context).accent1,
                        borderWidth: 0.0,
                        borderRadius: 0.0,
                        elevation: 0.0,
                        buttonMargin:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        tabs: [
                          Tab(
                            text: 'All Classes',
                          ),
                          Tab(
                            text: 'Missed',
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          KeepAliveWidgetWrapper(
                            builder: (context) => Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 6.0, 8.0, 0.0),
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Text(
                                                  'Overall Classes (${functions.overallTotalClasses((currentUserDocument?.coursesEnrolled.toList() ?? []).toList()).toString()}):',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'CLASSES_PAGE_Row_1klltaj8_ON_TAP');
                                                logFirebaseEvent(
                                                    'Row_navigate_to');

                                                context.pushNamed(
                                                    ClassArchivesWidget
                                                        .routeName);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    FFIcons.knotepadBold,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 18.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                4.0, 0.0),
                                                    child: Text(
                                                      'View QuickNotes',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FlutterFlowDropDown<int>(
                                              controller: _model
                                                      .dropDownValueController1 ??=
                                                  FormFieldController<int>(
                                                _model.dropDownValue1 ??= 7,
                                              ),
                                              options:
                                                  List<int>.from([7, 14, 30]),
                                              optionLabels: [
                                                'Last 7 Days',
                                                'Last 14 Days',
                                                'Last 30 Days'
                                              ],
                                              onChanged: (val) async {
                                                safeSetState(() => _model
                                                    .dropDownValue1 = val);
                                                logFirebaseEvent(
                                                    'CLASSES_DropDown_35ys4ukh_ON_FORM_WIDGET');
                                                logFirebaseEvent(
                                                    'DropDown_update_page_state');
                                                _model.numDays =
                                                    _model.dropDownValue1!;
                                                safeSetState(() {});
                                              },
                                              width: 110.0,
                                              height: 26.0,
                                              textStyle: FlutterFlowTheme.of(
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              hintText: 'Filter',
                                              icon: Icon(
                                                FFIcons.kfilter01,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 18.0,
                                              ),
                                              fillColor: Colors.black,
                                              elevation: 2.0,
                                              borderColor: Colors.transparent,
                                              borderWidth: 0.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              hidesUnderline: true,
                                              isOverButton: false,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            ),
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .dropDownValueController2 ??=
                                                  FormFieldController<String>(
                                                _model.dropDownValue2 ??= '0',
                                              ),
                                              options: List<String>.from(
                                                  ['2', '1', '12', '0']),
                                              optionLabels: [
                                                'Include Sundays',
                                                'Include Saturdays',
                                                'Include Both',
                                                'Don\'t include Weekends'
                                              ],
                                              onChanged: (val) async {
                                                safeSetState(() => _model
                                                    .dropDownValue2 = val);
                                                logFirebaseEvent(
                                                    'CLASSES_DropDown_s6ujuy63_ON_FORM_WIDGET');
                                                logFirebaseEvent(
                                                    'DropDown_update_page_state');
                                                _model.includeSundays = (_model
                                                            .dropDownValue2 ==
                                                        '2') ||
                                                    (_model.dropDownValue2 ==
                                                        '12');
                                                _model
                                                    .includeSaturdays = (_model
                                                            .dropDownValue2 ==
                                                        '1') ||
                                                    (_model.dropDownValue2 ==
                                                        '12');
                                                safeSetState(() {});
                                              },
                                              width: 165.0,
                                              height: 25.0,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              hintText: 'Select...',
                                              icon: Icon(
                                                Icons.filter_list,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 18.0,
                                              ),
                                              fillColor: Colors.black,
                                              elevation: 2.0,
                                              borderColor: Colors.transparent,
                                              borderWidth: 0.0,
                                              borderRadius: 6.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              hidesUnderline: true,
                                              isOverButton: false,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            ),
                                          ],
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final pastDate = functions
                                                .generatePastDates(
                                                    valueOrDefault<bool>(
                                                      _model.includeSundays,
                                                      false,
                                                    ),
                                                    valueOrDefault<bool>(
                                                      _model.includeSaturdays,
                                                      false,
                                                    ),
                                                    _model.numDays,
                                                    dateTimeFromSecondsSinceEpoch(
                                                        (String var1) {
                                                      return DateTime(
                                                                  int.parse(
                                                                      var1.split(
                                                                              '/')[
                                                                          2]),
                                                                  int.parse(
                                                                      var1.split(
                                                                              '/')[
                                                                          1]),
                                                                  int.parse(var1
                                                                      .split(
                                                                          '/')[0]))
                                                              .millisecondsSinceEpoch ~/
                                                          1000;
                                                    }('1/5/2025')))
                                                .toList()
                                                .take(100)
                                                .toList();

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: pastDate.length,
                                              itemBuilder:
                                                  (context, pastDateIndex) {
                                                final pastDateItem =
                                                    pastDate[pastDateIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  2.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          dateTimeFormat(
                                                            "MMMMEEEEd",
                                                            pastDateItem,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          'Sunday, May 18',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .outfit(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 18.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    FutureBuilder<
                                                        List<
                                                            TimetableRecordsRow>>(
                                                      future: FFAppState()
                                                          .timetableRecordsQueryDay(
                                                        uniqueQueryKey:
                                                            'dayQueryTimetable_${dateTimeFormat(
                                                          "d/M/y",
                                                          pastDateItem,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )}',
                                                        requestFn: () =>
                                                            TimetableRecordsTable()
                                                                .queryRows(
                                                          queryFn: (q) => q
                                                              .eqOrNull(
                                                                'classDate',
                                                                dateTimeFormat(
                                                                  "d/M/y",
                                                                  pastDateItem,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                              )
                                                              .order(
                                                                  'classStartTime'),
                                                          limit: 8,
                                                        ),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 25.0,
                                                              height: 25.0,
                                                              child:
                                                                  SpinKitFadingCube(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 25.0,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<TimetableRecordsRow>
                                                            listViewTimetableRecordsRowList =
                                                            snapshot.data!;

                                                        if (listViewTimetableRecordsRowList
                                                            .isEmpty) {
                                                          return Center(
                                                            child: Container(
                                                              height: 1.0,
                                                              child:
                                                                  EmptyCalenderWidget(),
                                                            ),
                                                          );
                                                        }

                                                        return RefreshIndicator(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .velvetSky,
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .accent4,
                                                          strokeWidth: 3.5,
                                                          onRefresh: () async {
                                                            logFirebaseEvent(
                                                                'CLASSES_ListView_8cpyw520_ON_PULL_TO_REF');
                                                            logFirebaseEvent(
                                                                'ListView_clear_query_cache');
                                                            FFAppState()
                                                                .clearTimetableRecordsQueryDayCacheKey(
                                                                    'dayQueryTimetable_${dateTimeFormat(
                                                              "d/M/y",
                                                              pastDateItem,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )}');
                                                          },
                                                          child:
                                                              ListView.builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                listViewTimetableRecordsRowList
                                                                    .length,
                                                            itemBuilder: (context,
                                                                listViewIndex) {
                                                              final listViewTimetableRecordsRow =
                                                                  listViewTimetableRecordsRowList[
                                                                      listViewIndex];
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            2.0),
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .classBlockGeneralModels
                                                                      .getModel(
                                                                    listViewTimetableRecordsRow
                                                                        .classID,
                                                                    listViewIndex,
                                                                  ),
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  updateOnChange:
                                                                      true,
                                                                  child:
                                                                      ClassBlockGeneralWidget(
                                                                    key: Key(
                                                                      'Keybzg_${listViewTimetableRecordsRow.classID}',
                                                                    ),
                                                                    classID:
                                                                        listViewTimetableRecordsRow
                                                                            .classID,
                                                                    courseID:
                                                                        listViewTimetableRecordsRow
                                                                            .courseID,
                                                                    courseName:
                                                                        listViewTimetableRecordsRow
                                                                            .courseName!,
                                                                    classStartTime:
                                                                        listViewTimetableRecordsRow
                                                                            .classStartTime!,
                                                                    classEndTime:
                                                                        listViewTimetableRecordsRow
                                                                            .classEndTime!,
                                                                    classRecord:
                                                                        listViewTimetableRecordsRow,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    if (_model.customClasses
                                                        .where((e) =>
                                                            e.weekday ==
                                                            (dateTimeFormat(
                                                              "EEEE",
                                                              pastDateItem,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ).toLowerCase()))
                                                        .toList()
                                                        .isNotEmpty)
                                                      Builder(
                                                        builder: (context) {
                                                          final customClassesList = _model
                                                              .customClasses
                                                              .where((e) =>
                                                                  (e.weekday ==
                                                                      (dateTimeFormat(
                                                                        "EEEE",
                                                                        pastDateItem,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      )
                                                                          .toLowerCase())) &&
                                                                  (e.createdAt >=
                                                                      pastDateItem))
                                                              .toList()
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.classStartTime,
                                                                  desc: true)
                                                              .toList()
                                                              .take(6)
                                                              .toList();
                                                          if (customClassesList
                                                              .isEmpty) {
                                                            return Center(
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/Empty_Icon.png',
                                                                width: 80.0,
                                                                height: 120.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            );
                                                          }

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                customClassesList
                                                                    .length,
                                                            separatorBuilder:
                                                                (_, __) =>
                                                                    SizedBox(
                                                                        height:
                                                                            2.0),
                                                            itemBuilder: (context,
                                                                customClassesListIndex) {
                                                              final customClassesListItem =
                                                                  customClassesList[
                                                                      customClassesListIndex];
                                                              return wrapWithModel(
                                                                model: _model
                                                                    .classBlockCustomModels
                                                                    .getModel(
                                                                  customClassesListItem
                                                                      .classID,
                                                                  customClassesListIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                updateOnChange:
                                                                    true,
                                                                child:
                                                                    ClassBlockCustomWidget(
                                                                  key: Key(
                                                                    'Keyzqz_${customClassesListItem.classID}',
                                                                  ),
                                                                  courseID:
                                                                      customClassesListItem
                                                                          .courseID,
                                                                  courseName:
                                                                      customClassesListItem
                                                                          .courseName,
                                                                  classStartTime:
                                                                      functions.convertToDateTime(
                                                                          customClassesListItem
                                                                              .classStartTime),
                                                                  classEndTime:
                                                                      functions.convertToDateTime(
                                                                          customClassesListItem
                                                                              .classEndTime),
                                                                  weekday:
                                                                      pastDateItem,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          KeepAliveWidgetWrapper(
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 6.0, 8.0, 0.0),
                                        child: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        'Missed Classes (${valueOrDefault<String>(
                                                          _model.missedClasses
                                                              .length
                                                              .toString(),
                                                          '0',
                                                        )}):',
                                                        'Missed Classes (0):',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .headlineSmall
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      logFirebaseEvent(
                                                          'CLASSES_PAGE_REFRESH_BTN_ON_TAP');
                                                      logFirebaseEvent(
                                                          'Button_custom_action');
                                                      await actions
                                                          .clearMissedClassesCache(
                                                        currentUserUid,
                                                      );
                                                      logFirebaseEvent(
                                                          'Button_custom_action');
                                                      _model.refreshedMissedClasses =
                                                          await actions
                                                              .getMissedClasses(
                                                        currentUserUid,
                                                        (currentUserDocument
                                                                    ?.coursesEnrolled
                                                                    .toList() ??
                                                                [])
                                                            .map((e) =>
                                                                e.courseID)
                                                            .toList(),
                                                        true,
                                                      );
                                                      logFirebaseEvent(
                                                          'Button_update_page_state');
                                                      _model.missedClasses = _model
                                                          .refreshedMissedClasses!
                                                          .toList()
                                                          .cast<
                                                              ClassRowStruct>();
                                                      safeSetState(() {});

                                                      safeSetState(() {});
                                                    },
                                                    text: 'Refresh',
                                                    icon: Icon(
                                                      Icons.sync_rounded,
                                                      size: 18.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 100.0,
                                                      height: 25.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  12.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                      elevation: 0.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 6.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  12.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          logFirebaseEvent(
                                                              'CLASSES_PAGE_Button_tcu5257z_ON_TAP');
                                                          if (_model
                                                              .multiSelectMode) {
                                                            logFirebaseEvent(
                                                                'Button_update_page_state');
                                                            _model.selectedclasses =
                                                                [];
                                                            _model.multiSelectMode =
                                                                false;
                                                            safeSetState(() {});
                                                          } else {
                                                            logFirebaseEvent(
                                                                'Button_update_page_state');
                                                            _model.multiSelectMode =
                                                                true;
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        text: valueOrDefault<
                                                            String>(
                                                          _model.multiSelectMode
                                                              ? 'Deselect All'
                                                              : 'Multi-Select',
                                                          'Multi-Select',
                                                        ),
                                                        icon: Icon(
                                                          FFIcons
                                                              .kselectMultiple,
                                                          size: 12.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 110.0,
                                                          height: 25.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      12.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .outfit(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    if (_model.multiSelectMode)
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          logFirebaseEvent(
                                                              'CLASSES_PAGE_CHECK_IN_BTN_ON_TAP');
                                                          if (_model
                                                              .selectedclasses
                                                              .isNotEmpty) {
                                                            logFirebaseEvent(
                                                                'Button_alert_dialog');
                                                            var confirmDialogResponse =
                                                                await showDialog<
                                                                        bool>(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (alertDialogContext) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text('Confirm Check-In'),
                                                                          content:
                                                                              Text('Are you sure you want to check into ${valueOrDefault<String>(
                                                                            _model.selectedclasses.length.toString(),
                                                                            '0',
                                                                          )} classes at once?   This action cannot be undone.'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                              child: Text('No, Go Back'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                              child: Text('Yes, Check In'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ) ??
                                                                    false;
                                                            if (confirmDialogResponse) {
                                                              logFirebaseEvent(
                                                                  'Button_show_snack_bar');
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .clearSnackBars();
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Checking you into ${valueOrDefault<String>(
                                                                      _model
                                                                          .selectedclasses
                                                                          .length
                                                                          .toString(),
                                                                      '0',
                                                                    )} classes — this may take a moment.',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).labelSmallFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).info,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).labelSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          10000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                ),
                                                              );
                                                              logFirebaseEvent(
                                                                  'Button_update_page_state');
                                                              _model.multiSelectMode =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                              for (int loop1Index =
                                                                      0;
                                                                  loop1Index <
                                                                      _model
                                                                          .selectedclasses
                                                                          .length;
                                                                  loop1Index++) {
                                                                final currentLoop1Item =
                                                                    _model.selectedclasses[
                                                                        loop1Index];
                                                                logFirebaseEvent(
                                                                    'Button_action_block');
                                                                await action_blocks
                                                                    .checkInAttendanceProtocal(
                                                                  context,
                                                                  classID:
                                                                      currentLoop1Item
                                                                          .classID,
                                                                  courseID:
                                                                      currentLoop1Item
                                                                          .courseID,
                                                                  classStartTime:
                                                                      currentLoop1Item
                                                                          .classStartTime,
                                                                );
                                                                logFirebaseEvent(
                                                                    'Button_custom_action');
                                                                await actions
                                                                    .removeMissedClass(
                                                                  currentUserUid,
                                                                  currentLoop1Item
                                                                      .classID,
                                                                );
                                                                logFirebaseEvent(
                                                                    'Button_update_app_state');
                                                                FFAppState().addToUpdateCacheFor(
                                                                    currentLoop1Item
                                                                        .classID);
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                              logFirebaseEvent(
                                                                  'Button_show_snack_bar');
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .clearSnackBars();
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Checked into ${valueOrDefault<String>(
                                                                      _model
                                                                          .selectedclasses
                                                                          .length
                                                                          .toString(),
                                                                      '0',
                                                                    )} classes successfully! 🎉',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).labelSmallFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).info,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).labelSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .presentGreen,
                                                                ),
                                                              );
                                                              logFirebaseEvent(
                                                                  'Button_custom_action');
                                                              _model.newMissedClasses =
                                                                  await actions
                                                                      .getMissedClasses(
                                                                currentUserUid,
                                                                (currentUserDocument
                                                                            ?.coursesEnrolled
                                                                            .toList() ??
                                                                        [])
                                                                    .map((e) =>
                                                                        e.courseID)
                                                                    .toList(),
                                                                true,
                                                              );
                                                              logFirebaseEvent(
                                                                  'Button_update_page_state');
                                                              _model.selectedclasses =
                                                                  [];
                                                              _model.missedClasses = _model
                                                                  .newMissedClasses!
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRowStruct>();
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          }

                                                          safeSetState(() {});
                                                        },
                                                        text: 'Check In',
                                                        icon: Icon(
                                                          FFIcons.kchecks,
                                                          size: 16.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 90.0,
                                                          height: 25.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      6.0,
                                                                      0.0,
                                                                      6.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .velvetSky,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .outfit(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        showLoadingIndicator:
                                                            false,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 0.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final missedClassesList =
                                                        _model.missedClasses
                                                            .toList();
                                                    if (missedClassesList
                                                        .isEmpty) {
                                                      return EmptyClassWidget(
                                                        imageUrl:
                                                            'https://cdn-icons-gif.flaticon.com/16768/16768698.gif',
                                                        title:
                                                            'Flawless Attendance! 🔥',
                                                        description:
                                                            'You’ve shown up for every class. Nicely done.',
                                                      );
                                                    }

                                                    return ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          missedClassesList
                                                              .length,
                                                      separatorBuilder: (_,
                                                              __) =>
                                                          SizedBox(height: 2.0),
                                                      itemBuilder: (context,
                                                          missedClassesListIndex) {
                                                        final missedClassesListItem =
                                                            missedClassesList[
                                                                missedClassesListIndex];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      2.0),
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .classBlockMissedModels
                                                                .getModel(
                                                              missedClassesListItem
                                                                  .classID,
                                                              missedClassesListIndex,
                                                            ),
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            updateOnChange:
                                                                true,
                                                            child:
                                                                ClassBlockMissedWidget(
                                                              key: Key(
                                                                'Keyrzs_${missedClassesListItem.classID}',
                                                              ),
                                                              classID:
                                                                  missedClassesListItem
                                                                      .classID,
                                                              courseID:
                                                                  missedClassesListItem
                                                                      .courseID,
                                                              courseName:
                                                                  missedClassesListItem
                                                                      .courseName,
                                                              isCustomClass:
                                                                  false,
                                                              classStartTime: functions
                                                                  .convertToDateTime(
                                                                      missedClassesListItem
                                                                          .classStartTime),
                                                              classEndTime: functions
                                                                  .convertToDateTime(
                                                                      missedClassesListItem
                                                                          .classEndTime),
                                                              multiSelectMode:
                                                                  _model
                                                                      .multiSelectMode,
                                                              msCallbackAddToList:
                                                                  (classID,
                                                                      courseID) async {
                                                                logFirebaseEvent(
                                                                    'CLASSES_PAGE_Container_rzs3zwdc_CALLBACK');
                                                                logFirebaseEvent(
                                                                    'classBlock_missed_update_page_state');
                                                                _model.addToSelectedclasses(
                                                                    MissedClassDetailsStruct(
                                                                  classID:
                                                                      classID,
                                                                  courseID:
                                                                      courseID,
                                                                  classStartTime:
                                                                      functions.convertToDateTime(
                                                                          missedClassesListItem
                                                                              .classStartTime),
                                                                ));
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              msCallbackRemoveFromList:
                                                                  (classID,
                                                                      courseID) async {
                                                                logFirebaseEvent(
                                                                    'CLASSES_PAGE_Container_rzs3zwdc_CALLBACK');
                                                                logFirebaseEvent(
                                                                    'classBlock_missed_update_page_state');
                                                                _model.removeFromSelectedclasses(
                                                                    MissedClassDetailsStruct(
                                                                  classID:
                                                                      classID,
                                                                  courseID:
                                                                      courseID,
                                                                  classStartTime:
                                                                      functions.convertToDateTime(
                                                                          missedClassesListItem
                                                                              .classStartTime),
                                                                ));
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
            ),
          ),
        ));
  }
}
