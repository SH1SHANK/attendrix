import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/components/mime_image_icon_widget.dart';
import '/components/pick_file_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_colorpicker/flutterflow_colorpicker.dart';
import 'quick_notes_model.dart';
export 'quick_notes_model.dart';

/// Create a component, which is a bottom sheet for adding quick notes,
/// similar to Google Keep Notes.
///
/// The user can also add a remainder, time, attachments, location, and so on.
class QuickNotesWidget extends StatefulWidget {
  const QuickNotesWidget({
    super.key,
    required this.classRecord,
    this.classNotesRef,
    bool? documentExists,
  }) : this.documentExists = documentExists ?? false;

  final TimetableRecordsRow? classRecord;
  final ClassNotesRecord? classNotesRef;
  final bool documentExists;

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

    _model.textController1 ??= TextEditingController(
        text: 'Note For ${widget.classRecord?.courseName}');
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.classNotesRef?.noteDescription,
      'Note Description',
    ));
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Quick Notes',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                fontSize: 18.0,
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
                    labelText: 'Note',
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
                    Duration(milliseconds: 1000),
                    () => safeSetState(() {}),
                  ),
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Description',
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
                    counterStyle: FlutterFlowTheme.of(context)
                        .labelSmall
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelSmallFamily,
                          fontSize: 10.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelSmallIsCustom,
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
                  maxLength: 400,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator:
                      _model.textController2Validator.asValidator(context),
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
                              Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(),
                                child: wrapWithModel(
                                  model: _model.mimeImageIconModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: MimeImageIconWidget(
                                    mimeType: valueOrDefault<String>(
                                      _model.fileInfo?.mimeType,
                                      'application/pdf',
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      _model.fileInfo?.name,
                                      'file',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelLargeIsCustom,
                                        ),
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

                          logFirebaseEvent('IconButton_update_component_state');
                          _model.selectedColour = _model.colorPicked!;
                          safeSetState(() {});
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
                                    child: PickFileWidget(
                                      returnParameter: (fileInfo) async {
                                        logFirebaseEvent(
                                            '_update_component_state');
                                        _model.fileInfo = fileInfo;
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
                              if (widget.documentExists) {
                                logFirebaseEvent('Button_backend_call');

                                await widget.classNotesRef!.reference
                                    .update(createClassNotesRecordData(
                                  noteTitle: _model.textController1.text,
                                  noteDescription: _model.textController2.text,
                                  noteColor: _model.selectedColour,
                                  hasAttachments: _model.attachmentAdded,
                                  attachmentAdded: updateFileInfoStruct(
                                    _model.fileInfo,
                                    clearUnsetFields: false,
                                  ),
                                  modifiedAt: getCurrentTimestamp,
                                ));
                              } else {
                                logFirebaseEvent('Button_backend_call');

                                await ClassNotesRecord.createDoc(
                                        currentUserReference!)
                                    .set(createClassNotesRecordData(
                                  classID: widget.classRecord?.classID,
                                  courseName: widget.classRecord?.courseName,
                                  classStartTime:
                                      widget.classRecord?.classStartTime,
                                  noteTitle: _model.textController1.text,
                                  noteDescription: _model.textController2.text,
                                  hasAttachments: _model.attachmentAdded,
                                  noteColor: _model.selectedColour,
                                  attachmentAdded: updateFileInfoStruct(
                                    _model.fileInfo,
                                    clearUnsetFields: false,
                                    create: true,
                                  ),
                                  createdAt: getCurrentTimestamp,
                                  modifiedAt: getCurrentTimestamp,
                                ));
                              }

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
