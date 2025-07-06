import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_check_out_dialog_model.dart';
export 'class_check_out_dialog_model.dart';

class ClassCheckOutDialogWidget extends StatefulWidget {
  const ClassCheckOutDialogWidget({
    super.key,
    required this.classID,
    required this.courseID,
    required this.classStartTime,
    this.className,
    bool? isCustomClass,
    required this.classEndTime,
    required this.courseName,
    required this.isAttendedCallBack,
  }) : this.isCustomClass = isCustomClass ?? false;

  final String? classID;
  final String? courseID;
  final DateTime? classStartTime;
  final String? className;
  final bool isCustomClass;
  final DateTime? classEndTime;
  final String? courseName;
  final Future Function(bool isAttendedpara)? isAttendedCallBack;

  @override
  State<ClassCheckOutDialogWidget> createState() =>
      _ClassCheckOutDialogWidgetState();
}

class _ClassCheckOutDialogWidgetState extends State<ClassCheckOutDialogWidget> {
  late ClassCheckOutDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassCheckOutDialogModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Container(
        width: 280.0,
        height: 290.0,
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
                  'Mark Yourself Absent?',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
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
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
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
                            text: ' Absent',
                            style: GoogleFonts.outfit(
                              color: FlutterFlowTheme.of(context).absentRed,
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
                              'class',
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
                                '. This will remove your Amplix points and break your streak and may also reset some of your challenges. Continue?',
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
                      FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'CLASS_CHECK_OUT_DIALOG_MARK_ABSENT_BTN_O');
                          if (widget.isCustomClass) {
                            logFirebaseEvent('Button_custom_action');
                            _model.removeAttendanceFeedback =
                                await actions.removeCustomClassAttendance(
                              widget.courseID!,
                              currentUserReference!,
                              functions.parseDateTime(
                                  getCurrentTimestamp, widget.classStartTime!),
                            );
                            logFirebaseEvent('Button_show_snack_bar');
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _model.removeAttendanceFeedback!,
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelLargeIsCustom,
                                      ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                              ),
                            );
                          } else {
                            logFirebaseEvent('Button_action_block');
                            _model.feedback =
                                await action_blocks.checkOutAttendanceProtocol(
                              context,
                              userID: currentUserUid,
                              enrolledCourses: (currentUserDocument
                                          ?.coursesEnrolled
                                          .toList() ??
                                      [])
                                  .map((e) => e.courseID)
                                  .toList(),
                              classID: widget.classID,
                              courseID: widget.courseID,
                              classStartTime: widget.classStartTime,
                              classEndTime: widget.classEndTime,
                              courseName: widget.courseName,
                            );
                            logFirebaseEvent('Button_show_snack_bar');
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _model.feedback!,
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelLargeIsCustom,
                                      ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                              ),
                            );
                          }

                          logFirebaseEvent('Button_custom_action');
                          _model.isAttendedQuery =
                              await actions.checkAttendance(
                            widget.classID!,
                            widget.courseID!,
                            currentUserUid,
                            widget.isCustomClass,
                            widget.classStartTime,
                          );
                          logFirebaseEvent('Button_execute_callback');
                          await widget.isAttendedCallBack?.call(
                            _model.isAttendedQuery!,
                          );
                          logFirebaseEvent('Button_dismiss_dialog');
                          Navigator.pop(context);

                          safeSetState(() {});
                        },
                        text: 'Mark Absent',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 44.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).error,
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            logFirebaseEvent(
                                'CLASS_CHECK_OUT_DIALOG_NEVER_MIND_BTN_ON');
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
                            textStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
      ),
    );
  }
}
