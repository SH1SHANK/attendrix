import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/class_check_in_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_block_missed_model.dart';
export 'class_block_missed_model.dart';

class ClassBlockMissedWidget extends StatefulWidget {
  const ClassBlockMissedWidget({
    super.key,
    required this.classID,
    required this.courseID,
    required this.courseName,
    required this.classStartTime,
    required this.classEndTime,
    bool? isCustomClass,
    bool? multiSelectMode,
    this.msCallbackAddToList,
    this.msCallbackRemoveFromList,
    required this.refreshMissedClasses,
  })  : this.isCustomClass = isCustomClass ?? false,
        this.multiSelectMode = multiSelectMode ?? false;

  final String? classID;
  final String? courseID;
  final String? courseName;
  final DateTime? classStartTime;
  final DateTime? classEndTime;
  final bool isCustomClass;
  final bool multiSelectMode;
  final Future Function(String classID, String courseID)? msCallbackAddToList;
  final Future Function(String classID, String courseID)?
      msCallbackRemoveFromList;
  final Future Function(List<ClassRowStruct> missedClasses)?
      refreshMissedClasses;

  @override
  State<ClassBlockMissedWidget> createState() => _ClassBlockMissedWidgetState();
}

class _ClassBlockMissedWidgetState extends State<ClassBlockMissedWidget> {
  late ClassBlockMissedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassBlockMissedModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (widget.multiSelectMode)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 0.0),
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
              ),
              child: Checkbox(
                value: _model.checkboxValue ??= false,
                onChanged: (newValue) async {
                  safeSetState(() => _model.checkboxValue = newValue!);
                  if (newValue!) {
                    logFirebaseEvent(
                        'CLASS_BLOCK_MISSED_Checkbox_ta30gnnh_ON_');
                    logFirebaseEvent('Checkbox_execute_callback');
                    await widget.msCallbackAddToList?.call(
                      widget.classID!,
                      widget.courseID!,
                    );
                  } else {
                    logFirebaseEvent(
                        'CLASS_BLOCK_MISSED_Checkbox_ta30gnnh_ON_');
                    logFirebaseEvent('Checkbox_execute_callback');
                    await widget.msCallbackRemoveFromList?.call(
                      widget.classID!,
                      widget.courseID!,
                    );
                  }
                },
                side: (FlutterFlowTheme.of(context).alternate != null)
                    ? BorderSide(
                        width: 2,
                        color: FlutterFlowTheme.of(context).alternate,
                      )
                    : null,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
              ),
            ),
          ),
        Expanded(
          child: Builder(
            builder: (context) => InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('CLASS_BLOCK_MISSED_Container_wrl6wrcz_ON');
                logFirebaseEvent('Container_alert_dialog');
                await showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return Dialog(
                      elevation: 0,
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      alignment: AlignmentDirectional(0.0, 0.0)
                          .resolve(Directionality.of(context)),
                      child: ClassCheckInDialogWidget(
                        courseID: widget.courseID!,
                        className: widget.courseName!,
                        classStartTime: widget.classStartTime!,
                        classID: widget.classID!,
                        isCustomClass: false,
                      ),
                    );
                  },
                );

                logFirebaseEvent('Container_custom_action');
                _model.latestMissedClasses = await actions.getMissedClasses(
                  currentUserUid,
                  (currentUserDocument?.coursesEnrolled.toList() ?? [])
                      .map((e) => e.courseID)
                      .toList(),
                  true,
                );
                logFirebaseEvent('Container_execute_callback');
                await widget.refreshMissedClasses?.call(
                  _model.latestMissedClasses!,
                );

                safeSetState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: 300.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: Color(0xFF7B6FF8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.courseName,
                                'CourseName Undefined',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 12.0,
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
                                8.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: dateTimeFormat(
                                          "MMMMEEEEd",
                                          widget.classStartTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        style: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ', ',
                                        style: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: dateTimeFormat(
                                          "jm",
                                          widget.classStartTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      TextSpan(
                                        text: ' - ',
                                        style: GoogleFonts.outfit(
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: dateTimeFormat(
                                          "jm",
                                          widget.classEndTime,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        style: GoogleFonts.outfit(
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0,
                                        ),
                                      )
                                    ],
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
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
