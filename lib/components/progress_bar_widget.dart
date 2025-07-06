import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'progress_bar_model.dart';
export 'progress_bar_model.dart';

/// A bottom sheet that will act as a progress bar to show how far along a
/// process is and how long it might take,
class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget({
    super.key,
    required this.title,
    required this.description,
    required this.current,
    required this.total,
  });

  final String? title;
  final String? description;
  final int? current;
  final int? total;

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  late ProgressBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressBarModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PROGRESS_BAR_ProgressBar_ON_INIT_STATE');
      logFirebaseEvent('ProgressBar_start_periodic_action');
      _model.Timer = InstantTimer.periodic(
        duration: Duration(milliseconds: 1500),
        callback: (timer) async {
          logFirebaseEvent('ProgressBar_update_component_state');
          _model.current = _model.current + 1;
          safeSetState(() {});
          if (_model.current == widget.total) {
            logFirebaseEvent('ProgressBar_stop_periodic_action');
            _model.Timer?.cancel();
            logFirebaseEvent('ProgressBar_bottom_sheet');
            Navigator.pop(context);
          }
        },
        startImmediately: true,
      );
    });

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              -2.0,
            ),
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              valueOrDefault<String>(
                widget.title,
                'Processing Your Check-Ins',
              ),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                  ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Working on ',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelSmallFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelSmallIsCustom,
                              ),
                        ),
                        TextSpan(
                          text: _model.current.toString(),
                          style: GoogleFonts.outfit(
                            color: FlutterFlowTheme.of(context).tertiary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: ' of ',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.total?.toString(),
                            '0',
                          ),
                          style: GoogleFonts.outfit(
                            color: FlutterFlowTheme.of(context).primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: ' classes...',
                          style: TextStyle(),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).alternate,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Container(
                      width: valueOrDefault<double>(
                        (_model.current / (widget.total!)) *
                            (MediaQuery.sizeOf(context).width * 0.9),
                        100.0,
                      ),
                      height: 8.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7B2CBF),
                            Color(0xFF9D4EDD),
                            Color(0xFFC77DFF)
                          ],
                          stops: [0.0, 0.5, 1.0],
                          begin: AlignmentDirectional(1.0, 0.0),
                          end: AlignmentDirectional(-1.0, 0),
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 4.0)),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget.description,
                    'Please wait while we update your selected classes.',
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
          ].divide(SizedBox(height: 6.0)),
        ),
      ),
    );
  }
}
