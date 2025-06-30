import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_check_in_dialog_model.dart';
export 'class_check_in_dialog_model.dart';

class ClassCheckInDialogWidget extends StatefulWidget {
  const ClassCheckInDialogWidget({
    super.key,
    required this.courseID,
    required this.className,
    required this.classStartTime,
    required this.classID,
    bool? isCustomClass,
  }) : this.isCustomClass = isCustomClass ?? false;

  final String? courseID;
  final String? className;
  final DateTime? classStartTime;
  final String? classID;
  final bool isCustomClass;

  @override
  State<ClassCheckInDialogWidget> createState() =>
      _ClassCheckInDialogWidgetState();
}

class _ClassCheckInDialogWidgetState extends State<ClassCheckInDialogWidget> {
  late ClassCheckInDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassCheckInDialogModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      height: 260.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mark Yourself Present!',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineSmallFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                    ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'You\'re about to mark yourself',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        TextSpan(
                          text: ' Present',
                          style: GoogleFonts.outfit(
                            color: Color(0xFF4AB04A),
                            fontWeight: FontWeight.w800,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: ' for ',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.className,
                            'Class',
                          ),
                          style: GoogleFonts.outfit(
                            color: Color(0xFF9489F5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: ' at ',
                          style: GoogleFonts.outfit(
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: dateTimeFormat(
                            "jm",
                            widget.classStartTime,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          style: GoogleFonts.outfit(
                            color: Color(0xFF9489F5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: ', ',
                          style: GoogleFonts.outfit(
                            color: Color(0xFF9489F5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: dateTimeFormat(
                            "MMMEd",
                            widget.classStartTime,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          style: GoogleFonts.outfit(
                            color: Color(0xFF9489F5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              '. Want to log in your attendance and keep the streak alive?\" ',
                          style: GoogleFonts.outfit(
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'CLASS_CHECK_IN_DIALOG_MARK_ATTENDANCE_BT');
                          if (widget.isCustomClass) {
                            logFirebaseEvent('Button_custom_action');
                            _model.checkInStatus =
                                await actions.checkInToCustomClasses(
                              widget.courseID!,
                              currentUserReference!,
                              widget.classStartTime!,
                            );
                            logFirebaseEvent('Button_custom_action');
                            await actions.markClassAttendance(
                              widget.courseID!,
                              widget.classStartTime!,
                              currentUserUid,
                              true,
                              widget.classID!,
                            );
                          } else {
                            logFirebaseEvent('Button_action_block');
                            await action_blocks.checkInAttendanceProtocal(
                              context,
                              classID: widget.classID,
                              courseID: widget.courseID,
                              classStartTime: widget.classStartTime,
                              snackBarVisible: true,
                            );
                            safeSetState(() {});
                          }

                          logFirebaseEvent('Button_dismiss_dialog');
                          Navigator.pop(context);

                          safeSetState(() {});
                        },
                        text: 'Mark Attendance',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 44.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'CLASS_CHECK_IN_DIALOG_NEVER_MIND_BTN_ON_');
                          logFirebaseEvent('Button_close_dialog_drawer_etc');
                          Navigator.pop(context);
                        },
                        text: 'Never Mind',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 44.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).alternate,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
