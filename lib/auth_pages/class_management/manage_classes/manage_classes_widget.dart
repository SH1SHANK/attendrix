import '/auth/firebase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/manage_class_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manage_classes_model.dart';
export 'manage_classes_model.dart';

class ManageClassesWidget extends StatefulWidget {
  const ManageClassesWidget({super.key});

  static String routeName = 'manageClasses';
  static String routePath = 'manageClasses';

  @override
  State<ManageClassesWidget> createState() => _ManageClassesWidgetState();
}

class _ManageClassesWidgetState extends State<ManageClassesWidget> {
  late ManageClassesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManageClassesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'manageClasses'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MANAGE_CLASSES_manageClasses_ON_INIT_STA');
      logFirebaseEvent('manageClasses_update_page_state');
      _model.selectedDate = getCurrentTimestamp;
      safeSetState(() {});
    });

    _model.classVenueTextController ??= TextEditingController();
    _model.classVenueFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CourseRecordsRow>>(
      stream: _model.manageClassesSupabaseStream ??= SupaFlow.client
          .from("courseRecords")
          .stream(primaryKey: ['courseID']).map(
              (list) => list.map((item) => CourseRecordsRow(item)).toList()),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF87CDFB),
            body: Center(
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: SpinKitFadingCube(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 25.0,
                ),
              ),
            ),
          );
        }
        List<CourseRecordsRow> manageClassesCourseRecordsRowList =
            snapshot.data!;

        return Title(
            title: 'manageClasses',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0xFF87CDFB),
                body: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF04A4F8),
                              Color(0xFF38B0FB),
                              Color(0xFFB5B8FD),
                              Color(0xFF87CDFB)
                            ],
                            stops: [0.0, 0.5, 0.75, 1.0],
                            begin: AlignmentDirectional(0.0, -1.0),
                            end: AlignmentDirectional(0, 1.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 6.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 20.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'MANAGE_CLASSES_PAGE_Row_goky7u1c_ON_TAP');
                                    logFirebaseEvent('Row_navigate_to');

                                    context.goNamed(
                                      DashboardWidget.routeName,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.leftToRight,
                                        ),
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        FFIcons.karrowLeft,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        size: 32.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Back To Dashboard',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4.0, 0.0, 0.0, 0.0),
                                      child: FlutterFlowDropDown<String>(
                                        controller:
                                            _model.dropDownValueController1 ??=
                                                FormFieldController<String>(
                                          _model.dropDownValue1 ??= '0',
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
                                          safeSetState(() =>
                                              _model.dropDownValue1 = val);
                                          logFirebaseEvent(
                                              'MANAGE_CLASSES_DropDown_p45wm2fq_ON_FORM');
                                          logFirebaseEvent(
                                              'DropDown_update_page_state');
                                          _model.sundaysIncluded =
                                              (_model.dropDownValue1 == '2') ||
                                                  (_model.dropDownValue1 ==
                                                      '12');
                                          _model.saturdaysIncluded =
                                              (_model.dropDownValue1 == '1') ||
                                                  (_model.dropDownValue1 ==
                                                      '12');
                                          safeSetState(() {});
                                        },
                                        width: 160.0,
                                        height: 25.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Select...',
                                        icon: Icon(
                                          Icons.filter_list,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 18.0,
                                        ),
                                        fillColor: Colors.black,
                                        elevation: 2.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0.0,
                                        borderRadius: 6.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        hidesUnderline: true,
                                        isOverButton: false,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 12.0, 0.0),
                                      child: FlutterFlowDropDown<int>(
                                        controller:
                                            _model.dropDownValueController2 ??=
                                                FormFieldController<int>(
                                          _model.dropDownValue2 ??= 16,
                                        ),
                                        options: List<int>.from(
                                            [16, 24, 32, 48, 60]),
                                        optionLabels: [
                                          '16 Days',
                                          '24 Days',
                                          '32 Days',
                                          '48 Days',
                                          '60 Days'
                                        ],
                                        onChanged: (val) async {
                                          safeSetState(() =>
                                              _model.dropDownValue2 = val);
                                          logFirebaseEvent(
                                              'MANAGE_CLASSES_DropDown_9oahbnjf_ON_FORM');
                                          logFirebaseEvent(
                                              'DropDown_update_page_state');
                                          _model.daysToRender =
                                              valueOrDefault<int>(
                                            _model.dropDownValue2,
                                            16,
                                          );
                                          safeSetState(() {});
                                        },
                                        width: 84.0,
                                        height: 25.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Select...',
                                        icon: Icon(
                                          FFIcons.kfilter01,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 16.0,
                                        ),
                                        fillColor: Colors.black,
                                        elevation: 2.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0.0,
                                        borderRadius: 6.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        hidesUnderline: true,
                                        isOverButton: false,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final upcomingDays = functions
                                        .datesGenerator(
                                            getCurrentTimestamp,
                                            16,
                                            _model.sundaysIncluded,
                                            _model.saturdaysIncluded)
                                        .toList()
                                        .take(20)
                                        .toList();

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children:
                                            List.generate(upcomingDays.length,
                                                (upcomingDaysIndex) {
                                          final upcomingDaysItem =
                                              upcomingDays[upcomingDaysIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 4.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'MANAGE_CLASSES_Container_lvotgjs4_ON_TAP');
                                                logFirebaseEvent(
                                                    'Container_update_page_state');
                                                _model.selectedDate =
                                                    upcomingDaysItem;
                                                safeSetState(() {});
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 2.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                                child: Container(
                                                  width: valueOrDefault<double>(
                                                    dateTimeFormat(
                                                              "d/M/y",
                                                              _model
                                                                  .selectedDate,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ) ==
                                                            dateTimeFormat(
                                                              "d/M/y",
                                                              upcomingDaysItem,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                        ? 52.0
                                                        : 48.0,
                                                    52.0,
                                                  ),
                                                  height:
                                                      valueOrDefault<double>(
                                                    dateTimeFormat(
                                                              "d/M/y",
                                                              _model
                                                                  .selectedDate,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ) ==
                                                            dateTimeFormat(
                                                              "d/M/y",
                                                              upcomingDaysItem,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                        ? 90.0
                                                        : 85.0,
                                                    85.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if (dateTimeFormat(
                                                              "d/M/y",
                                                              _model
                                                                  .selectedDate,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ) ==
                                                            dateTimeFormat(
                                                              "d/M/y",
                                                              upcomingDaysItem,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .primary;
                                                        } else if (dateTimeFormat(
                                                              "d/M/y",
                                                              _model
                                                                  .selectedDate,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ) !=
                                                            dateTimeFormat(
                                                              "d/M/y",
                                                              upcomingDaysItem,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .info;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .info;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                            "EE",
                                                            upcomingDaysItem,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  dateTimeFormat(
                                                                            "d/M/y",
                                                                            _model.selectedDate,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ) ==
                                                                          dateTimeFormat(
                                                                            "d/M/y",
                                                                            upcomingDaysItem,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          )
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .info
                                                                      : Colors
                                                                          .black,
                                                                  Colors.black,
                                                                ),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
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
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 35.0,
                                                          height: 35.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                dateTimeFormat(
                                                                  "dd",
                                                                  upcomingDaysItem,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                '08',
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
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      dateTimeFormat(
                                                                                "d/M/y",
                                                                                _model.selectedDate,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ) ==
                                                                              dateTimeFormat(
                                                                                "d/M/y",
                                                                                upcomingDaysItem,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              )
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .black,
                                                                      Colors
                                                                          .black,
                                                                    ),
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
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
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ].addToStart(SizedBox(height: 20.0)),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          ),
                        ),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 16.0, 0.0, 4.0),
                                child: Text(
                                  'Available Courses:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (valueOrDefault<bool>(
                                    (currentUserDocument?.coursesEnrolled
                                                .toList() ??
                                            [])
                                        .where((e) => e.isEditable == true)
                                        .toList()
                                        .isNotEmpty,
                                    true,
                                  ))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) =>
                                            FlutterFlowDropDown<String>(
                                          controller: _model
                                                  .courseNameValueController ??=
                                              FormFieldController<String>(
                                            _model.courseNameValue ??= '',
                                          ),
                                          options: List<String>.from(
                                              (currentUserDocument
                                                          ?.coursesEnrolled
                                                          .toList() ??
                                                      [])
                                                  .where((e) =>
                                                      e.isEditable == true)
                                                  .toList()
                                                  .map((e) => e.courseID)
                                                  .toList()),
                                          optionLabels: (currentUserDocument
                                                      ?.coursesEnrolled
                                                      .toList() ??
                                                  [])
                                              .where(
                                                  (e) => e.isEditable == true)
                                              .toList()
                                              .map((e) => e.courseName)
                                              .toList(),
                                          onChanged: (val) => safeSetState(() =>
                                              _model.courseNameValue = val),
                                          width: double.infinity,
                                          height: 48.0,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          hintText: 'Select Course Name',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 2.0,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          borderWidth: 2.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          hidesUnderline: true,
                                          isOverButton: false,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ),
                                    ),
                                  if (!valueOrDefault<bool>(
                                    (currentUserDocument?.coursesEnrolled
                                                .toList() ??
                                            [])
                                        .where((e) => e.isEditable == true)
                                        .toList()
                                        .isNotEmpty,
                                    false,
                                  ))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          width: double.infinity,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'No Available Courses! Requires Admin Access',
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
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 8.0, 0.0, 4.0),
                                child: Text(
                                  'Class Date:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            '${dateTimeFormat(
                                              "EEEE",
                                              _model.selectedDate,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )}, ${dateTimeFormat(
                                              "yMMMd",
                                              _model.selectedDate,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 16.0,
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
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 16.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'MANAGE_CLASSES_PAGE_Icon_oakrtlfy_ON_TAP');
                                            logFirebaseEvent(
                                                'Icon_date_time_picker');
                                            final _datePickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: getCurrentTimestamp,
                                              firstDate: getCurrentTimestamp,
                                              lastDate: DateTime(2050),
                                              builder: (context, child) {
                                                return wrapInMaterialDatePickerTheme(
                                                  context,
                                                  child!,
                                                  headerBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  headerForegroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  headerTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeFamily,
                                                            fontSize: 32.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLargeIsCustom,
                                                          ),
                                                  pickerBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  pickerForegroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  selectedDateTimeBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  selectedDateTimeForegroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  actionButtonForegroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  iconSize: 24.0,
                                                );
                                              },
                                            );

                                            if (_datePickedDate != null) {
                                              safeSetState(() {
                                                _model.datePicked = DateTime(
                                                  _datePickedDate.year,
                                                  _datePickedDate.month,
                                                  _datePickedDate.day,
                                                );
                                              });
                                            } else if (_model.datePicked !=
                                                null) {
                                              safeSetState(() {
                                                _model.datePicked =
                                                    getCurrentTimestamp;
                                              });
                                            }
                                            logFirebaseEvent(
                                                'Icon_update_page_state');
                                            _model.selectedDate =
                                                _model.datePicked != null
                                                    ? _model.datePicked
                                                    : getCurrentTimestamp;
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            FFIcons.kcalendarDateNote,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 4.0, 18.0, 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Class Start Time:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!valueOrDefault<bool>(
                                _model.customStartTime,
                                true,
                              ))
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6.0, 6.0, 6.0, 6.0),
                                    child: FlutterFlowChoiceChips(
                                      options: [
                                        ChipData('8:00 AM'),
                                        ChipData('9:00 AM'),
                                        ChipData('10:00 AM'),
                                        ChipData('11:00 AM'),
                                        ChipData('12:00 PM'),
                                        ChipData('1:00 PM'),
                                        ChipData('2:00 PM'),
                                        ChipData('3:00 PM'),
                                        ChipData('4:00 PM'),
                                        ChipData('5:00 PM'),
                                        ChipData('6:00 PM')
                                      ],
                                      onChanged: (val) async {
                                        safeSetState(() =>
                                            _model.classStartTimeValue =
                                                val?.firstOrNull);
                                        logFirebaseEvent(
                                            'MANAGE_CLASSES_classStartTime_ON_FORM_WI');
                                        logFirebaseEvent(
                                            'classStartTime_update_page_state');
                                        _model.startTime = () {
                                          if (_model.classStartTimeValue ==
                                              '8:00 AM') {
                                            return 8;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '9:00 AM') {
                                            return 9;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '10:00 AM') {
                                            return 10;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '11:00 AM') {
                                            return 11;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '12:00 PM') {
                                            return 12;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '1:00 PM') {
                                            return 13;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '2:00 PM') {
                                            return 14;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '3:00 PM') {
                                            return 15;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '4:00 PM') {
                                            return 16;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '5:00 PM') {
                                            return 17;
                                          } else if (_model
                                                  .classStartTimeValue ==
                                              '6:00 PM') {
                                            return 18;
                                          } else {
                                            return 6;
                                          }
                                        }();
                                        safeSetState(() {});
                                      },
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        iconColor:
                                            FlutterFlowTheme.of(context).info,
                                        iconSize: 14.0,
                                        elevation: 2.0,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      unselectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodyMediumIsCustom,
                                            ),
                                        iconColor: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        iconSize: 16.0,
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      chipSpacing: 8.0,
                                      rowSpacing: 8.0,
                                      multiselect: false,
                                      alignment: WrapAlignment.center,
                                      controller: _model
                                              .classStartTimeValueController ??=
                                          FormFieldController<List<String>>(
                                        [],
                                      ),
                                      wrapped: true,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Class Duration (in Minutes):',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 0.0, 18.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: FlutterFlowCountController(
                                    decrementIconBuilder: (enabled) => Icon(
                                      Icons.remove_rounded,
                                      color: enabled
                                          ? FlutterFlowTheme.of(context)
                                              .secondaryText
                                          : FlutterFlowTheme.of(context)
                                              .alternate,
                                      size: 32.0,
                                    ),
                                    incrementIconBuilder: (enabled) => Icon(
                                      Icons.add_rounded,
                                      color: enabled
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .alternate,
                                      size: 32.0,
                                    ),
                                    countBuilder: (count) => Text(
                                      count.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleLargeFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleLargeIsCustom,
                                          ),
                                    ),
                                    count: _model.classEndTimeValue ??= 50,
                                    updateCount: (count) async {
                                      safeSetState(() =>
                                          _model.classEndTimeValue = count);
                                      logFirebaseEvent(
                                          'MANAGE_CLASSES_classEndTime_ON_FORM_WIDG');
                                      logFirebaseEvent(
                                          'classEndTime_update_page_state');
                                      _model.endTime =
                                          _model.classEndTimeValue!;
                                      safeSetState(() {});
                                    },
                                    stepSize: 10,
                                    minimum: 10,
                                    maximum: 200,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 8.0, 0.0, 4.0),
                                child: Text(
                                  'Class Venue:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 0.0, 18.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: _model.classVenueTextController,
                                    focusNode: _model.classVenueFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      hintText: 'NLHC 101...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .classVenueTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 4.0),
                                      child: Text(
                                        'Is It a Plus Slot?',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18.0, 0.0, 0.0, 0.0),
                                        child: FlutterFlowChoiceChips(
                                          options: [
                                            ChipData('Yes'),
                                            ChipData('No')
                                          ],
                                          onChanged: (val) => safeSetState(() =>
                                              _model.isPlusSlotValue =
                                                  val?.firstOrNull),
                                          selectedChipStyle: ChipStyle(
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLargeFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLargeIsCustom,
                                                    ),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            iconSize: 16.0,
                                            elevation: 2.0,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          unselectedChipStyle: ChipStyle(
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmallFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmallIsCustom,
                                                    ),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            iconSize: 16.0,
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          chipSpacing: 8.0,
                                          rowSpacing: 8.0,
                                          multiselect: false,
                                          initialized:
                                              _model.isPlusSlotValue != null,
                                          alignment: WrapAlignment.start,
                                          controller: _model
                                                  .isPlusSlotValueController ??=
                                              FormFieldController<List<String>>(
                                            ['No'],
                                          ),
                                          wrapped: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 4.0),
                                      child: Text(
                                        'Is It An Extra Class?',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18.0, 0.0, 0.0, 0.0),
                                        child: FlutterFlowChoiceChips(
                                          options: [
                                            ChipData('Yes'),
                                            ChipData('No')
                                          ],
                                          onChanged: (val) => safeSetState(() =>
                                              _model.isExtraClassValue =
                                                  val?.firstOrNull),
                                          selectedChipStyle: ChipStyle(
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmallFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmallIsCustom,
                                                    ),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            iconSize: 16.0,
                                            elevation: 2.0,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          unselectedChipStyle: ChipStyle(
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmallFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmallIsCustom,
                                                    ),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            iconSize: 16.0,
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          chipSpacing: 8.0,
                                          rowSpacing: 8.0,
                                          multiselect: false,
                                          initialized:
                                              _model.isExtraClassValue != null,
                                          alignment: WrapAlignment.start,
                                          controller: _model
                                                  .isExtraClassValueController ??=
                                              FormFieldController<List<String>>(
                                            ['No'],
                                          ),
                                          wrapped: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      28.0, 20.0, 28.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: !((_model.courseNameValue !=
                                                    null &&
                                                _model.courseNameValue != '') &&
                                            (_model.classStartTimeValue !=
                                                    null &&
                                                _model.classStartTimeValue !=
                                                    '') &&
                                            (_model.classEndTimeValue != null))
                                        ? null
                                        : () async {
                                            logFirebaseEvent(
                                                'MANAGE_CLASSES_scheduleButton_ON_TAP');
                                            logFirebaseEvent(
                                                'scheduleButton_update_page_state');
                                            _model
                                                .updateClassCancellationTemplateStruct(
                                              (e) =>
                                                  e..classCancellationScore = 0,
                                            );
                                            safeSetState(() {});
                                            logFirebaseEvent(
                                                'scheduleButton_backend_call');
                                            _model.generatedClass =
                                                await TimetableRecordsTable()
                                                    .insert({
                                              'classID': (String courseCode,
                                                      String dateTime,
                                                      String batchCode) {
                                                return dateTime +
                                                    '-' +
                                                    batchCode +
                                                    '-' +
                                                    courseCode;
                                              }(
                                                  (currentUserDocument
                                                              ?.coursesEnrolled
                                                              .toList() ??
                                                          [])
                                                      .where((e) =>
                                                          e.courseID ==
                                                          _model
                                                              .courseNameValue)
                                                      .toList()
                                                      .firstOrNull!
                                                      .courseID,
                                                  dateTimeFormat(
                                                    "HH/mm/dd/MM/yyyy",
                                                    functions.addTime(
                                                        functions.generalizeDate(
                                                            _model
                                                                .selectedDate!),
                                                        _model.startTime,
                                                        'HH'),
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ),
                                                  'ME02'),
                                              'courseID':
                                                  _model.courseNameValue,
                                              'batchID': valueOrDefault(
                                                  currentUserDocument?.batchID,
                                                  ''),
                                              'createdTime':
                                                  supaSerialize<DateTime>(
                                                      getCurrentTimestamp),
                                              'courseName': (currentUserDocument
                                                          ?.coursesEnrolled
                                                          .toList() ??
                                                      [])
                                                  .where((e) =>
                                                      e.courseID ==
                                                      _model.courseNameValue)
                                                  .toList()
                                                  .firstOrNull
                                                  ?.courseName,
                                              'classStartTime': supaSerialize<
                                                      DateTime>(
                                                  functions.addTime(
                                                      functions.generalizeDate(
                                                          _model.selectedDate!),
                                                      _model.startTime,
                                                      'HH')),
                                              'classEndTime': supaSerialize<
                                                      DateTime>(
                                                  functions.addTime(
                                                      functions.addTime(
                                                          functions.generalizeDate(
                                                              _model
                                                                  .selectedDate!),
                                                          _model.startTime,
                                                          'HH'),
                                                      _model.classEndTimeValue!,
                                                      'MM')),
                                              'isPlusSlot':
                                                  _model.isPlusSlotValue ==
                                                      'Yes',
                                              'classDate': dateTimeFormat(
                                                "d/M/y",
                                                _model.selectedDate,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ),
                                              'courseType': (currentUserDocument
                                                          ?.coursesEnrolled
                                                          .toList() ??
                                                      [])
                                                  .where((e) =>
                                                      e.courseID ==
                                                      _model.courseNameValue)
                                                  .toList()
                                                  .firstOrNull
                                                  ?.courseType
                                                  .toMap(),
                                              'classStatus': _model
                                                  .classCancellationTemplate
                                                  ?.toMap(),
                                              'classVenue':
                                                  valueOrDefault<String>(
                                                _model.classVenueTextController
                                                    .text,
                                                'NLHC 101',
                                              ),
                                            });
                                            if (_model.generatedClass != null) {
                                              logFirebaseEvent(
                                                  'scheduleButton_show_snack_bar');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Class for ${_model.generatedClass?.courseName} created successfully!',
                                                    style: GoogleFonts.outfit(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            } else {
                                              logFirebaseEvent(
                                                  'scheduleButton_action_block');
                                              await action_blocks
                                                  .universalErrorSnackbar(
                                                context,
                                                errorMessage:
                                                    'We Encountered An Error While Creating The Class',
                                              );
                                              safeSetState(() {});
                                            }

                                            safeSetState(() {});
                                          },
                                    text: 'Schedule Class',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 45.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 3.0,
                                      borderRadius: BorderRadius.circular(12.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      disabledTextColor: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 6.0),
                                      child: Text(
                                        'Chosen Date Timetable:',
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
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    StreamBuilder<List<TimetableRecordsRow>>(
                                      stream: _model.listViewSupabaseStream ??=
                                          SupaFlow.client
                                              .from("timetableRecords")
                                              .stream(primaryKey: ['classID'])
                                              .eqOrNull(
                                                'classDate',
                                                dateTimeFormat(
                                                  "d/M/y",
                                                  _model.selectedDate,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                              )
                                              .order('classStartTime')
                                              .limit(8)
                                              .map((list) => list
                                                  .map((item) =>
                                                      TimetableRecordsRow(item))
                                                  .toList()),
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
                                        List<TimetableRecordsRow>
                                            listViewTimetableRecordsRowList =
                                            snapshot.data!;

                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              listViewTimetableRecordsRowList
                                                  .length,
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewTimetableRecordsRow =
                                                listViewTimetableRecordsRowList[
                                                    listViewIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 2.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onLongPress: () async {
                                                  logFirebaseEvent(
                                                      'MANAGE_CLASSES_Container_s51kbh0w_ON_LON');
                                                  logFirebaseEvent(
                                                      'Container_bottom_sheet');
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
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
                                                              ManageClassBottomSheetWidget(
                                                            classID:
                                                                listViewTimetableRecordsRow
                                                                    .classID,
                                                            classRef:
                                                                listViewTimetableRecordsRow,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 35.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF7B6FF8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                4.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
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
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  listViewTimetableRecordsRow
                                                                      .courseName,
                                                                  '[courseName]',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .outfit(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          12.0,
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
                                                                          8.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              ' Class Time: ',
                                                                          style:
                                                                              GoogleFonts.outfit(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize:
                                                                                9.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              dateTimeFormat(
                                                                            "jm",
                                                                            listViewTimetableRecordsRow.classStartTime!,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.outfit(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                fontSize: 10.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' - ',
                                                                          style:
                                                                              GoogleFonts.outfit(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontSize:
                                                                                11.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              dateTimeFormat(
                                                                            "jm",
                                                                            listViewTimetableRecordsRow.classEndTime!,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          style:
                                                                              GoogleFonts.outfit(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize:
                                                                                10.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ', ',
                                                                          style:
                                                                              GoogleFonts.outfit(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize:
                                                                                10.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              dateTimeFormat(
                                                                            "MMMMEEEEd",
                                                                            listViewTimetableRecordsRow.classStartTime!,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          style:
                                                                              GoogleFonts.outfit(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize:
                                                                                10.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.outfit(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
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
                                  ],
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
            ));
      },
    );
  }
}
