import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_colorpicker/flutterflow_colorpicker.dart';
import 'add_marks_model.dart';
export 'add_marks_model.dart';

/// Create a component, which is a bottom sheet for adding quick notes,
/// similar to Google Keep Notes.
///
/// The user can also add a remainder, time, attachments, location, and so on.
class AddMarksWidget extends StatefulWidget {
  const AddMarksWidget({
    super.key,
    required this.taskRecord,
    required this.documentExists,
    this.taskNotesRef,
  });

  final TaskRecordsRow? taskRecord;
  final bool? documentExists;
  final TaskNotesRecord? taskNotesRef;

  @override
  State<AddMarksWidget> createState() => _AddMarksWidgetState();
}

class _AddMarksWidgetState extends State<AddMarksWidget> {
  late AddMarksModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddMarksModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ADD_MARKS_COMP_AddMarks_ON_INIT_STATE');
      if (widget.documentExists!) {
        logFirebaseEvent('AddMarks_update_component_state');
        _model.colorSelected = valueOrDefault<Color>(
          widget.taskNotesRef?.noteColor,
          FlutterFlowTheme.of(context).primaryBackground,
        );
        safeSetState(() {});
      }
    });

    _model.textController1 ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.taskNotesRef?.noteDescription,
      'Add Description',
    ));
    _model.textFieldFocusNode ??= FocusNode();

    _model.obtainedTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.taskNotesRef?.obtainedMarks.toString(),
      '0',
    ));
    _model.obtainedFocusNode ??= FocusNode();

    _model.totalTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.taskNotesRef?.totalMarks.toString(),
      '0',
    ));
    _model.totalFocusNode ??= FocusNode();

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
        padding: EdgeInsetsDirectional.fromSTEB(6.0, 8.0, 6.0, 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Marks & Remarks',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
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
                    logFirebaseEvent('ADD_MARKS_COMP_closeLG_ICN_ON_TAP');
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
                focusNode: _model.textFieldFocusNode,
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
                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
                      ),
                  hintText:
                      'Reflect on key errors, insights, next target exam, or anything you want future-you to remember.',
                  hintStyle: FlutterFlowTheme.of(context).labelSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelSmallFamily,
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
                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                      fontSize: 12.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).labelLargeIsCustom,
                    ),
                maxLines: 3,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                validator: _model.textController1Validator.asValidator(context),
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
            if (widget.taskRecord?.taskType == RecordType.exam.name)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: FlutterFlowDropDown<String>(
                      controller: _model.examtypeValueController ??=
                          FormFieldController<String>(null),
                      options: ['Tutorial', 'Quiz', 'Mid Sem', 'End Sem'],
                      onChanged: (val) =>
                          safeSetState(() => _model.examtypeValue = val),
                      width: 200.0,
                      height: 38.0,
                      textStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelMediumIsCustom,
                          ),
                      hintText: 'Exam Type',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      elevation: 2.0,
                      borderColor: Colors.transparent,
                      borderWidth: 0.0,
                      borderRadius: 12.0,
                      margin:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                  ),
                  if ((_model.examtypeValue != 'Mid Sem') &&
                      (_model.examtypeValue != 'End Sem'))
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: FlutterFlowChoiceChips(
                          options: [
                            ChipData('I'),
                            ChipData('II'),
                            ChipData('III'),
                            ChipData('IV')
                          ],
                          onChanged: (val) => safeSetState(
                              () => _model.examValue = val?.firstOrNull),
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                            iconColor: FlutterFlowTheme.of(context).info,
                            iconSize: 12.0,
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            iconSize: 11.0,
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          chipSpacing: 8.0,
                          rowSpacing: 8.0,
                          multiselect: false,
                          initialized: _model.examValue != null,
                          alignment: WrapAlignment.start,
                          controller: _model.examValueController ??=
                              FormFieldController<List<String>>(
                            ['I'],
                          ),
                          wrapped: false,
                        ),
                      ),
                    ),
                ],
              ),
            if (widget.taskRecord?.taskType == TaskType.assignment.name)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: FlutterFlowDropDown<String>(
                      controller: _model.assignmentTypeValueController ??=
                          FormFieldController<String>(null),
                      options: ['Graded', 'Non-Graded', 'Practice', 'Lab'],
                      onChanged: (val) =>
                          safeSetState(() => _model.assignmentTypeValue = val),
                      width: 200.0,
                      height: 38.0,
                      textStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelMediumIsCustom,
                          ),
                      hintText: 'Assignment Type',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      elevation: 2.0,
                      borderColor: Colors.transparent,
                      borderWidth: 0.0,
                      borderRadius: 12.0,
                      margin:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                  ),
                  if ((_model.assignmentTypeValue != 'Mid Sem') &&
                      (_model.assignmentTypeValue != 'End Sem'))
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: FlutterFlowChoiceChips(
                          options: [
                            ChipData('I'),
                            ChipData('II'),
                            ChipData('III'),
                            ChipData('IV')
                          ],
                          onChanged: (val) => safeSetState(
                              () => _model.assignmentValue = val?.firstOrNull),
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                            iconColor: FlutterFlowTheme.of(context).info,
                            iconSize: 12.0,
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            iconSize: 11.0,
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          chipSpacing: 8.0,
                          rowSpacing: 8.0,
                          multiselect: false,
                          initialized: _model.assignmentValue != null,
                          alignment: WrapAlignment.start,
                          controller: _model.assignmentValueController ??=
                              FormFieldController<List<String>>(
                            ['I'],
                          ),
                          wrapped: false,
                        ),
                      ),
                    ),
                ],
              ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Marks Obtained',
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelLargeIsCustom,
                        ),
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Container(
                        width: 80.0,
                        child: TextFormField(
                          controller: _model.obtainedTextController,
                          focusNode: _model.obtainedFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                34.0, 8.0, 0.0, 8.0),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.obtainedTextControllerValidator
                              .asValidator(context),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                '[+-]?(\\d+(\\.\\d+)?|\\.\\d+)|[+\\-*/]'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Total Marks',
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelLargeIsCustom,
                        ),
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(44.0, 0.0, 0.0, 0.0),
                      child: Container(
                        width: 80.0,
                        child: TextFormField(
                          controller: _model.totalTextController,
                          focusNode: _model.totalFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                34.0, 8.0, 0.0, 8.0),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.totalTextControllerValidator
                              .asValidator(context),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                '[+-]?(\\d+(\\.\\d+)?|\\.\\d+)|[+\\-*/]'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            'ADD_MARKS_COMP_paletteBold_ICN_ON_TAP');
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
                        _model.colorSelected = _model.colorPicked!;
                        safeSetState(() {});
                      },
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
                Flexible(
                  child: FFButtonWidget(
                    onPressed: ((_model.obtainedTextController.text != '') &&
                            (_model.totalTextController.text != '') &&
                            (_model.examtypeValue != null &&
                                _model.examtypeValue != ''))
                        ? null
                        : () async {
                            logFirebaseEvent('ADD_MARKS_COMP_SAVE_BTN_ON_TAP');
                            if (widget.documentExists!) {
                              logFirebaseEvent('Button_backend_call');

                              await widget.taskNotesRef!.reference
                                  .update(createTaskNotesRecordData(
                                obtainedMarks: double.tryParse(
                                    _model.obtainedTextController.text),
                                totalMarks: double.tryParse(
                                    _model.totalTextController.text),
                                noteDescription: _model.textController1.text,
                                examDetails: widget.taskRecord?.taskType ==
                                        TaskType.assignment.name
                                    ? '${valueOrDefault<String>(
                                        _model.assignmentTypeValue,
                                        'Graded',
                                      )} Assignment - ${valueOrDefault<String>(
                                        _model.assignmentValue,
                                        'I',
                                      )}'
                                    : '${valueOrDefault<String>(
                                        _model.examtypeValue,
                                        'Tutorial',
                                      )}${(_model.examtypeValue != 'Mid Sem') && (_model.examtypeValue != 'End Sem') ? ' - ${_model.examValue}' : '   '}',
                                noteColor: _model.colorPicked,
                              ));
                            } else {
                              logFirebaseEvent('Button_backend_call');

                              await TaskNotesRecord.createDoc(
                                      currentUserReference!)
                                  .set(createTaskNotesRecordData(
                                taskID: widget.taskRecord?.id,
                                obtainedMarks: double.tryParse(
                                    _model.obtainedTextController.text),
                                totalMarks: double.tryParse(
                                    _model.totalTextController.text),
                                noteDescription: _model.textController1.text,
                                examDetails: widget.taskRecord?.taskType ==
                                        TaskType.assignment.name
                                    ? '${valueOrDefault<String>(
                                        _model.assignmentTypeValue,
                                        'Graded',
                                      )} Assignment - ${valueOrDefault<String>(
                                        _model.assignmentValue,
                                        'I',
                                      )}'
                                    : '${valueOrDefault<String>(
                                        _model.examtypeValue,
                                        'Tutorial',
                                      )}${(_model.examtypeValue != 'Mid Sem') && (_model.examtypeValue != 'End Sem') ? ' - ${_model.examValue}' : '   '}',
                                noteColor: _model.colorPicked,
                              ));
                            }

                            logFirebaseEvent('Button_show_snack_bar');
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.documentExists!
                                      ? 'Updated Task Archive Successfully!'
                                      : 'Added Task Archive Successfully!',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
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
                      disabledColor: FlutterFlowTheme.of(context).secondaryText,
                      disabledTextColor: Colors.black,
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ].divide(SizedBox(height: 6.0)),
        ),
      ),
    );
  }
}
