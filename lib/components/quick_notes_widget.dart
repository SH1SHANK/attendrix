import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/pick_file_alert_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_colorpicker/flutterflow_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quick_notes_model.dart';
export 'quick_notes_model.dart';

/// Create a component, which is a bottom sheet for adding quick notes,
/// similar to Google Keep Notes.
///
/// The user can also add a remainder, time, attachments, location, and so on.
class QuickNotesWidget extends StatefulWidget {
  const QuickNotesWidget({
    super.key,
    required this.id,
    this.className,
    this.classDate,
  });

  final String? id;
  final String? className;
  final DateTime? classDate;

  @override
  State<QuickNotesWidget> createState() => _QuickNotesWidgetState();
}

class _QuickNotesWidgetState extends State<QuickNotesWidget> {
  late QuickNotesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuickNotesModel());

    _model.textController1 ??=
        TextEditingController(text: 'Note For ${widget.className}');
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

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
        color: Colors.transparent,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            _model.selectedColour,
            FlutterFlowTheme.of(context).secondaryBackground,
          ),
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
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Note',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineSmallIsCustom,
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 8.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      FFIcons.kcloseLG,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      logFirebaseEvent('QUICK_NOTES_COMP_closeLG_ICN_ON_TAP');
                      logFirebaseEvent('IconButton_bottom_sheet');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: _model.textController1,
                  focusNode: _model.textFieldFocusNode1,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.textController1',
                    Duration(milliseconds: 1000),
                    () => safeSetState(() {}),
                  ),
                  autofocus: false,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    hintText: 'Give this note a name...',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
                      ),
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator:
                      _model.textController1Validator.asValidator(context),
                  inputFormatters: [
                    if (!isAndroid && !isiOS)
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return TextEditingValue(
                          selection: newValue.selection,
                          text: newValue.text
                              .toCapitalization(TextCapitalization.words),
                        );
                      }),
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: _model.textController2,
                  focusNode: _model.textFieldFocusNode2,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.textController2',
                    Duration(milliseconds: 2000),
                    () => safeSetState(() {}),
                  ),
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    hintText:
                        'Add class details, doubts, exam info or anything...',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelLargeFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelLargeIsCustom,
                      ),
                  maxLines: 5,
                  minLines: 2,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator:
                      _model.textController2Validator.asValidator(context),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
                  ],
                ),
              ),
              if (_model.attachmentAdded)
                Flexible(
                  child: Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 5.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 4.0, 0.0),
                                child: Icon(
                                  FFIcons.kfileText,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 18.0,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    _model.fileInfo?.name,
                                    'file',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelLargeIsCustom,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 4.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'QUICK_NOTES_COMP_Icon_258q0nng_ON_TAP');
                                logFirebaseEvent('Icon_update_component_state');
                                _model.attachmentAdded = false;
                                _model.fileInfo = null;
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.close_sharp,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 6.0)),
                      ),
                    ),
                  ),
                ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: Color(0x0DFFFFFF),
                        icon: Icon(
                          FFIcons.kpaletteBold,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'QUICK_NOTES_COMP_paletteBold_ICN_ON_TAP');
                          logFirebaseEvent('IconButton_color_picker');
                          final _colorPickedColor = await showFFColorPicker(
                            context,
                            currentColor: _model.colorPicked ??
                                FlutterFlowTheme.of(context).primary,
                            showRecentColors: true,
                            allowOpacity: true,
                            textColor: FlutterFlowTheme.of(context).primaryText,
                            secondaryTextColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            primaryButtonBackgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            primaryButtonTextColor: Colors.white,
                            primaryButtonBorderColor: Colors.transparent,
                            displayAsBottomSheet: isMobileWidth(context),
                          );

                          if (_colorPickedColor != null) {
                            safeSetState(
                                () => _model.colorPicked = _colorPickedColor);
                          }
                        },
                      ),
                      Builder(
                        builder: (context) => FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 20.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          fillColor: Color(0x0DFFFFFF),
                          icon: Icon(
                            FFIcons.kattachmentClipHook,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent(
                                'QUICK_NOTES_attachmentClipHook_ICN_ON_TA');
                            if (_model.attachmentAdded) {
                              logFirebaseEvent('IconButton_action_block');
                              await action_blocks.universalErrorSnackbar(
                                context,
                                errorMessage: 'Attachment already added',
                              );
                            } else {
                              logFirebaseEvent('IconButton_alert_dialog');
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: PickFileAlertDialogWidget(
                                      returnParameter: (fileInfo) async {
                                        logFirebaseEvent(
                                            '_update_component_state');
                                        _model.fileInfo = fileInfo;
                                        _model.attachmentAdded = true;
                                        safeSetState(() {});
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                  Flexible(
                    child: FFButtonWidget(
                      onPressed: ((_model.textController1.text == '') ||
                              (_model.textController2.text == ''))
                          ? null
                          : () async {
                              logFirebaseEvent(
                                  'QUICK_NOTES_COMP_SAVE_BTN_ON_TAP');
                              logFirebaseEvent('Button_backend_call');

                              await PersonalRecordsRecord.createDoc(
                                      currentUserReference!)
                                  .set(createPersonalRecordsRecordData(
                                recordId: widget.id,
                                noteTitle: _model.textController1.text,
                                noteBody: _model.textController2.text,
                                entityType: RecordType.timetableRecord,
                                noteType: 'remark',
                                marksObtained: 0.0,
                                totalMarks: 0.0,
                                createdAt: getCurrentTimestamp,
                                lastModifiedAt: getCurrentTimestamp,
                                attachments: _model.fileInfo?.filePath,
                              ));
                              logFirebaseEvent('Button_show_snack_bar');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Note Added!',
                                    style: GoogleFonts.outfit(
                                      color: FlutterFlowTheme.of(context).info,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).presentGreen,
                                ),
                              );
                              logFirebaseEvent('Button_bottom_sheet');
                              Navigator.pop(context);
                            },
                      text: 'Save',
                      options: FFButtonOptions(
                        width: 120.0,
                        height: 40.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .labelLarge
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              color: FlutterFlowTheme.of(context).info,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        disabledColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        disabledTextColor: Colors.black,
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ].divide(SizedBox(height: 6.0)),
          ),
        ),
      ),
    );
  }
}
