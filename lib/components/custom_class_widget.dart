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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_class_model.dart';
export 'custom_class_model.dart';

/// Class Creation Form
class CustomClassWidget extends StatefulWidget {
  const CustomClassWidget({super.key});

  @override
  State<CustomClassWidget> createState() => _CustomClassWidgetState();
}

class _CustomClassWidgetState extends State<CustomClassWidget> {
  late CustomClassModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomClassModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CUSTOM_CLASS_customClass_ON_INIT_STATE');
      logFirebaseEvent('customClass_backend_call');
      _model.initituteSlotsAPICall = await InstituteSlotsCall.call();

      if ((_model.initituteSlotsAPICall?.succeeded ?? true)) {
        logFirebaseEvent('customClass_update_component_state');
        _model.instituteSlots = ((_model.initituteSlotsAPICall?.jsonBody ?? '')
                .toList()
                .map<SlotInfoStruct?>(SlotInfoStruct.maybeFromMap)
                .toList() as Iterable<SlotInfoStruct?>)
            .withoutNulls
            .toList()
            .cast<SlotInfoStruct>();
        safeSetState(() {});
      } else {
        logFirebaseEvent('customClass_dismiss_dialog');
        Navigator.pop(context);
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

    _model.switchValue = true;
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
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Custom Class',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineMediumIsCustom,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'CUSTOM_CLASS_COMP_Icon_bx4x6zhl_ON_TAP');
                      logFirebaseEvent('Icon_dismiss_dialog');
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FFIcons.kcloseMD,
                      color: FlutterFlowTheme.of(context).absentRed,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
              Text(
                'Set your schedule the way you want.',
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).labelSmallFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).labelSmallIsCustom,
                    ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Class Name',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                  ),
                  TextFormField(
                    controller: _model.textController1,
                    focusNode: _model.textFieldFocusNode1,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'e.g. Morning Yoga',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
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
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                    ),
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelLargeIsCustom,
                        ),
                    validator:
                        _model.textController1Validator.asValidator(context),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                  ),
                  TextFormField(
                    controller: _model.textController2,
                    focusNode: _model.textFieldFocusNode2,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText:
                          'e.g. A relaxing yoga session to start your day.',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
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
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 12.0),
                    ),
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelLargeIsCustom,
                        ),
                    maxLines: 5,
                    minLines: 3,
                    validator:
                        _model.textController2Validator.asValidator(context),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Class Assets (Optional)',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
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
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
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
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      suffixIcon: Icon(
                        FFIcons.klinkBold,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 22.0,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelLargeIsCustom,
                        ),
                    validator:
                        _model.textController3Validator.asValidator(context),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Slot Type',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                  ),
                  FlutterFlowDropDown<bool>(
                    controller: _model.dropDownValueController1 ??=
                        FormFieldController<bool>(null),
                    options: List<bool>.from([true, false]),
                    optionLabels: ['Create Custom Slot', 'Use Institute Slot'],
                    onChanged: (val) async {
                      safeSetState(() => _model.dropDownValue1 = val);
                      logFirebaseEvent(
                          'CUSTOM_CLASS_DropDown_3n7kn023_ON_FORM_W');
                      logFirebaseEvent('DropDown_update_component_state');
                      _model.createCustomClass = _model.dropDownValue1!;
                      safeSetState(() {});
                    },
                    width: double.infinity,
                    height: 45.0,
                    textStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelMediumIsCustom,
                        ),
                    hintText: 'Select Institute Slot or Create Your Own',
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    elevation: 1.0,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderWidth: 2.0,
                    borderRadius: 12.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              Builder(
                builder: (context) {
                  if (_model.createCustomClass) {
                    return Visibility(
                      visible: _model.createCustomClass,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Slot Name',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
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
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelLargeFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelLargeIsCustom,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
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
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelLargeIsCustom,
                                ),
                            validator: _model.textController4Validator
                                .asValidator(context),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kcalendarDateNote,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24.0,
                              ),
                              Text(
                                'Class Schedule',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .headlineSmallIsCustom,
                                    ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                          Builder(
                            builder: (context) {
                              final slots =
                                  _model.classSlots.toList().take(12).toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: slots.length,
                                itemBuilder: (context, slotsIndex) {
                                  final slotsItem = slots[slotsIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2.0, 0.0, 2.0, 6.0),
                                    child: wrapWithModel(
                                      model: _model.timeSlotModels.getModel(
                                        slotsItem.slotId.toString(),
                                        slotsIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: TimeSlotWidget(
                                        key: Key(
                                          'Keyqwr_${slotsItem.slotId.toString()}',
                                        ),
                                        slotData: slotsItem,
                                        instituteSlots: _model.instituteSlots,
                                        slotCallback: (updatedSlotData) async {
                                          logFirebaseEvent(
                                              'CUSTOM_CLASS_Container_qwra20hf_CALLBACK');
                                          logFirebaseEvent(
                                              'timeSlot_update_component_state');
                                          _model.updateClassSlotsAtIndex(
                                            slotsIndex,
                                            (_) => updatedSlotData!,
                                          );
                                          safeSetState(() {});
                                        },
                                        deleteSlot: (deleteSlot) async {
                                          logFirebaseEvent(
                                              'CUSTOM_CLASS_Container_qwra20hf_CALLBACK');
                                          logFirebaseEvent(
                                              'timeSlot_update_component_state');
                                          _model.removeAtIndexFromClassSlots(
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
                                  'CUSTOM_CLASS__ADD_TIME_SLOT_BTN_ON_TAP');
                              logFirebaseEvent('Button_update_component_state');
                              _model.addToClassSlots(SlotMetadataStruct(
                                slotId: functions.randomNumberGenerator(
                                    100000,
                                    999999,
                                    getCurrentTimestamp.microsecondsSinceEpoch
                                        .toString()),
                                weekday: 'monday',
                                isPlusSlot: false,
                              ));
                              safeSetState(() {});
                            },
                            text: '+ Add Time Slot',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0x9E9489F5),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Institute Slots',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                          ),
                          AuthUserStreamWidget(
                            builder: (context) => FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController2 ??=
                                  FormFieldController<String>(null),
                              options: functions.filterAlreadyEnrolledSlots(
                                  _model.instituteSlots.toList(),
                                  (currentUserDocument?.coursesEnrolled
                                              .toList() ??
                                          [])
                                      .map((e) => e.courseID)
                                      .toList()),
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue2 = val);
                                logFirebaseEvent(
                                    'CUSTOM_CLASS_DropDown_cpvoppxl_ON_FORM_W');
                                logFirebaseEvent(
                                    'DropDown_update_component_state');
                                _model.instituteSlotSelected =
                                    _model.dropDownValue2;
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
                              hintText: 'Select From Institute Slots',
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
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelLargeFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).labelLargeIsCustom,
                        ),
                  ),
                  Switch.adaptive(
                    value: _model.switchValue!,
                    onChanged: (newValue) async {
                      safeSetState(() => _model.switchValue = newValue);
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: FlutterFlowTheme.of(context).primary,
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ],
              ),
              if (_model.switchValue ?? true)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Minutes before class to send notification',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              fontSize: 13.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                      ),
                    ),
                    Container(
                      width: 120.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: FlutterFlowCountController(
                        decrementIconBuilder: (enabled) => Icon(
                          Icons.remove_rounded,
                          color: enabled
                              ? FlutterFlowTheme.of(context).secondaryText
                              : FlutterFlowTheme.of(context).alternate,
                          size: 24.0,
                        ),
                        incrementIconBuilder: (enabled) => Icon(
                          Icons.add_rounded,
                          color: enabled
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).alternate,
                          size: 24.0,
                        ),
                        countBuilder: (count) => Text(
                          count.toString(),
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleLargeFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleLargeIsCustom,
                              ),
                        ),
                        count: _model.countControllerValue ??= 10,
                        updateCount: (count) => safeSetState(
                            () => _model.countControllerValue = count),
                        stepSize: 5,
                        minimum: 10,
                        maximum: 60,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                      ),
                    ),
                  ],
                ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('CUSTOM_CLASS_COMP_CANCEL_BTN_ON_TAP');
                      logFirebaseEvent('Button_dismiss_dialog');
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      width: 140.0,
                      height: 45.0,
                      padding: EdgeInsets.all(8.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).alternate,
                      textStyle: FlutterFlowTheme.of(context)
                          .labelLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'CUSTOM_CLASS_COMP_SAVE_CLASS_BTN_ON_TAP');
                      logFirebaseEvent('Button_backend_call');

                      var customClassesRecordReference =
                          CustomClassesRecord.createDoc(currentUserReference!);
                      await customClassesRecordReference
                          .set(createCustomClassesRecordData(
                        courseName: _model.textController1.text,
                        courseDescription: _model.textController2.text,
                        isCustomSlot: _model.createCustomClass,
                        slotData: updateSlotInfoStruct(
                          _model.createCustomClass
                              ? SlotInfoStruct(
                                  slotName: _model.textController4.text,
                                  slotMetadata: _model.classSlots,
                                )
                              : _model.instituteSlots
                                  .where((e) =>
                                      e.slotName == _model.dropDownValue2)
                                  .toList()
                                  .firstOrNull,
                          clearUnsetFields: false,
                          create: true,
                        ),
                        toggleNotfications: _model.switchValue,
                        notificationMinutesBefore: valueOrDefault<int>(
                          _model.countControllerValue,
                          0,
                        ),
                        classAssets: _model.textController3.text,
                        courseID: functions
                            .randomNumberGenerator(
                                1000000,
                                9999999,
                                getCurrentTimestamp.microsecondsSinceEpoch
                                    .toString())
                            .toString(),
                        createdAt: getCurrentTimestamp,
                      ));
                      _model.generatedCustomClass =
                          CustomClassesRecord.getDocumentFromData(
                              createCustomClassesRecordData(
                                courseName: _model.textController1.text,
                                courseDescription: _model.textController2.text,
                                isCustomSlot: _model.createCustomClass,
                                slotData: updateSlotInfoStruct(
                                  _model.createCustomClass
                                      ? SlotInfoStruct(
                                          slotName: _model.textController4.text,
                                          slotMetadata: _model.classSlots,
                                        )
                                      : _model.instituteSlots
                                          .where((e) =>
                                              e.slotName ==
                                              _model.dropDownValue2)
                                          .toList()
                                          .firstOrNull,
                                  clearUnsetFields: false,
                                  create: true,
                                ),
                                toggleNotfications: _model.switchValue,
                                notificationMinutesBefore: valueOrDefault<int>(
                                  _model.countControllerValue,
                                  0,
                                ),
                                classAssets: _model.textController3.text,
                                courseID: functions
                                    .randomNumberGenerator(
                                        1000000,
                                        9999999,
                                        getCurrentTimestamp
                                            .microsecondsSinceEpoch
                                            .toString())
                                    .toString(),
                                createdAt: getCurrentTimestamp,
                              ),
                              customClassesRecordReference);
                      logFirebaseEvent('Button_update_component_state');
                      _model.updateSlotsListStruct(
                        (e) => e..slots = _model.classSlots.toList(),
                      );
                      safeSetState(() {});
                      logFirebaseEvent('Button_backend_call');
                      await NotificationsConfigTable().insert({
                        'course_id': _model.generatedCustomClass?.courseID,
                        'user_id': currentUserUid,
                        'slot_data': _model.slotsList?.toMap(),
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
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelLargeFamily,
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelLargeIsCustom,
                                ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).presentGreen,
                        ),
                      );
                      logFirebaseEvent('Button_dismiss_dialog');
                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    text: 'Save Class',
                    options: FFButtonOptions(
                      width: 180.0,
                      height: 45.0,
                      padding: EdgeInsets.all(8.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w800,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
