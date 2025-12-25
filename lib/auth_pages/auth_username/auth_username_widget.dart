import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_username_model.dart';
export 'auth_username_model.dart';

class AuthUsernameWidget extends StatefulWidget {
  const AuthUsernameWidget({super.key});

  static String routeName = 'authUsername';
  static String routePath = 'authUsername';

  @override
  State<AuthUsernameWidget> createState() => _AuthUsernameWidgetState();
}

class _AuthUsernameWidgetState extends State<AuthUsernameWidget> {
  late AuthUsernameModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthUsernameModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'authUsername'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('AUTH_USERNAME_authUsername_ON_INIT_STATE');
      logFirebaseEvent('authUsername_firestore_query');
      _model.userDocument = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.userDocument?.username != null &&
          _model.userDocument?.username != '') {
        if (_model.userDocument!.coursesEnrolled.length >= 6) {
          logFirebaseEvent('authUsername_navigate_to');

          context.goNamed(DashboardWidget.routeName);
        } else {
          logFirebaseEvent('authUsername_navigate_to');

          context.goNamed(EnrolledCoursesWidget.routeName);
        }
      }
    });

    _model.usernameTextController ??= TextEditingController();
    _model.usernameFocusNode ??= FocusNode();

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
        title: 'authUsername',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF2E6EE), Color(0x92927FDD)],
                  stops: [0.0, 1.0],
                  begin: AlignmentDirectional(0.0, -1.0),
                  end: AlignmentDirectional(0, 1.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
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
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                      child: Text(
                        'This will be your identity on Attendrix. We’ve suggest you to make something cool—feel free to edit it!',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
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
                            key: _model.formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 2.0, 8.0),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.usernameTextController,
                                  focusNode: _model.usernameFocusNode,
                                  onFieldSubmitted: (_) async {
                                    logFirebaseEvent(
                                        'AUTH_USERNAME_username_ON_TEXTFIELD_SUBM');
                                    logFirebaseEvent(
                                        'username_firestore_query');
                                    _model.usernameAvailability =
                                        await queryUsersRecordOnce(
                                      queryBuilder: (usersRecord) =>
                                          usersRecord.where(
                                        'username',
                                        isEqualTo:
                                            _model.usernameTextController.text,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    if (_model.userDocument?.reference !=
                                        currentUserReference) {
                                      logFirebaseEvent(
                                          'username_update_page_state');
                                      _model.usernameAlreadyExists = true;
                                      safeSetState(() {});
                                    } else {
                                      logFirebaseEvent(
                                          'username_update_page_state');
                                      _model.usernameAlreadyExists = false;
                                      safeSetState(() {});
                                    }

                                    safeSetState(() {});
                                  },
                                  autofocus: true,
                                  autofillHints: [AutofillHints.email],
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelLargeIsCustom,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyLargeFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyLargeIsCustom,
                                      ),
                                  validator: _model
                                      .usernameTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              4.0, 0.0, 0.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 12.0,
                            buttonSize: 48.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              FFIcons.kbxsMagicWand,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'AUTH_USERNAME_bxsMagicWand_ICN_ON_TAP');
                              logFirebaseEvent('IconButton_custom_action');
                              _model.uniqueUsername =
                                  await actions.getUniqueUsername();
                              logFirebaseEvent('IconButton_set_form_field');
                              safeSetState(() {
                                _model.usernameTextController?.text =
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'sorry, username already taken',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFFFF000F),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'username available',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF0F00FF),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
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
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 8.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: !((_model.usernameTextController.text !=
                                          '') &&
                                  !_model.usernameAlreadyExists!)
                              ? null
                              : () async {
                                  logFirebaseEvent(
                                      'AUTH_USERNAME_PAGE_CONTINUE_BTN_ON_TAP');
                                  if ((_model.usernameTextController.text !=
                                              '') &&
                                      !_model.usernameAlreadyExists!) {
                                    logFirebaseEvent('Button_backend_call');

                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      username:
                                          _model.usernameTextController.text,
                                    ));
                                    logFirebaseEvent('Button_navigate_to');

                                    context.goNamed(
                                      OnboardingWidget.routeName,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.rightToLeft,
                                        ),
                                      },
                                    );
                                  } else {
                                    logFirebaseEvent('Button_action_block');
                                    await action_blocks.universalErrorSnackbar(
                                      context,
                                      errorMessage:
                                          'Error 402 Couldn\'t Update Username',
                                    );
                                    safeSetState(() {});
                                    logFirebaseEvent(
                                        'Button_clear_text_fields_pin_codes');
                                    safeSetState(() {
                                      _model.usernameTextController?.clear();
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconAlignment: IconAlignment.end,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
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
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                            disabledColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            disabledTextColor:
                                FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    ),
                  ].addToEnd(SizedBox(height: 200.0)),
                ),
              ),
            ),
          ),
        ));
  }
}
