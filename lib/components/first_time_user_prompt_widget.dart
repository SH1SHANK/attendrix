import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'first_time_user_prompt_model.dart';
export 'first_time_user_prompt_model.dart';

class FirstTimeUserPromptWidget extends StatefulWidget {
  const FirstTimeUserPromptWidget({super.key});

  @override
  State<FirstTimeUserPromptWidget> createState() =>
      _FirstTimeUserPromptWidgetState();
}

class _FirstTimeUserPromptWidgetState extends State<FirstTimeUserPromptWidget> {
  late FirstTimeUserPromptModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FirstTimeUserPromptModel());

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
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
              spreadRadius: 0.0,
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthUserStreamWidget(
                builder: (context) => Text(
                  valueOrDefault<String>(
                    'Yo $currentUserDisplayName!!',
                    'Yo User!!',
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Montserrat',
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              GradientText(
                'Welcome To Attendrix',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Montserrat',
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w800,
                    ),
                colors: [
                  FlutterFlowTheme.of(context).primary,
                  FlutterFlowTheme.of(context).info
                ],
                gradientDirection: GradientDirection.rtl,
                gradientType: GradientType.linear,
              ),
              Text(
                'Attendance? Checked. Stress? Gone.\n\nYou’re part of the cool beta crew, helping us fine-tune this app to make attendance tracking as easy as acing a group project (well, almost).\n\nWe’re still ironing out a few bugs, so if you spot one or have any genius ideas, hit us up. Your feedback = our glow-up.\n\nThanks for being awesome and helping us level up!',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Geomanist',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      useGoogleFonts: false,
                    ),
              ),
            ].divide(const SizedBox(height: 24.0)),
          ),
        ),
      ),
    );
  }
}
