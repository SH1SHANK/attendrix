import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/sgpa_grade_card_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'c_g_p_a_calculator_model.dart';
export 'c_g_p_a_calculator_model.dart';

class CGPACalculatorWidget extends StatefulWidget {
  const CGPACalculatorWidget({super.key});

  @override
  State<CGPACalculatorWidget> createState() => _CGPACalculatorWidgetState();
}

class _CGPACalculatorWidgetState extends State<CGPACalculatorWidget> {
  late CGPACalculatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CGPACalculatorModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('C_G_P_A_CALCULATOR_CGPACalculator_ON_INI');
      logFirebaseEvent('CGPACalculator_update_component_state');
      _model.enteredGrades = [];
      safeSetState(() {});
      for (int loop1Index = 0;
          loop1Index <
              (currentUserDocument?.coursesEnrolled.toList() ?? [])
                  .where((e) => e.courseType.courseType != 'elective')
                  .toList()
                  .length;
          loop1Index++) {
        final currentLoop1Item =
            (currentUserDocument?.coursesEnrolled.toList() ?? [])
                .where((e) => e.courseType.courseType != 'elective')
                .toList()[loop1Index];
        logFirebaseEvent('CGPACalculator_update_component_state');
        _model.addToEnteredGrades(CourseDetailsStruct(
          courseID: currentLoop1Item.courseID,
          credits: currentLoop1Item.credits,
          gradeSelected: 0,
        ));
        safeSetState(() {});
      }
      logFirebaseEvent('CGPACalculator_update_component_state');
      _model.addToEnteredGrades(CourseDetailsStruct(
        courseID: 'Unknown',
        credits: 3,
        gradeSelected: 0,
      ));
      safeSetState(() {});
      logFirebaseEvent('CGPACalculator_update_component_state');
      _model.addToEnteredGrades(CourseDetailsStruct(
        courseID: 'Unknown',
        credits: 3,
        gradeSelected: 0,
      ));
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 500.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SGPA Calculator',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleLargeFamily,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .titleLargeIsCustom,
                                  ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'C_G_P_A_CALCULATOR_Icon_fj795wgo_ON_TAP');
                                logFirebaseEvent('Icon_dismiss_dialog');
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: FlutterFlowTheme.of(context).error,
                                size: 28.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AutoSizeText(
                        'Select your semester, enter your grades, and get your SGPA instantly.',
                        minFontSize: 8.0,
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              fontSize: 9.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelSmallIsCustom,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 4.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => Builder(
                      builder: (context) {
                        final courses = (currentUserDocument?.coursesEnrolled
                                    .toList() ??
                                [])
                            .where((e) => e.courseType.courseType != 'elective')
                            .toList();

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: courses.length,
                          separatorBuilder: (_, __) => SizedBox(height: 4.0),
                          itemBuilder: (context, coursesIndex) {
                            final coursesItem = courses[coursesIndex];
                            return wrapWithModel(
                              model: _model.sgpaGradeCardModels.getModel(
                                coursesItem.courseID,
                                coursesIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: SgpaGradeCardWidget(
                                key: Key(
                                  'Keymc2_${coursesItem.courseID}',
                                ),
                                enrolledCourse: coursesItem,
                                onSelected:
                                    (gradeSelected, credits, courseID) async {
                                  logFirebaseEvent(
                                      'C_G_P_A_CALCULATOR_Container_mc2562ox_CA');
                                  logFirebaseEvent(
                                      'sgpaGradeCard_update_component_state');
                                  _model.updateEnteredGradesAtIndex(
                                    coursesIndex,
                                    (e) => e..gradeSelected = gradeSelected,
                                  );
                                  safeSetState(() {});
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AuthUserStreamWidget(
                          builder: (context) => Text(
                            valueOrDefault<String>(
                              (currentUserDocument?.coursesEnrolled.toList() ??
                                          [])
                                      .where((e) =>
                                          e.courseType.electiveCategory == 'OE')
                                      .toList()
                                      .isNotEmpty
                                  ? valueOrDefault<String>(
                                      (currentUserDocument?.coursesEnrolled
                                                  .toList() ??
                                              [])
                                          .where((e) =>
                                              e.courseType.electiveCategory ==
                                              'OE')
                                          .toList()
                                          .firstOrNull
                                          ?.courseName,
                                      'Open Elective',
                                    )
                                  : 'Open Elective',
                              'Open Elective',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ),
                      ),
                      FlutterFlowDropDown<int>(
                        controller: _model.dropDownValueController1 ??=
                            FormFieldController<int>(null),
                        options: List<int>.from([10, 9, 8, 7, 6, 5]),
                        optionLabels: ['S', 'A', 'B', 'C', 'D', 'E'],
                        onChanged: (val) async {
                          safeSetState(() => _model.dropDownValue1 = val);
                          logFirebaseEvent(
                              'C_G_P_A_CALCULATOR_DropDown_oxhi5zwb_ON_');
                          logFirebaseEvent('DropDown_update_component_state');
                          _model.updateEnteredGradesAtIndex(
                            6,
                            (_) => CourseDetailsStruct(
                              courseID: valueOrDefault<String>(
                                (currentUserDocument?.coursesEnrolled
                                            .toList() ??
                                        [])
                                    .where((e) =>
                                        e.courseType.electiveCategory == 'OE')
                                    .toList()
                                    .firstOrNull
                                    ?.courseID,
                                'Open Elective',
                              ),
                              credits: valueOrDefault<int>(
                                (currentUserDocument?.coursesEnrolled
                                            .toList() ??
                                        [])
                                    .where((e) =>
                                        e.courseType.electiveCategory == 'OE')
                                    .toList()
                                    .firstOrNull
                                    ?.credits,
                                3,
                              ),
                              gradeSelected: _model.dropDownValue1,
                            ),
                          );
                          safeSetState(() {});
                        },
                        width: 90.0,
                        height: 35.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        hintText: 'Grade',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        elevation: 2.0,
                        borderColor: FlutterFlowTheme.of(context).alternate,
                        borderWidth: 2.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AuthUserStreamWidget(
                          builder: (context) => Text(
                            valueOrDefault<String>(
                              (currentUserDocument?.coursesEnrolled.toList() ??
                                          [])
                                      .where((e) =>
                                          e.courseType.electiveCategory == 'DA')
                                      .toList()
                                      .isNotEmpty
                                  ? valueOrDefault<String>(
                                      (currentUserDocument?.coursesEnrolled
                                                  .toList() ??
                                              [])
                                          .where((e) =>
                                              e.courseType.electiveCategory ==
                                              'DA')
                                          .toList()
                                          .firstOrNull
                                          ?.courseName,
                                      'Digital Automation ',
                                    )
                                  : 'Digital Automation ',
                              'Digital Automation ',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ),
                      ),
                      FlutterFlowDropDown<int>(
                        controller: _model.dropDownValueController2 ??=
                            FormFieldController<int>(null),
                        options: List<int>.from([10, 9, 8, 7, 6, 5]),
                        optionLabels: ['S', 'A', 'B', 'C', 'D', 'E'],
                        onChanged: (val) async {
                          safeSetState(() => _model.dropDownValue2 = val);
                          logFirebaseEvent(
                              'C_G_P_A_CALCULATOR_DropDown_0k1nnj4z_ON_');
                          logFirebaseEvent('DropDown_update_component_state');
                          _model.updateEnteredGradesAtIndex(
                            7,
                            (_) => CourseDetailsStruct(
                              courseID: valueOrDefault<String>(
                                (currentUserDocument?.coursesEnrolled
                                            .toList() ??
                                        [])
                                    .where((e) =>
                                        e.courseType.electiveCategory == 'DA')
                                    .toList()
                                    .firstOrNull
                                    ?.courseID,
                                'Open Elective',
                              ),
                              credits: valueOrDefault<int>(
                                (currentUserDocument?.coursesEnrolled
                                            .toList() ??
                                        [])
                                    .where((e) =>
                                        e.courseType.electiveCategory == 'DA')
                                    .toList()
                                    .firstOrNull
                                    ?.credits,
                                3,
                              ),
                              gradeSelected: _model.dropDownValue2,
                            ),
                          );
                          safeSetState(() {});
                        },
                        width: 90.0,
                        height: 35.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        hintText: 'Grade',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        elevation: 2.0,
                        borderColor: FlutterFlowTheme.of(context).alternate,
                        borderWidth: 2.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Calculated SGPA: ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        TextSpan(
                          text: valueOrDefault<String>(
                            _model.sgpaValue.toString(),
                            '0.0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleLargeFamily,
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleLargeIsCustom,
                              ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                ),
                if (_model.calculatedGrades?.error != null &&
                    _model.calculatedGrades?.error != '')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Text(
                      _model.calculatedSGPA,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                if (valueOrDefault<bool>(
                  _model.calculatedGrades?.hasError(),
                  false,
                ))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        _model.calculatedGrades?.error,
                        'error',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                if (_model.calculatedGrades?.error != null &&
                    _model.calculatedGrades?.error != '')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        _model.calculatedGrades?.details,
                        'details',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 12.0),
                child: FFButtonWidget(
                  onPressed: (_model.enteredGrades
                          .where((e) => e.gradeSelected == 0)
                          .toList()
                          .isNotEmpty)
                      ? null
                      : () async {
                          logFirebaseEvent(
                              'C_G_P_A_CALCULATOR_CALCULATE_S_G_P_A_BTN');
                          logFirebaseEvent('Button_custom_action');
                          _model.calculatedGrades =
                              await actions.gradeCalculator(
                            _model.enteredGrades.toList(),
                          );
                          logFirebaseEvent('Button_update_component_state');
                          _model.sgpaValue =
                              double.parse(_model.calculatedGrades!.status);
                          _model.calculatedSGPA =
                              _model.calculatedGrades!.message;
                          safeSetState(() {});

                          safeSetState(() {});
                        },
                  text: 'Calculate SGPA',
                  icon: Icon(
                    FFIcons.kcalculatorComputeMathAlt,
                    size: 20.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconColor: FlutterFlowTheme.of(context).info,
                    color: Color(0xDE9489F5),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).titleSmallIsCustom,
                        ),
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(8.0),
                    disabledColor: FlutterFlowTheme.of(context).secondaryText,
                    disabledTextColor: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
