import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/components/time_slot_widget.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_custom_class_model.dart';
export 'create_custom_class_model.dart';

class CreateCustomClassWidget extends StatefulWidget {
  const CreateCustomClassWidget({super.key});

  static String routeName = 'createCustomClass';
  static String routePath = 'createCustomClass';

  @override
  State<CreateCustomClassWidget> createState() =>
      _CreateCustomClassWidgetState();
}

class _CreateCustomClassWidgetState extends State<CreateCustomClassWidget> {
  late CreateCustomClassModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateCustomClassModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'createCustomClass'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CREATE_CUSTOM_CLASS_createCustomClass_ON');
      logFirebaseEvent('createCustomClass_backend_call');
      _model.instituteSlots = await InstituteSlotsCall.call();

      if ((_model.instituteSlots?.succeeded ?? true)) {
        logFirebaseEvent('createCustomClass_update_page_state');
        _model.instituteSlotsCall = ((_model.instituteSlots?.jsonBody ?? '')
                .toList()
                .map<SlotInfoStruct?>(SlotInfoStruct.maybeFromMap)
                .toList() as Iterable<SlotInfoStruct?>)
            .withoutNulls
            .toList()
            .cast<SlotInfoStruct>();
      }
    });

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.switchValue = false;
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
        title: 'createCustomClass',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'CREATE_CUSTOM_CLASS_Icon_a53jlmho_ON_TAP');
                              logFirebaseEvent('Icon_navigate_back');
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: FlutterFlowTheme.of(context).absentRed,
                              size: 36.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create Custom Class',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineMediumIsCustom,
                                      ),
                                ),
                                Text(
                                  'Set your schedule the way you want.',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Class Name',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                            TextFormField(
                              controller: _model.textController1,
                              focusNode: _model.textFieldFocusNode1,
                              autofocus: false,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'e.g. Morning Yoga',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelLargeIsCustom,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 12.0),
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
                              validator: _model.textController1Validator
                                  .asValidator(context),
                              inputFormatters: [
                                if (!isAndroid && !isiOS)
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    return TextEditingValue(
                                      selection: newValue.selection,
                                      text: newValue.text.toCapitalization(
                                          TextCapitalization.words),
                                    );
                                  }),
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z]'))
                              ],
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                            TextFormField(
                              controller: _model.textController2,
                              focusNode: _model.textFieldFocusNode2,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText:
                                    'e.g. A relaxing yoga session to start your day.',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelLargeIsCustom,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 12.0),
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
                              maxLines: 5,
                              minLines: 3,
                              maxLength: 200,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  null,
                              validator: _model.textController2Validator
                                  .asValidator(context),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Class Assets (Optional)',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                            TextFormField(
                              controller: _model.textController3,
                              focusNode: _model.textFieldFocusNode3,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'e.g. https://drive.google.com/...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .labelLargeIsCustom,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                suffixIcon: Icon(
                                  FFIcons.klinkBold,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 22.0,
                                ),
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
                              validator: _model.textController3Validator
                                  .asValidator(context),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Classes Start Date:',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'CREATE_CUSTOM_CLASS_Container_i0sylzpm_O');
                                logFirebaseEvent('Container_date_time_picker');
                                final _datePickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: getCurrentTimestamp,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2050),
                                  builder: (context, child) {
                                    return wrapInMaterialDatePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle: FlutterFlowTheme.of(
                                              context)
                                          .headlineLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLargeFamily,
                                            fontSize: 32.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .headlineLargeIsCustom,
                                          ),
                                      pickerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      pickerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );

                                if (_datePickedDate != null) {
                                  safeSetState(() {
                                    _model.datePicked = DateTime(
                                      _datePickedDate.year,
                                      _datePickedDate.month,
                                      _datePickedDate.day,
                                    );
                                  });
                                } else if (_model.datePicked != null) {
                                  safeSetState(() {
                                    _model.datePicked = getCurrentTimestamp;
                                  });
                                }
                                if (_model.datePicked != null) {
                                  logFirebaseEvent(
                                      'Container_update_page_state');
                                  _model.startDate = _model.datePicked;
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat(
                                          "yMMMd",
                                          _model.startDate,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        'Select A Start Date',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Slot Type',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                            FlutterFlowDropDown<bool>(
                              controller: _model.dropDownValueController1 ??=
                                  FormFieldController<bool>(null),
                              options: List<bool>.from([true, false]),
                              optionLabels: [
                                'Create Custom Slot',
                                'Use Institute Slot'
                              ],
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue1 = val);
                                logFirebaseEvent(
                                    'CREATE_CUSTOM_CLASS_DropDown_6x6rjnpa_ON');
                                logFirebaseEvent('DropDown_update_page_state');
                                _model.isCustomSlot = _model.dropDownValue1!;
                                safeSetState(() {});
                              },
                              width: double.infinity,
                              height: 45.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                              hintText:
                                  'Select Institute Slot or Create Your Own',
                              icon: Icon(
                                Icons.arrow_drop_down,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              elevation: 1.0,
                              borderColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderWidth: 2.0,
                              borderRadius: 12.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 12.0, 12.0, 12.0),
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          if (_model.isCustomSlot) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Slot Name',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelMediumIsCustom,
                                        ),
                                  ),
                                  TextFormField(
                                    controller: _model.textController4,
                                    focusNode: _model.textFieldFocusNode4,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'e.g. Weekday Morning',
                                      hintStyle: FlutterFlowTheme.of(context)
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
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              12.0, 12.0, 12.0, 12.0),
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
                                    validator: _model.textController4Validator
                                        .asValidator(context),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          FFIcons.kcalendarDateNote,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                        Text(
                                          'Class Schedule',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmallIsCustom,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final slots = _model.addedSlots
                                          .toList()
                                          .take(12)
                                          .toList();

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: slots.length,
                                        itemBuilder: (context, slotsIndex) {
                                          final slotsItem = slots[slotsIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    2.0, 0.0, 2.0, 6.0),
                                            child: wrapWithModel(
                                              model: _model.timeSlotModels
                                                  .getModel(
                                                slotsItem.slotId.toString(),
                                                slotsIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              updateOnChange: true,
                                              child: TimeSlotWidget(
                                                key: Key(
                                                  'Key8yp_${slotsItem.slotId.toString()}',
                                                ),
                                                slotData: slotsItem,
                                                instituteSlots:
                                                    _model.instituteSlotsCall,
                                                slotCallback:
                                                    (updatedSlotData) async {
                                                  logFirebaseEvent(
                                                      'CREATE_CUSTOM_CLASS_Container_8ypx9wyw_C');
                                                  logFirebaseEvent(
                                                      'timeSlot_update_page_state');
                                                  _model
                                                      .updateAddedSlotsAtIndex(
                                                    slotsIndex,
                                                    (_) => updatedSlotData!,
                                                  );
                                                  safeSetState(() {});
                                                },
                                                deleteSlot: (deleteSlot) async {
                                                  logFirebaseEvent(
                                                      'CREATE_CUSTOM_CLASS_Container_8ypx9wyw_C');
                                                  logFirebaseEvent(
                                                      'timeSlot_update_page_state');
                                                  _model
                                                      .removeAtIndexFromAddedSlots(
                                                          slotsIndex);
                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CREATE_CUSTOM_CLASS__ADD_TIME_SLOT_BTN_O');
                                      logFirebaseEvent(
                                          'Button_update_page_state');
                                      _model.addToAddedSlots(SlotMetadataStruct(
                                        slotId: functions.randomNumberGenerator(
                                            1000000,
                                            9999999,
                                            getCurrentTimestamp
                                                .microsecondsSinceEpoch
                                                .toString()),
                                      ));
                                      safeSetState(() {});
                                    },
                                    text: '+ Add Time Slot',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x9E9489F5),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily,
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleSmallIsCustom,
                                          ),
                                      elevation: 2.0,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Available Institute Slots',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .labelMediumIsCustom,
                                        ),
                                  ),
                                  AuthUserStreamWidget(
                                    builder: (context) =>
                                        FlutterFlowDropDown<String>(
                                      controller:
                                          _model.dropDownValueController2 ??=
                                              FormFieldController<String>(null),
                                      options:
                                          functions.filterAlreadyEnrolledSlots(
                                              _model.instituteSlotsCall
                                                  .toList(),
                                              (currentUserDocument
                                                          ?.coursesEnrolled
                                                          .toList() ??
                                                      [])
                                                  .map((e) => e.courseID)
                                                  .toList()),
                                      onChanged: (val) async {
                                        safeSetState(
                                            () => _model.dropDownValue2 = val);
                                        logFirebaseEvent(
                                            'CREATE_CUSTOM_CLASS_DropDown_gagy7i12_ON');
                                        logFirebaseEvent(
                                            'DropDown_update_page_state');
                                        _model.selectedInstituteSlot =
                                            _model.selectedInstituteSlot;
                                        safeSetState(() {});
                                      },
                                      width: double.infinity,
                                      height: 45.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                      hintText: 'Select From Institute Slots',
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      elevation: 1.0,
                                      borderColor: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderWidth: 2.0,
                                      borderRadius: 12.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Toggle Notifications',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelLargeFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelLargeIsCustom,
                                ),
                          ),
                          Switch.adaptive(
                            value: _model.switchValue!,
                            onChanged: (newValue) async {
                              safeSetState(
                                  () => _model.switchValue = newValue);
                            },
                            activeColor: FlutterFlowTheme.of(context).info,
                            activeTrackColor:
                                FlutterFlowTheme.of(context).tertiary,
                            inactiveTrackColor:
                                FlutterFlowTheme.of(context).alternate,
                            inactiveThumbColor:
                                FlutterFlowTheme.of(context).info,
                          ),
                        ],
                      ),
                      if (_model.switchValue ?? true)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Minutes before class to send notification',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelLargeFamily,
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelLargeIsCustom,
                                      ),
                                ),
                              ),
                              Container(
                                width: 120.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: FlutterFlowCountController(
                                  decrementIconBuilder: (enabled) => Icon(
                                    Icons.remove_rounded,
                                    color: enabled
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryText
                                        : FlutterFlowTheme.of(context)
                                            .alternate,
                                    size: 24.0,
                                  ),
                                  incrementIconBuilder: (enabled) => Icon(
                                    Icons.add_rounded,
                                    color: enabled
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .alternate,
                                    size: 24.0,
                                  ),
                                  countBuilder: (count) => Text(
                                    count.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleLargeFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .titleLargeIsCustom,
                                        ),
                                  ),
                                  count: _model.countControllerValue ??= 10,
                                  updateCount: (count) => safeSetState(() =>
                                      _model.countControllerValue = count),
                                  stepSize: 5,
                                  minimum: 10,
                                  maximum: 60,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CREATE_CUSTOM_CLASS_SAVE_CLASS_BTN_ON_TA');
                                logFirebaseEvent('Button_backend_call');

                                var customClassesRecordReference =
                                    CustomClassesRecord.createDoc(
                                        currentUserReference!);
                                await customClassesRecordReference
                                    .set(createCustomClassesRecordData(
                                  courseName: _model.textController1.text,
                                  courseDescription:
                                      _model.textController2.text,
                                  isCustomSlot: _model.isCustomSlot,
                                  slotData: updateSlotInfoStruct(
                                    _model.isCustomSlot
                                        ? SlotInfoStruct(
                                            slotName:
                                                _model.textController4.text,
                                            slotMetadata: _model.addedSlots,
                                          )
                                        : _model.instituteSlotsCall
                                            .where((e) =>
                                                e.slotName ==
                                                _model.dropDownValue2)
                                            .toList()
                                            .firstOrNull,
                                    clearUnsetFields: false,
                                    create: true,
                                  ),
                                  toggleNotfications: _model.switchValue,
                                  notificationMinutesBefore:
                                      valueOrDefault<int>(
                                    _model.countControllerValue,
                                    0,
                                  ),
                                  classAssets: _model.textController3.text,
                                  courseID: functions
                                      .randomNumberGenerator(
                                          10000000,
                                          99999999,
                                          getCurrentTimestamp
                                              .microsecondsSinceEpoch
                                              .toString())
                                      .toString(),
                                  startDate: _model.startDate,
                                ));
                                _model.generatedCustomClass =
                                    CustomClassesRecord.getDocumentFromData(
                                        createCustomClassesRecordData(
                                          courseName:
                                              _model.textController1.text,
                                          courseDescription:
                                              _model.textController2.text,
                                          isCustomSlot: _model.isCustomSlot,
                                          slotData: updateSlotInfoStruct(
                                            _model.isCustomSlot
                                                ? SlotInfoStruct(
                                                    slotName: _model
                                                        .textController4.text,
                                                    slotMetadata:
                                                        _model.addedSlots,
                                                  )
                                                : _model.instituteSlotsCall
                                                    .where((e) =>
                                                        e.slotName ==
                                                        _model.dropDownValue2)
                                                    .toList()
                                                    .firstOrNull,
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          toggleNotfications:
                                              _model.switchValue,
                                          notificationMinutesBefore:
                                              valueOrDefault<int>(
                                            _model.countControllerValue,
                                            0,
                                          ),
                                          classAssets:
                                              _model.textController3.text,
                                          courseID: functions
                                              .randomNumberGenerator(
                                                  10000000,
                                                  99999999,
                                                  getCurrentTimestamp
                                                      .microsecondsSinceEpoch
                                                      .toString())
                                              .toString(),
                                          startDate: _model.startDate,
                                        ),
                                        customClassesRecordReference);
                                logFirebaseEvent('Button_backend_call');
                                await NotificationsConfigTable().insert({
                                  'course_id':
                                      _model.generatedCustomClass?.courseID,
                                  'user_id': currentUserUid,
                                  'slot_data': getJsonField(
                                    (_model.isCustomSlot
                                            ? SlotInfoStruct(
                                                slotName:
                                                    _model.textController4.text,
                                                slotMetadata: _model.addedSlots,
                                              )
                                            : _model.instituteSlotsCall
                                                .where((e) =>
                                                    e.slotName ==
                                                    _model.dropDownValue2)
                                                .toList()
                                                .firstOrNull)
                                        ?.toMap(),
                                    r'''$.slotMetadata''',
                                  ),
                                  'toggle_notifications': _model.switchValue,
                                  'minutes_before_class': valueOrDefault<int>(
                                    _model.countControllerValue,
                                    15,
                                  ),
                                  'class_name': _model.textController1.text,
                                  'username': currentUserDisplayName,
                                  'is_active': true,
                                });
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${_model.textController1.text} Class Added Successfully!',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelLargeIsCustom,
                                          ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .presentGreen,
                                  ),
                                );
                                logFirebaseEvent('Button_navigate_to');

                                context.goNamed(CustomClassesWidget.routeName);

                                safeSetState(() {});
                              },
                              text: 'Save Class',
                              options: FFButtonOptions(
                                width: 180.0,
                                height: 45.0,
                                padding: EdgeInsets.all(8.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
