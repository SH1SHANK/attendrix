import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'analytics_model.dart';
export 'analytics_model.dart';

class AnalyticsWidget extends StatefulWidget {
  const AnalyticsWidget({super.key});

  static String routeName = 'analytics';
  static String routePath = 'analytics';

  @override
  State<AnalyticsWidget> createState() => _AnalyticsWidgetState();
}

class _AnalyticsWidgetState extends State<AnalyticsWidget> {
  late AnalyticsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalyticsModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'analytics'});
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
        title: 'analytics',
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'ANALYTICS_PAGE_Icon_yt6dppjj_ON_TAP');
                              logFirebaseEvent('Icon_navigate_back');
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 32.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Analytics',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 26.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => FlutterFlowDropDown<String>(
                          multiSelectController:
                              _model.dropDownValueController1 ??=
                                  FormListFieldController<String>(null),
                          options: List<String>.from(
                              (currentUserDocument?.coursesEnrolled.toList() ??
                                      [])
                                  .map((e) => e.courseID)
                                  .toList()),
                          optionLabels:
                              (currentUserDocument?.coursesEnrolled.toList() ??
                                      [])
                                  .map((e) => e.courseName)
                                  .toList(),
                          width: double.infinity,
                          height: 45.0,
                          textStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                          hintText: 'Select The Courses...',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 1.0,
                          borderRadius: 12.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          hidesUnderline: true,
                          isOverButton: false,
                          isSearchable: false,
                          isMultiSelect: true,
                          onMultiSelectChanged: (val) async {
                            safeSetState(() => _model.dropDownValue1 = val);
                            logFirebaseEvent(
                                'ANALYTICS_DropDown_kmlt7bwb_ON_FORM_WIDG');
                            logFirebaseEvent('DropDown_update_page_state');
                            _model.courseIDs =
                                _model.dropDownValue1!.toList().cast<String>();
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 5.0, 12.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                2.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController2 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue2 ??= '7d',
                              ),
                              options: List<String>.from(['7d', '14d', '30d']),
                              optionLabels: [
                                'Last 7 Days',
                                'Last 14 Days',
                                'Last 30 Days'
                              ],
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue2 = val);
                                logFirebaseEvent(
                                    'ANALYTICS_DropDown_0za7ewf3_ON_FORM_WIDG');
                                logFirebaseEvent('DropDown_update_page_state');
                                _model.period = valueOrDefault<String>(
                                  _model.dropDownValue2,
                                  '7d',
                                );
                                safeSetState(() {});
                              },
                              width: 100.0,
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
                              hintText: 'Time Range',
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
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  6.0, 0.0, 0.0, 0.0),
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Last Updated:',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                    TextSpan(
                                      text: valueOrDefault<String>(
                                        dateTimeFormat(
                                          "relative",
                                          currentUserDocument
                                              ?.lastDataFetchTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        'a while ago',
                                      ),
                                      style: GoogleFonts.outfit(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.0,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 800.0,
                        child: custom_widgets.AttendanceGraphWidget(
                          width: double.infinity,
                          height: 800.0,
                          userID: currentUserUid,
                          availableCourseIds: _model.courseIDs,
                          period: valueOrDefault<String>(
                            _model.period,
                            '7d',
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
