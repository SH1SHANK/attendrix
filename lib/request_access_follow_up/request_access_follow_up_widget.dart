import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'request_access_follow_up_model.dart';
export 'request_access_follow_up_model.dart';

class RequestAccessFollowUpWidget extends StatefulWidget {
  const RequestAccessFollowUpWidget({
    super.key,
    required this.status,
    required this.message,
    required this.email,
    this.details,
    this.error,
  });

  final String? status;
  final String? message;
  final String? email;
  final String? details;
  final String? error;

  static String routeName = 'requestAccessFollowUp';
  static String routePath = 'requestAccessFollowUp';

  @override
  State<RequestAccessFollowUpWidget> createState() =>
      _RequestAccessFollowUpWidgetState();
}

class _RequestAccessFollowUpWidgetState
    extends State<RequestAccessFollowUpWidget> {
  late RequestAccessFollowUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RequestAccessFollowUpModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'requestAccessFollowUp'});
    _model.pinCodeFocusNode ??= FocusNode();

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
        title: 'requestAccessFollowUp',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      if (widget.status == '200') {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You’re Approved!',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineSmallIsCustom,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: Text(
                                'You\'re officially part of the Admin Circle!  \nCheck your inbox for your admin code and enter it below to complete setup.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineSmallIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 0.0, 0.0),
                              child: PinCodeTextField(
                                autoDisposeControllers: false,
                                appContext: context,
                                length: 6,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyLargeIsCustom,
                                    ),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                enableActiveFill: false,
                                autoFocus: true,
                                focusNode: _model.pinCodeFocusNode,
                                enablePinAutofill: false,
                                errorTextSpace: 16.0,
                                showCursor: true,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                obscureText: false,
                                hintCharacter: '●',
                                keyboardType: TextInputType.number,
                                pinTheme: PinTheme(
                                  fieldHeight: 44.0,
                                  fieldWidth: 44.0,
                                  borderWidth: 2.0,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                  shape: PinCodeFieldShape.box,
                                  activeColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  inactiveColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  selectedColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                                controller: _model.pinCodeController,
                                onChanged: (_) {},
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: _model.pinCodeControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            if (valueOrDefault<bool>(
                              _model.invalidPin,
                              false,
                            ))
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Invalid or expired admin code.',
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
                                            color: Color(0xFFFF000F),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
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
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'REQUEST_ACCESS_FOLLOW_UP_VERIFY_CODE_BTN');
                                  if (_model.pinCodeController!.text != '') {
                                    logFirebaseEvent('Button_custom_action');
                                    _model.verificationResult =
                                        await actions.verifyAdminCode(
                                      currentUserUid,
                                      _model.pinCodeController!.text,
                                    );
                                    if (_model.verificationResult!) {
                                      logFirebaseEvent(
                                          'Button_update_page_state');
                                      _model.invalidPin = false;
                                      safeSetState(() {});
                                      logFirebaseEvent('Button_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Admin code verified. Access granted.',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeIsCustom,
                                                ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor: Color(0xFF38C538),
                                        ),
                                      );
                                      logFirebaseEvent('Button_custom_action');
                                      _model.editablecourses =
                                          await actions.markAllCoursesEditable(
                                        (currentUserDocument?.coursesEnrolled
                                                    .toList() ??
                                                [])
                                            .toList(),
                                      );
                                      logFirebaseEvent('Button_wait__delay');
                                      await Future.delayed(
                                          const Duration(milliseconds: 2000));
                                      logFirebaseEvent('Button_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Your records are being updated, and you\'ll be redirected to the admin dashboard shortly.',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeIsCustom,
                                                ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor: Color(0xFF38C538),
                                        ),
                                      );
                                      logFirebaseEvent('Button_backend_call');

                                      await currentUserReference!.update({
                                        ...createUsersRecordData(
                                          userRole: 'admin',
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'coursesEnrolled':
                                                getCoursesEnrolledListFirestoreData(
                                              _model.editablecourses,
                                            ),
                                          },
                                        ),
                                      });
                                      logFirebaseEvent('Button_navigate_to');

                                      context.goNamed(
                                        AdminPageWidget.routeName,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.rightToLeft,
                                          ),
                                        },
                                      );
                                    } else {
                                      logFirebaseEvent(
                                          'Button_update_page_state');
                                      _model.invalidPin = true;
                                      safeSetState(() {});
                                    }
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Verify Code',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 38.0,
                                  padding: EdgeInsets.all(8.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (widget.status == '202') {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hang Tight — You\'re on the List!',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineSmallIsCustom,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: Text(
                                'We\'ve received your request for admin access.  \nOnce approved, we\'ll send you an email with your admin code.  \nStay tuned!',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineSmallIsCustom,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'REQUEST_ACCESS_FOLLOW_UP_BACK_TO_DASHBOA');
                                  logFirebaseEvent('Button_navigate_to');

                                  context.goNamed(DashboardWidget.routeName);
                                },
                                text: 'Back To Dashboard',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 38.0,
                                  padding: EdgeInsets.all(8.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Something Went Wrong :/',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineSmallIsCustom,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.message,
                                  'We couldn’t process your request right now. Please try again in a moment or check your network.',
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineSmallIsCustom,
                                    ),
                              ),
                            ),
                            if ((widget.status != '200') &&
                                (widget.status != '202'))
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          widget.error,
                                          'error',
                                        ),
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: ' : ',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          widget.details,
                                          'Unknown Error',
                                        ),
                                        style: GoogleFonts.outfit(
                                          color: FlutterFlowTheme.of(context)
                                              .absentRed,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineSmallIsCustom,
                                        ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'REQUEST_ACCESS_FOLLOW_UP_BACK_TO_DASHBOA');
                                  logFirebaseEvent('Button_navigate_to');

                                  context.goNamed(DashboardWidget.routeName);
                                },
                                text: 'Back To Dashboard',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 38.0,
                                  padding: EdgeInsets.all(8.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
