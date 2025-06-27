import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/class_components/elective_selection_block/elective_selection_block_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:styled_divider/styled_divider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'onboarding_model.dart';
export 'onboarding_model.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  static String routeName = 'onboarding';
  static String routePath = 'onboarding';

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget>
    with TickerProviderStateMixin {
  late OnboardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'onboarding'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ONBOARDING_PAGE_onboarding_ON_INIT_STATE');
      logFirebaseEvent('onboarding_backend_call');
      _model.userDoc = await UsersRecord.getDocumentOnce(currentUserReference!);
      if ((_model.userDoc?.username != null &&
              _model.userDoc?.username != '') &&
          (_model.userDoc!.coursesEnrolled.length >= 6) &&
          ((_model.userDoc?.batchID != null && _model.userDoc?.batchID != '') &&
              (_model.userDoc?.semesterID != null &&
                  _model.userDoc?.semesterID != ''))) {
        logFirebaseEvent('onboarding_navigate_to');

        context.goNamed(
          DashboardWidget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.rightToLeft,
            ),
          },
        );

        logFirebaseEvent('onboarding_update_page_state');
        _model.loopParameter = 7;
        safeSetState(() {});
        logFirebaseEvent('onboarding_action_block');
        await action_blocks.universalErrorSnackbar(
          context,
          errorMessage: 'User Data Already Exists.',
        );
      } else {
        logFirebaseEvent('onboarding_backend_call');
        _model.coreCourses = await CourseRecordsTable().queryRows(
          queryFn: (q) => q.eqOrNull(
            'isElective',
            false,
          ),
        );
        logFirebaseEvent('onboarding_backend_call');
        _model.electiveCourses = await CourseRecordsTable().queryRows(
          queryFn: (q) => q.eqOrNull(
            'isElective',
            true,
          ),
        );
        logFirebaseEvent('onboarding_backend_call');
        _model.nptelCourse = await NPTELCoursesQueryCall.call();

        logFirebaseEvent('onboarding_update_page_state');
        _model.coursesEnrolled =
            _model.coreCourses!.toList().cast<CourseRecordsRow>();
        _model.coreCoursesSelected =
            _model.coreCourses!.toList().cast<CourseRecordsRow>();
        _model.batchElectiveCourses =
            _model.electiveCourses!.toList().cast<CourseRecordsRow>();
        _model.nptelCourses = ((_model.nptelCourse?.jsonBody ?? '')
                .toList()
                .map<NptelCourseStruct?>(NptelCourseStruct.maybeFromMap)
                .toList() as Iterable<NptelCourseStruct?>)
            .withoutNulls
            .toList()
            .cast<NptelCourseStruct>();
        safeSetState(() {});
      }
    });

    _model.usernameTextController1 ??= TextEditingController();
    _model.usernameFocusNode1 ??= FocusNode();

    _model.userBioTextController ??= TextEditingController();
    _model.userBioFocusNode ??= FocusNode();
    _model.userBioFocusNode!.addListener(() => safeSetState(() {}));
    _model.usernameTextController2 ??= TextEditingController();
    _model.usernameFocusNode2 ??= FocusNode();

    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
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
    return FutureBuilder<List<BatchRecordsRow>>(
      future: BatchRecordsTable().querySingleRow(
        queryFn: (q) => q,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).info,
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
        List<BatchRecordsRow> onboardingBatchRecordsRowList = snapshot.data!;

        final onboardingBatchRecordsRow =
            onboardingBatchRecordsRowList.isNotEmpty
                ? onboardingBatchRecordsRowList.first
                : null;

        return Title(
            title: 'onboarding',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).info,
                body: Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _model.onboardingPagesController ??=
                              PageController(
                                  initialPage: max(
                                      0,
                                      min(
                                          valueOrDefault<int>(
                                            () {
                                              if ((_model.userDoc?.username != null && _model.userDoc?.username != '') &&
                                                  (_model
                                                          .userDoc!
                                                          .coursesEnrolled
                                                          .length >=
                                                      6) &&
                                                  ((_model.userDoc?.batchID != null && _model.userDoc?.batchID != '') &&
                                                      (_model.userDoc?.semesterID != null &&
                                                          _model.userDoc?.semesterID !=
                                                              ''))) {
                                                return 3;
                                              } else if ((_model.userDoc?.semesterID != null &&
                                                      _model.userDoc?.semesterID !=
                                                          '') &&
                                                  (_model.userDoc?.batchID != null &&
                                                      _model.userDoc?.batchID !=
                                                          '')) {
                                                return 1;
                                              } else if ((_model.userDoc?.semesterID != null &&
                                                      _model.userDoc?.semesterID !=
                                                          '') &&
                                                  (_model.userDoc?.batchID != null &&
                                                      _model.userDoc?.batchID !=
                                                          '') &&
                                                  (_model.userDoc?.username != null &&
                                                      _model.userDoc?.username != '')) {
                                                return 2;
                                              } else {
                                                return 0;
                                              }
                                            }(),
                                            0,
                                          ),
                                          3))),
                          onPageChanged: (_) => safeSetState(() {}),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 30.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Let\'s Set Up Your Academic Profile',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMediumFamily,
                                                fontSize: 22.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMediumIsCustom,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Text(
                                            'Tell us your name, branch, batch & semester to personalize your experience, you\'re almost there!',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumFamily,
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .labelMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                        Form(
                                          key: _model.formKey1,
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          child: SingleChildScrollView(
                                            primary: false,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'What should we call you?',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .usernameTextController1,
                                                      focusNode: _model
                                                          .usernameFocusNode1,
                                                      autofocus: true,
                                                      autofillHints: [
                                                        AutofillHints.email
                                                      ],
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Your Name',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLargeIsCustom,
                                                                ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .outfit(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .outfit(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                      validator: _model
                                                          .usernameTextController1Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Which branch are you in?',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumIsCustom,
                                                          ),
                                                ),
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .branchValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.branchValue ??= '',
                                                  ),
                                                  options:
                                                      List<String>.from(['ME']),
                                                  optionLabels: [
                                                    'Mechanical Engineering'
                                                  ],
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                          .branchValue = val),
                                                  width: double.infinity,
                                                  height: 50.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmallIsCustom,
                                                      ),
                                                  hintText: 'Branch',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  borderWidth: 2.0,
                                                  borderRadius: 12.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: false,
                                                  isMultiSelect: false,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Which batch do you belong to?',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .batchValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.batchValue ??= '',
                                                  ),
                                                  options:
                                                      List<String>.from(['02']),
                                                  optionLabels: ['ME02'],
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                          .batchValue = val),
                                                  width: double.infinity,
                                                  height: 50.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmallIsCustom,
                                                      ),
                                                  hintText: 'Batch',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  borderWidth: 2.0,
                                                  borderRadius: 12.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: false,
                                                  isMultiSelect: false,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'What’s your current semester?',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                FlutterFlowDropDown<int>(
                                                  controller: _model
                                                          .semesterValueController ??=
                                                      FormFieldController<int>(
                                                          null),
                                                  options: List<int>.from([3]),
                                                  optionLabels: ['Semester 3'],
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                          .semesterValue = val),
                                                  width: double.infinity,
                                                  height: 50.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmallIsCustom,
                                                      ),
                                                  hintText: 'Semester',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  borderWidth: 2.0,
                                                  borderRadius: 12.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: false,
                                                  isMultiSelect: false,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Tell us about yourself:  (Optional)',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: _model
                                                      .userBioTextController,
                                                  focusNode:
                                                      _model.userBioFocusNode,
                                                  autofocus: true,
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeIsCustom,
                                                            ),
                                                    alignLabelWithHint: false,
                                                    hintText:
                                                        'Introduce yourself in a few words.',
                                                    hintStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumIsCustom,
                                                            ),
                                                    errorStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumIsCustom,
                                                            ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16.0,
                                                                16.0,
                                                                16.0,
                                                                16.0),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                                  maxLines: 9,
                                                  minLines: 5,
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  validator: _model
                                                      .userBioTextControllerValidator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    if (!isAndroid && !isiOS)
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        return TextEditingValue(
                                                          selection: newValue
                                                              .selection,
                                                          text: newValue.text
                                                              .toCapitalization(
                                                                  TextCapitalization
                                                                      .words),
                                                        );
                                                      }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 6.0),
                                              child: Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                  ),
                                                  unselectedWidgetColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                ),
                                                child: Checkbox(
                                                  value: _model
                                                      .checkboxValue ??= false,
                                                  onChanged: (newValue) async {
                                                    safeSetState(() =>
                                                        _model.checkboxValue =
                                                            newValue!);
                                                  },
                                                  side: (FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        )
                                                      : null,
                                                  activeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  checkColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.832,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: RichText(
                                                    textScaler:
                                                        MediaQuery.of(context)
                                                            .textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'I confirm that I have read and agree to the ',
                                                          style: TextStyle(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              'Terms and Conditions',
                                                          style: GoogleFonts
                                                              .outfit(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' and',
                                                          style: GoogleFonts
                                                              .outfit(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' Privacy Policy ',
                                                          style: GoogleFonts
                                                              .outfit(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' of Attendrix Inc.',
                                                          style: GoogleFonts
                                                              .outfit(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                        )
                                                      ],
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
                                                                FontWeight.w500,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 30.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'ONBOARDING_PAGE_CONTINUE_BTN_ON_TAP');
                                            logFirebaseEvent(
                                                'Button_validate_form');
                                            _model.academicProfileValidation =
                                                true;
                                            if (_model.formKey1.currentState ==
                                                    null ||
                                                !_model.formKey1.currentState!
                                                    .validate()) {
                                              safeSetState(() => _model
                                                      .academicProfileValidation =
                                                  false);
                                              return;
                                            }
                                            if (_model.branchValue == null) {
                                              _model.academicProfileValidation =
                                                  false;
                                              safeSetState(() {});
                                              return;
                                            }
                                            if (_model.batchValue == null) {
                                              _model.academicProfileValidation =
                                                  false;
                                              safeSetState(() {});
                                              return;
                                            }
                                            if (_model.semesterValue == null) {
                                              _model.academicProfileValidation =
                                                  false;
                                              safeSetState(() {});
                                              return;
                                            }
                                            if (_model
                                                .academicProfileValidation!) {
                                              if (_model.checkboxValue!) {
                                                logFirebaseEvent(
                                                    'Button_backend_call');

                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  batchID:
                                                      '${_model.branchValue}${_model.batchValue}0${_model.semesterValue?.toString()}',
                                                  semesterID: _model
                                                      .semesterValue
                                                      ?.toString(),
                                                  displayName: _model
                                                      .usernameTextController1
                                                      .text,
                                                  userBio: _model
                                                      .userBioTextController
                                                      .text,
                                                ));
                                                logFirebaseEvent(
                                                    'Button_page_view');
                                                await _model
                                                    .onboardingPagesController
                                                    ?.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              } else {
                                                logFirebaseEvent(
                                                    'Button_action_block');
                                                await action_blocks
                                                    .universalErrorSnackbar(
                                                  context,
                                                  errorMessage:
                                                      'please agree to the terms and conditions.',
                                                );
                                                safeSetState(() {});
                                              }
                                            } else {
                                              logFirebaseEvent(
                                                  'Button_action_block');
                                              await action_blocks
                                                  .universalErrorSnackbar(
                                                context,
                                                errorMessage:
                                                    'Invalid Credientials',
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Continue',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 48.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 2.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    FlutterFlowTheme.of(context).info,
                                    Color(0xFFF2E6EE),
                                    Color(0x92927FDD)
                                  ],
                                  stops: [0.0, 0.1, 1.0],
                                  begin: AlignmentDirectional(0.0, -1.0),
                                  end: AlignmentDirectional(0, 1.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Research_New_Pin_Crop.gif',
                                        width: 200.0,
                                        height: 144.4,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Choose Your Username',
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
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 8.0),
                                      child: Text(
                                        'This will be your identity in the world of Attendrix.\nMake it magical or tap the 🪄 wand to summon one if you\'re feeling indecisive.',
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
                                              color: Color(0xFF566077),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Form(
                                            key: _model.formKey2,
                                            autovalidateMode:
                                                AutovalidateMode.disabled,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 2.0, 8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model
                                                      .usernameTextController2,
                                                  focusNode:
                                                      _model.usernameFocusNode2,
                                                  onFieldSubmitted: (_) async {
                                                    logFirebaseEvent(
                                                        'ONBOARDING_username_ON_TEXTFIELD_SUBMIT');
                                                    logFirebaseEvent(
                                                        'username_firestore_query');
                                                    _model.usernameAvailability =
                                                        await queryUsersRecordOnce(
                                                      queryBuilder:
                                                          (usersRecord) =>
                                                              usersRecord.where(
                                                        'username',
                                                        isEqualTo: _model
                                                            .usernameTextController2
                                                            .text,
                                                      ),
                                                      singleRecord: true,
                                                    ).then((s) =>
                                                            s.firstOrNull);
                                                    if (_model
                                                            .usernameAvailability !=
                                                        null) {
                                                      logFirebaseEvent(
                                                          'username_update_page_state');
                                                      _model.usernameAlreadyExists =
                                                          true;
                                                      safeSetState(() {});
                                                    } else {
                                                      logFirebaseEvent(
                                                          'username_update_page_state');
                                                      _model.usernameAlreadyExists =
                                                          false;
                                                      safeSetState(() {});
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  autofocus: true,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'Username',
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeFamily,
                                                              letterSpacing:
                                                                  0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLargeIsCustom,
                                                            ),
                                                    hintStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .override(
                                                              font: GoogleFonts
                                                                  .outfit(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                            ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFE7ECF2),
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                  maxLength: 15,
                                                  maxLengthEnforcement:
                                                      MaxLengthEnforcement
                                                          .enforced,
                                                  buildCounter: (context,
                                                          {required currentLength,
                                                          required isFocused,
                                                          maxLength}) =>
                                                      null,
                                                  validator: _model
                                                      .usernameTextController2Validator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            '[a-zA-Z0-9]'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderRadius: 12.0,
                                            buttonSize: 50.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            icon: Icon(
                                              FFIcons.kbxsMagicWand,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'ONBOARDING_PAGE_bxsMagicWand_ICN_ON_TAP');
                                              logFirebaseEvent(
                                                  'IconButton_custom_action');
                                              _model.uniqueUsername =
                                                  await actions
                                                      .getUniqueUsername();
                                              logFirebaseEvent(
                                                  'IconButton_set_form_field');
                                              safeSetState(() {
                                                _model.usernameTextController2
                                                        ?.text =
                                                    _model.uniqueUsername!;
                                              });

                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (valueOrDefault<bool>(
                                      _model.usernameAlreadyExists,
                                      false,
                                    ))
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'sorry, username already taken',
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
                                                    color: Color(0xFFFF000F),
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
                                                    2.0, 0.0, 0.0, 0.0),
                                            child: Icon(
                                              FFIcons.kalertTriangle,
                                              color: Color(0xFFFA000E),
                                              size: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (!valueOrDefault<bool>(
                                      _model.usernameAlreadyExists,
                                      false,
                                    ))
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'username available',
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
                                                    color: Color(0xFF0F00FF),
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
                                                    2.0, 0.0, 0.0, 0.0),
                                            child: Icon(
                                              FFIcons.ksealCheck,
                                              color: Color(0xFF0033FA),
                                              size: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    Align(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: !((_model.usernameTextController2
                                                              .text !=
                                                          '') &&
                                                  !_model
                                                      .usernameAlreadyExists!)
                                              ? null
                                              : () async {
                                                  logFirebaseEvent(
                                                      'ONBOARDING_PAGE_CONTINUE_BTN_ON_TAP');
                                                  if ((_model.usernameTextController2
                                                                  .text !=
                                                              '') &&
                                                      !_model
                                                          .usernameAlreadyExists!) {
                                                    logFirebaseEvent(
                                                        'Button_backend_call');

                                                    await currentUserReference!
                                                        .update(
                                                            createUsersRecordData(
                                                      username: _model
                                                          .usernameTextController2
                                                          .text
                                                          .toLowerCase(),
                                                    ));
                                                    logFirebaseEvent(
                                                        'Button_page_view');
                                                    await _model
                                                        .onboardingPagesController
                                                        ?.nextPage(
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.ease,
                                                    );
                                                  } else {
                                                    logFirebaseEvent(
                                                        'Button_action_block');
                                                    await action_blocks
                                                        .universalErrorSnackbar(
                                                      context,
                                                      errorMessage:
                                                          'Error 404! Couldn\'t Update Username',
                                                    );
                                                    safeSetState(() {});
                                                    logFirebaseEvent(
                                                        'Button_clear_text_fields_pin_codes');
                                                    safeSetState(() {
                                                      _model
                                                          .usernameTextController2
                                                          ?.clear();
                                                    });
                                                  }
                                                },
                                          text: 'Continue',
                                          icon: Icon(
                                            FFIcons.karrowLeftMD,
                                            size: 22.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconAlignment: IconAlignment.end,
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            disabledColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            disabledTextColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].addToEnd(SizedBox(height: 200.0)),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Your courses for this semester:',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineMediumIsCustom,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      18.0, 2.0, 0.0, 4.0),
                                  child: Text(
                                    'Core Subjects:',
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
                                Builder(
                                  builder: (context) {
                                    final batchCoreCourses =
                                        _model.coreCoursesSelected.toList();
                                    if (batchCoreCourses.isEmpty) {
                                      return Center(
                                        child: Image.asset(
                                          'assets/images/Empty_Icon.png',
                                          width: 100.0,
                                          height: 200.0,
                                        ),
                                      );
                                    }

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: batchCoreCourses.length,
                                      itemBuilder:
                                          (context, batchCoreCoursesIndex) {
                                        final batchCoreCoursesItem =
                                            batchCoreCourses[
                                                batchCoreCoursesIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 2.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 1.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 38.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF1F4F9),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        4.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                        valueOrDefault<String>(
                                                          batchCoreCoursesItem
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
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                batchCoreCoursesItem
                                                                    .courseID
                                                                    .substring(
                                                                        0, 7),
                                                                'ME1001E',
                                                              ),
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 10.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' | ',
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: 'Credits: ',
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                batchCoreCoursesItem
                                                                    .credits
                                                                    ?.toString(),
                                                                '3',
                                                              ),
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 11.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' | ',
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                fontSize: 11.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  'Category: ',
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                () {
                                                                  if (valueOrDefault<
                                                                          String>(
                                                                        batchCoreCoursesItem
                                                                            .courseID
                                                                            .substring(7,
                                                                                9),
                                                                        'ME1001E',
                                                                      ) ==
                                                                      'DE') {
                                                                    return 'Department Elective';
                                                                  } else if (valueOrDefault<
                                                                          String>(
                                                                        batchCoreCoursesItem
                                                                            .courseID
                                                                            .substring(7,
                                                                                9),
                                                                        'ME1001E',
                                                                      ) ==
                                                                      'IC') {
                                                                    return 'Institute Core';
                                                                  } else if (valueOrDefault<
                                                                          String>(
                                                                        batchCoreCoursesItem
                                                                            .courseID
                                                                            .substring(7,
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
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 9.0,
                                                              ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
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
                                        'listViewOnPageLoadAnimation']!);
                                  },
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 24.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StyledDivider(
                                                thickness: 2.0,
                                                indent: 10.0,
                                                endIndent: 10.0,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                lineStyle:
                                                    DividerLineStyle.dashed,
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          18.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Electives:',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              if (valueOrDefault<bool>(
                                                (String? var1, String? var2) {
                                                  return (var1 != null &&
                                                      var2 != null &&
                                                      var1.length >= 11 &&
                                                      var2.length >= 11 &&
                                                      var1.substring(9, 11) ==
                                                          var2.substring(
                                                              9, 11));
                                                }(
                                                    _model
                                                        .electiveCoursesSelected
                                                        .elementAtOrNull(0)
                                                        ?.courseID,
                                                    _model
                                                        .electiveCoursesSelected
                                                        .elementAtOrNull(1)
                                                        ?.courseID),
                                                false,
                                              ))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          6.0, 8.0, 0.0, 4.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Icon(
                                                          FFIcons
                                                              .kalertTriangle,
                                                          color:
                                                              Color(0xFFFA000E),
                                                          size: 12.0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    2.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'Both electives share the same slot.if you\'re sure, feel free to continue!',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFFF000F),
                                                                fontSize: 10.0,
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
                                                    ],
                                                  ),
                                                ),
                                              Builder(
                                                builder: (context) {
                                                  final electives =
                                                      onboardingBatchRecordsRow
                                                              ?.electiveCatalog
                                                              .map((e) => e)
                                                              .toList()
                                                              .toList() ??
                                                          [];
                                                  if (electives.isEmpty) {
                                                    return Center(
                                                      child: Image.asset(
                                                        'assets/images/Empty_Icon.png',
                                                        width: 100.0,
                                                        height: 200.0,
                                                      ),
                                                    );
                                                  }

                                                  return ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: electives.length,
                                                    itemBuilder: (context,
                                                        electivesIndex) {
                                                      final electivesItem =
                                                          electives[
                                                              electivesIndex];
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
                                                              .electiveSelectionBlockModels
                                                              .getModel(
                                                            electivesItem,
                                                            electivesIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          updateOnChange: true,
                                                          child:
                                                              ElectiveSelectionBlockWidget(
                                                            key: Key(
                                                              'Key6dd_${electivesItem}',
                                                            ),
                                                            placeholderText:
                                                                'Choose Your ${() {
                                                              if ((electivesItem
                                                                      .substring(
                                                                          0,
                                                                          2)) ==
                                                                  'OE') {
                                                                return 'Open Elective';
                                                              } else if ((electivesItem
                                                                      .substring(
                                                                          0,
                                                                          2)) ==
                                                                  'DA') {
                                                                return 'Digital Automation Elective';
                                                              } else {
                                                                return 'Elective';
                                                              }
                                                            }()}',
                                                            placeHolderIcon:
                                                                Icon(
                                                              FFIcons
                                                                  .kcompassRoseBold,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 20.0,
                                                            ),
                                                            electiveCategory: (electivesItem
                                                                        .substring(
                                                                            0,
                                                                            2)) ==
                                                                    'OE'
                                                                ? 'DE'
                                                                : (electivesItem
                                                                    .substring(
                                                                        0, 2)),
                                                            electiveCoursesCatalog:
                                                                _model
                                                                    .batchElectiveCourses,
                                                            updateCoursesEnrolled:
                                                                (courseRecord) async {
                                                              logFirebaseEvent(
                                                                  'ONBOARDING_Container_6ddw04st_CALLBACK');
                                                              logFirebaseEvent(
                                                                  'electiveSelectionBlock_update_page_state');
                                                              _model.addToCoursesEnrolled(
                                                                  courseRecord);
                                                              _model.addToElectiveCoursesSelected(
                                                                  courseRecord);
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            removeCoursesEnrolled:
                                                                (courseRecord) async {
                                                              logFirebaseEvent(
                                                                  'ONBOARDING_Container_6ddw04st_CALLBACK');
                                                              logFirebaseEvent(
                                                                  'electiveSelectionBlock_update_page_state');
                                                              _model.removeFromCoursesEnrolled(
                                                                  courseRecord);
                                                              _model.removeFromElectiveCoursesSelected(
                                                                  courseRecord);
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
                                            ],
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'ONBOARDING_PAGE_COMPLETE_BTN_ON_TAP');
                                              logFirebaseEvent(
                                                  'Button_page_view');
                                              await _model
                                                  .onboardingPagesController
                                                  ?.nextPage(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.ease,
                                              );
                                              while (_model.loopParameter! <
                                                  _model
                                                      .coursesEnrolled.length) {
                                                logFirebaseEvent(
                                                    'Button_update_page_state');
                                                _model
                                                    .addToCoursesEnrolledStruct(
                                                        CoursesEnrolledStruct(
                                                  courseID: _model
                                                      .coursesEnrolled
                                                      .elementAtOrNull(
                                                          _model.loopParameter!)
                                                      ?.courseID,
                                                  courseName: _model
                                                      .coursesEnrolled
                                                      .elementAtOrNull(
                                                          _model.loopParameter!)
                                                      ?.courseName,
                                                  courseType: CourseTypeStruct(
                                                    courseType: CourseTypeStruct
                                                            .maybeFromMap(_model
                                                                .coursesEnrolled
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .loopParameter!)
                                                                ?.courseType)
                                                        ?.courseType,
                                                    electiveCategory: CourseTypeStruct
                                                            .maybeFromMap(_model
                                                                .coursesEnrolled
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .loopParameter!)
                                                                ?.courseType)
                                                        ?.electiveCategory,
                                                    isLab: CourseTypeStruct
                                                            .maybeFromMap(_model
                                                                .coursesEnrolled
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .loopParameter!)
                                                                ?.courseType)
                                                        ?.isLab,
                                                  ),
                                                  courseFaculty:
                                                      CourseFacultyStruct(
                                                    electiveFaculty: CourseFacultyStruct
                                                            .maybeFromMap(_model
                                                                .coursesEnrolled
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .loopParameter!)
                                                                ?.courseType)
                                                        ?.electiveFaculty,
                                                    batchFaculty: CourseFacultyStruct
                                                            .maybeFromMap(_model
                                                                .coursesEnrolled
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .loopParameter!)
                                                                ?.courseType)
                                                        ?.batchFaculty,
                                                  ),
                                                  attendedClasses: 0,
                                                  totalClasses: 0,
                                                ));
                                                _model.loopParameter =
                                                    _model.loopParameter! + 1;
                                                safeSetState(() {});
                                                logFirebaseEvent(
                                                    'Button_wait__delay');
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1000));
                                              }
                                              logFirebaseEvent(
                                                  'Button_backend_call');

                                              await currentUserReference!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'coursesEnrolled':
                                                        getCoursesEnrolledListFirestoreData(
                                                      _model
                                                          .coursesEnrolledStruct,
                                                    ),
                                                  },
                                                ),
                                              });
                                              if ((currentUserDocument
                                                              ?.coursesEnrolled
                                                              .toList() ??
                                                          [])
                                                      .length ==
                                                  _model
                                                      .coursesEnrolled.length) {
                                                logFirebaseEvent(
                                                    'Button_navigate_to');

                                                context.goNamed(
                                                  DashboardWidget.routeName,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .rightToLeft,
                                                    ),
                                                  },
                                                );
                                              } else {
                                                logFirebaseEvent(
                                                    'Button_action_block');
                                                await action_blocks
                                                    .universalErrorSnackbar(
                                                  context,
                                                  errorMessage:
                                                      'We couldn’t update your course data. Please check your connection and try again.',
                                                );
                                                logFirebaseEvent(
                                                    'Button_page_view');
                                                await _model
                                                    .onboardingPagesController
                                                    ?.animateToPage(
                                                  2,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                              }
                                            },
                                            text: 'Complete',
                                            options: FFButtonOptions(
                                              width: 270.0,
                                              height: 45.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                              elevation: 2.0,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Welcome to Attendrix',
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
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/flow.gif',
                                    width: 400.0,
                                    height: 300.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/jsons/Animation_1733337186367.json',
                                      width: 24.0,
                                      height: 24.0,
                                      fit: BoxFit.contain,
                                      animate: true,
                                    ),
                                    AnimatedDefaultTextStyle(
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
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeIn,
                                      child: Text(
                                        valueOrDefault<String>(
                                          _model.courseEnrollmentFeedback,
                                          'Pulling data from the server about enrolled subjects.',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: LinearPercentIndicator(
                                    percent: valueOrDefault<double>(
                                      (((_model.loopParameter!) ?? 0)
                                              .clamp(0, 4)) /
                                          4,
                                      0.3,
                                    ),
                                    width: 120.0,
                                    lineHeight: 8.0,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    progressColor:
                                        FlutterFlowTheme.of(context).primary,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).accent4,
                                    barRadius: Radius.circular(12.0),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 16.0, 10.0, 16.0),
                          child: smooth_page_indicator.SmoothPageIndicator(
                            controller: _model.onboardingPagesController ??=
                                PageController(
                                    initialPage: max(
                                        0,
                                        min(
                                            valueOrDefault<int>(
                                              () {
                                                if ((_model.userDoc?.username != null && _model.userDoc?.username != '') &&
                                                    (_model
                                                            .userDoc!
                                                            .coursesEnrolled
                                                            .length >=
                                                        6) &&
                                                    ((_model.userDoc?.batchID != null && _model.userDoc?.batchID != '') &&
                                                        (_model.userDoc?.semesterID != null &&
                                                            _model.userDoc?.semesterID !=
                                                                ''))) {
                                                  return 3;
                                                } else if ((_model.userDoc?.semesterID != null &&
                                                        _model.userDoc?.semesterID !=
                                                            '') &&
                                                    (_model.userDoc?.batchID != null &&
                                                        _model.userDoc?.batchID !=
                                                            '')) {
                                                  return 1;
                                                } else if ((_model.userDoc?.semesterID != null &&
                                                        _model.userDoc?.semesterID !=
                                                            '') &&
                                                    (_model.userDoc?.batchID != null &&
                                                        _model.userDoc?.batchID !=
                                                            '') &&
                                                    (_model.userDoc?.username != null &&
                                                        _model.userDoc?.username != '')) {
                                                  return 2;
                                                } else {
                                                  return 0;
                                                }
                                              }(),
                                              0,
                                            ),
                                            3))),
                            count: 4,
                            axisDirection: Axis.horizontal,
                            onDotClicked: (i) async {
                              await _model.onboardingPagesController!
                                  .animateToPage(
                                i,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              safeSetState(() {});
                            },
                            effect: smooth_page_indicator.ExpandingDotsEffect(
                              expansionFactor: 1.5,
                              spacing: 6.0,
                              radius: 12.0,
                              dotWidth: valueOrDefault<double>(
                                (MediaQuery.sizeOf(context).width - 80) / 4,
                                80.0,
                              ),
                              dotHeight: 6.0,
                              dotColor: FlutterFlowTheme.of(context).accent1,
                              activeDotColor:
                                  FlutterFlowTheme.of(context).primary,
                              paintStyle: PaintingStyle.fill,
                            ),
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
