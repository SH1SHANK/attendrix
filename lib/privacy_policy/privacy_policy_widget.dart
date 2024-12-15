import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'privacy_policy_model.dart';
export 'privacy_policy_model.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  late PrivacyPolicyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivacyPolicyModel());

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
        title: 'privacyPolicy',
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
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Privacy Policy',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    '1.1 Purpose\nThis Privacy Policy describes how Attendrix (\"we\", \"us\", \"our\") collects, uses, protects, and handles personal information for students of the National Institute of\nTechnology, Calicut (NITC).\n\n1.2 Scope\nThis policy applies to all users of the Attendrix attendance tracking application, primarily NITC students and authorized institutional personnel.\n\n2. Information We Collect\n\n2.1 Personal Identification Information\nWe collect the following types of personal information:\n-Full Name\n-Personal Email Address\n-Department and Course Details\n\n2.2 Attendance-Related Information\n-Class attendance records\n-Course-specific attendance data\n-Timestamp of attendance marking\n\n2.3 Technical Information\n-Device type\n-Operating system\n-IP address\n\nApp usage statistics\nLogin timestamps\n\n3. How We Collect Information\n\n3.1 Direct Collection\n-Information provided during account registration\n-Attendance data captured through the app\nManual input by authorized NITC students\n\n3.2 Automatic Collection\n-App usage tracking\nTechnical logs\n-Device and session information\n\n4. Purpose of Data Collection\n\n4.1 Primary Purposes\n-Tracking and managing student attendance\n-Academic record maintenance\n\n4.2 Secondary Purposes\n-Improving app functionality\n-Detecting and preventing unauthorized use\n-Compliance with institutional policies\n\n5. Data Storage and Security\n5.1 Storage Mechanisms\n-Secure cloud-based database\n-Encrypted storage\n-Access-controlled servers\n\n6. User Rights\n\n6.1 Access Rights\nView personal attendance records\nRequest correction of inaccurate information\nObtain a copy of personal data\n\n6.2 Control Mechanisms\nUpdate personal information\nManage app permissions\nRequest account deletion upon graduation or leaving NITC\n\n7. Changes to Privacy Policy\n\n7.1 Policy Updates\n-Regular reviews and updates\n-Users notified of significant changes\n-Continued app usage indicates acceptance of updated policy\n\n8. Contact Information\nFor privacy-related inquiries:\nAttendrix Privacy Team\nEmail: privacy@attendrix.site\nAddress: National Institute of Technology, Calicut, Kerala, India\n\n15. Acknowledgment\nBy using Attendrix, you acknowledge understanding and agreeing to this privacy policy.\nLast Updated: 11/12/2024\n© 2024 Attendrix. All Rights Reserved.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Geomanist',
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ),
                            ],
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
