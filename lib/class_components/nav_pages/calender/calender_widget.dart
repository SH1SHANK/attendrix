import '/backend/supabase/supabase.dart';
import '/class_components/class_block_calender/class_block_calender_widget.dart';
import '/components/empty_calender_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calender_model.dart';
export 'calender_model.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  static String routeName = 'calender';
  static String routePath = 'calender';

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  late CalenderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalenderModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'calender'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CALENDER_PAGE_calender_ON_INIT_STATE');
      logFirebaseEvent('calender_backend_call');
      _model.initialTimetablerecords = await TimetableRecordsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'classDate',
          dateTimeFormat(
            "d/M/y",
            getCurrentTimestamp,
            locale: FFLocalizations.of(context).languageCode,
          ),
        ),
      );
      logFirebaseEvent('calender_update_page_state');
      _model.selectedDate = getCurrentTimestamp;
      _model.timetableRecords =
          _model.initialTimetablerecords!.toList().cast<TimetableRecordsRow>();
      safeSetState(() {});
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
        title: 'calender',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).background2,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kcalendarMonth,
                                color: Colors.black,
                                size: 26.0,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 0.0, 0.0, 0.0),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          dateTimeFormat(
                                            "MMMM",
                                            _model.selectedDate,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ),
                                          'May',
                                        ),
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
                                              color: Color(0xFF58617B),
                                              fontSize: 24.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          dateTimeFormat(
                                            "yyyy",
                                            _model.selectedDate,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ),
                                          '2025',
                                        ),
                                        style: GoogleFonts.outfit(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      )
                                    ],
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
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 4.0),
                        child: Builder(
                          builder: (context) {
                            final upcomingDays = functions
                                .datesGenerator(
                                    getCurrentTimestamp,
                                    valueOrDefault<int>(
                                      _model.daysToRender,
                                      16,
                                    ),
                                    _model.includeSundays,
                                    _model.includeSaturdays)
                                .toList()
                                .take(60)
                                .toList();

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(upcomingDays.length,
                                    (upcomingDaysIndex) {
                                  final upcomingDaysItem =
                                      upcomingDays[upcomingDaysIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 4.0, 2.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'CALENDER_PAGE_Container_rf2l8afm_ON_TAP');
                                        logFirebaseEvent(
                                            'Container_backend_call');
                                        _model.selectedDayTimetableRecordsSelected =
                                            await TimetableRecordsTable()
                                                .queryRows(
                                          queryFn: (q) => q.eqOrNull(
                                            'classDate',
                                            dateTimeFormat(
                                              "d/M/y",
                                              upcomingDaysItem,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                          ),
                                        );
                                        logFirebaseEvent(
                                            'Container_update_page_state');
                                        _model.selectedDate = upcomingDaysItem;
                                        _model.timetableRecords = _model
                                            .selectedDayTimetableRecordsSelected!
                                            .toList()
                                            .cast<TimetableRecordsRow>();
                                        safeSetState(() {});

                                        safeSetState(() {});
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 0.5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: Container(
                                          width: 50.0,
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                            color: valueOrDefault<Color>(
                                              dateTimeFormat(
                                                        "d/M/y",
                                                        _model.selectedDate,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ) ==
                                                      dateTimeFormat(
                                                        "d/M/y",
                                                        upcomingDaysItem,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .info,
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 10.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    dateTimeFormat(
                                                      "EE",
                                                      upcomingDaysItem,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    ),
                                                    'Mon',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .outfit(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color:
                                                                valueOrDefault<
                                                                    Color>(
                                                              dateTimeFormat(
                                                                        "d/M/y",
                                                                        _model
                                                                            .selectedDate,
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
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Container(
                                                  width: 28.0,
                                                  height: 28.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        dateTimeFormat(
                                                          "dd",
                                                          upcomingDaysItem,
                                                          locale:
                                                              FFLocalizations.of(
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
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.black,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
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
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController1 ??=
                                FormFieldController<String>(
                              _model.dropDownValue1 ??= '0',
                            ),
                            options: List<String>.from(['2', '1', '12', '0']),
                            optionLabels: [
                              'Include Sundays',
                              'Include Saturdays',
                              'Include Both',
                              'Don\'t include Weekends'
                            ],
                            onChanged: (val) async {
                              safeSetState(() => _model.dropDownValue1 = val);
                              logFirebaseEvent(
                                  'CALENDER_DropDown_weujsb10_ON_FORM_WIDGE');
                              logFirebaseEvent('DropDown_update_page_state');
                              _model.includeSundays =
                                  (_model.dropDownValue1 == '2') ||
                                      (_model.dropDownValue1 == '12');
                              _model.includeSaturdays =
                                  (_model.dropDownValue1 == '1') ||
                                      (_model.dropDownValue1 == '12');
                              safeSetState(() {});
                            },
                            width: 165.0,
                            height: 25.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 10.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            hintText: 'Select...',
                            icon: Icon(
                              Icons.filter_list,
                              color: FlutterFlowTheme.of(context).info,
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                2.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowDropDown<int>(
                              controller: _model.dropDownValueController2 ??=
                                  FormFieldController<int>(
                                _model.dropDownValue2 ??= 16,
                              ),
                              options: List<int>.from([16, 24, 32, 48, 60]),
                              optionLabels: [
                                '16 Days',
                                '24 Days',
                                '32 Days',
                                '48 Days',
                                '60 Days'
                              ],
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue2 = val);
                                logFirebaseEvent(
                                    'CALENDER_DropDown_3zhofwuz_ON_FORM_WIDGE');
                                logFirebaseEvent('DropDown_update_page_state');
                                _model.daysToRender = valueOrDefault<int>(
                                  _model.dropDownValue2,
                                  16,
                                );
                                safeSetState(() {});
                              },
                              width: 80.0,
                              height: 25.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hintText: 'Select...',
                              icon: Icon(
                                FFIcons.kfilter01,
                                color: FlutterFlowTheme.of(context).info,
                                size: 14.0,
                              ),
                              fillColor: Colors.black,
                              elevation: 2.0,
                              borderColor: Colors.transparent,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final availableTimeSlots = functions
                                  .generateAvailableTimeSlots(
                                      _model.timetableRecords.toList(),
                                      _model.selectedDate)
                                  ?.toList() ??
                              [];
                          if (availableTimeSlots.isEmpty) {
                            return Center(
                              child: Image.asset(
                                'assets/images/Empty_Icon.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.fill,
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: availableTimeSlots.length,
                            itemBuilder: (context, availableTimeSlotsIndex) {
                              final availableTimeSlotsItem =
                                  availableTimeSlots[availableTimeSlotsIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 4.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (functions.timeProximity(
                                                availableTimeSlotsItem) ==
                                            'past')
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/Check_icon.png',
                                              width: 20.0,
                                              height: 20.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        if (functions.timeProximity(
                                                availableTimeSlotsItem) ==
                                            'future')
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/UI_Dot_Icon_(1).png',
                                              width: 18.0,
                                              height: 18.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        if (functions.timeProximity(
                                                availableTimeSlotsItem) ==
                                            'present')
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/UI_Dot_Icon.png',
                                              width: 18.0,
                                              height: 18.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              dateTimeFormat(
                                                "jm",
                                                availableTimeSlotsItem,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ),
                                              '10:00 AM',
                                            ),
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
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
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
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4.0, 0.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Builder(
                                            builder: (context) {
                                              final specificSlotClass = _model
                                                  .timetableRecords
                                                  .where((e) =>
                                                      e.classStartTime ==
                                                      availableTimeSlotsItem)
                                                  .toList()
                                                  .take(1)
                                                  .toList();
                                              if (specificSlotClass.isEmpty) {
                                                return Center(
                                                  child: Container(
                                                    height: 40.0,
                                                    child:
                                                        EmptyCalenderWidget(),
                                                  ),
                                                );
                                              }

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    specificSlotClass.length,
                                                itemBuilder: (context,
                                                    specificSlotClassIndex) {
                                                  final specificSlotClassItem =
                                                      specificSlotClass[
                                                          specificSlotClassIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 6.0),
                                                    child: wrapWithModel(
                                                      model: _model
                                                          .classBlockCalenderModels
                                                          .getModel(
                                                        availableTimeSlotsItem
                                                            .microsecondsSinceEpoch
                                                            .toString(),
                                                        specificSlotClassIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      updateOnChange: true,
                                                      child:
                                                          ClassBlockCalenderWidget(
                                                        key: Key(
                                                          'Key90t_${availableTimeSlotsItem.microsecondsSinceEpoch.toString()}',
                                                        ),
                                                        timetableRecord:
                                                            specificSlotClassItem,
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
                                  if (!valueOrDefault<bool>(
                                    _model.timetableRecords
                                        .where((e) =>
                                            e.classStartTime ==
                                            availableTimeSlotsItem)
                                        .toList()
                                        .isNotEmpty,
                                    true,
                                  ))
                                    Container(
                                      width: double.infinity,
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                        color: Color(0x99606A85),
                                      ),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ].addToStart(SizedBox(height: 30.0)),
                ),
              ),
            ),
          ),
        ));
  }
}
