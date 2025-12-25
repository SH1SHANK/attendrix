import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'reset_password_sent_model.dart';
export 'reset_password_sent_model.dart';

class ResetPasswordSentWidget extends StatefulWidget {
  const ResetPasswordSentWidget({
    super.key,
    required this.email,
  });

  final String? email;

  static String routeName = 'resetPasswordSent';
  static String routePath = 'resetPasswordSent';

  @override
  State<ResetPasswordSentWidget> createState() =>
      _ResetPasswordSentWidgetState();
}

class _ResetPasswordSentWidgetState extends State<ResetPasswordSentWidget> {
  late ResetPasswordSentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetPasswordSentModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'resetPasswordSent'});
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
        title: 'resetPasswordSent',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                      child: Lottie.asset(
                        'assets/jsons/Animation_1746766287328.json',
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.contain,
                        repeat: false,
                        animate: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Your reset request is on its way!\n',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          TextSpan(
                            text:
                                'It might be hiding in Promotions or Spam,\nso don’t forget to check there. \n',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: 'Still missing? No worries \n Just hit ',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: '‘Resend’ ',
                            style: GoogleFonts.outfit(
                              color: FlutterFlowTheme.of(context).tertiary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'and we’ve got you covered.',
                            style: TextStyle(),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                    child: RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Didn’t show up? ',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          TextSpan(
                            text: 'Resend Mail',
                            style: GoogleFonts.outfit(
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.w800,
                            ),
                            mouseCursor: SystemMouseCursors.click,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                logFirebaseEvent(
                                    'RESET_PASSWORD_SENT_RichTextSpan_mqjxzmx');
                                logFirebaseEvent('RichTextSpan_auth');
                                if (widget.email!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'We’ll need your email to help you reset your password.',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                await authManager.resetPassword(
                                  email: widget.email!,
                                  context: context,
                                );
                                logFirebaseEvent('RichTextSpan_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'A New Mail has Been Sent Successfully!',
                                      style: GoogleFonts.outfit(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: Color(0xFF08E957),
                                  ),
                                );
                                logFirebaseEvent('RichTextSpan_navigate_to');

                                context.goNamed(LoginWidget.routeName);
                              },
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
