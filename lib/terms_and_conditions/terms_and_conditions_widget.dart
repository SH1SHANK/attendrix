import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'terms_and_conditions_model.dart';
export 'terms_and_conditions_model.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  State<TermsAndConditionsWidget> createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  late TermsAndConditionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsAndConditionsModel());

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
        title: 'TermsAndConditions',
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
                'Terms and Conditions',
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
                                    '1. Acceptance of Terms',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Geomanist',
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w900,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    '1.1 Introduction',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Geomanist',
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    'Welcome to Attendrix, an attendance tracking application designed specifically for students of the National Institute of Technology, Calicut (NITC). By accessing or using the Attendrix app, you agree to be bound by these Terms and Conditions. If you do not agree with these terms, please do not use the application.',
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
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    '1.2 Eligibility',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Geomanist',
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: false,
                                        ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    '- You must be a currently enrolled student at NITC to use Attendrix.\n- Users must be at least 17 years of age.\n- By using the app, you confirm that you have the right, authority, and capacity to enter into these Terms and Conditions.\n',
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
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    '2. User Account\n\n2.1 Account Creation\n- You are responsible for maintaining the confidentiality of your account credentials.\n- You agree to accept responsibility for all activities that occur under your account.\n\n2.2 Account Responsibilities\n- You are obligated to update your account information promptly if any changes occur.\n- Sharing of account credentials is strictly prohibited.\n\n3. App Usage and Functionality\n\n3.1 Purpose\nAttendrix is designed solely for tracking and managing student attendance at NITC.\n\n3.2 Data Collection and Privacy\n- The app will collect and process attendance-related information.\n- Personal data will be handled in accordance with our Privacy Policy.\n- Only authorized NITC personnel and the student themselves can access individual attendance records.\n\n3.3 User Conduct\nYou agree not to:\n- Use the app for any illegal or unauthorized purpose\n- Attempt to breach the app\'s security\n- Interfere with other users\' access to the app\n- Upload malicious content or viruses\n- Engage in any form of harassment or inappropriate behavior\n\n4. Intellectual Property\n\n4.1 Ownership\n- Attendrix and its original content, features, and functionality are owned by the developer and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.\n- Users are granted a limited, non-exclusive, non-transferable license to use the app.\n\n4.2 Restrictions\n- You may not reproduce, distribute, modify, create derivative works of, publicly display, publicly perform, republish, download, store, or transmit any of the material without prior written consent.\n\n5. Data Handling and Privacy\n\n5.1 Data Collection\n- The app collects necessary information to track attendance.\n- Data collected includes student ID, name, course details, and attendance records.\n\n5.2 Data Usage\n- Attendance data may be used for academic purposes by NITC administration.\n- Individual student data will be kept confidential and shared only with authorized personnel.\n\n5.3 Data Retention\n- Attendance records will be maintained for the duration of the academic year.\n- Historical data may be archived for institutional records.\n\n6. Limitation of Liability\n\n6.1 Service Availability\n- Attendrix strives to provide continuous and uninterrupted service.\n- We are not liable for temporary service interruptions or technical issues.\n\n6.2 Disclaimer\n- The app is provided \"as is\" without any warranties.\n- We do not guarantee the accuracy of attendance records and recommend cross-verification.\n\n7. Modification of Terms\n\n7.1 Updates\n- Attendrix reserves the right to modify these Terms and Conditions at any time.\n- Users will be notified of significant changes.\n- Continued use of the app after changes constitutes acceptance of new terms.\n\n8. Termination\n\n8.1 Account Termination\n- NITC or Attendrix may terminate or suspend your account at any time.\n- Reasons for termination may include:\n  - Violation of these Terms and Conditions\n  - Suspicious account activity\n  - Graduation or leaving NITC\n  - Administrative decision\n\n8.2 Effect of Termination\n- Upon termination, you lose access to the app and your attendance records.\n- Archived data may be retained by the institution.\n\n9. Dispute Resolution\n\n9.1 Jurisdiction\n- Any disputes arising from the use of Attendrix shall be subject to the jurisdiction of courts in Kozhikode, Kerala, India.\n\n9.2 Arbitration\n- Disputes shall first attempt resolution through amicable discussion.\n- If unresolved, they will be settled through arbitration as per Indian Arbitration and Conciliation Act.\n\n10. Contact Information\n\nFor any queries, concerns, or issues related to these Terms and Conditions, please contact:\n\nAttendrix Support Team:\nEmail: support@attendrix.site\nAddress: National Institute of Technology, Calicut, Kerala, India\n\n11. Acknowledgment\n\nBy using Attendrix, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.\n\nLast Updated: 11/12/2024\n\n© 2024 Attendrix. All Rights Reserved.\n\n',
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
