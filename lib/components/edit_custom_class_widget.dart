import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/time_slot_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'edit_custom_class_model.dart';
export 'edit_custom_class_model.dart';

/// Class Creation Form
class EditCustomClassWidget extends StatefulWidget {
  const EditCustomClassWidget({
    super.key,
    required this.customClassRefDoc,
  });

  final CustomClassesRecord? customClassRefDoc;

  @override
  State<EditCustomClassWidget> createState() => _EditCustomClassWidgetState();
}

class _EditCustomClassWidgetState extends State<EditCustomClassWidget> {
  late EditCustomClassModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditCustomClassModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EDIT_CUSTOM_CLASS_editCustomClass_ON_INI');
      logFirebaseEvent('editCustomClass_backend_call');
      _model.initituteSlotsAPICall = await InstituteSlotsCall.call();

      if ((_model.initituteSlotsAPICall?.succeeded ?? true)) {
        logFirebaseEvent('editCustomClass_update_component_state');
        _model.instituteSlots = ((_model.initituteSlotsAPICall?.jsonBody ?? '')
                .toList()
                .map<SlotInfoStruct?>(SlotInfoStruct.maybeFromMap)
                .toList() as Iterable<SlotInfoStruct?>)
            .withoutNulls
            .toList()
            .cast<SlotInfoStruct>();
        _model.classSlots = widget.customClassRefDoc!.slotData.slotMetadata
            .toList()
            .cast<SlotMetadataStruct>();
        safeSetState(() {});
      } else {
        logFirebaseEvent('editCustomClass_dismiss_dialog');
        Navigator.pop(context);
      }

      logFirebaseEvent('editCustomClass_update_component_state');
      _model.classSlots = widget.customClassRefDoc!.slotData.slotMetadata
          .toList()
          .cast<SlotMetadataStruct>();
      safeSetState(() {});
    });

    _model.textController1 ??=
        TextEditingController(text: widget.customClassRefDoc?.courseName);
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController(
        text: widget.customClassRefDoc?.slotData.slotName);
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
                    'Modify Custom Class',
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
                          'EDIT_CUSTOM_CLASS_Icon_e7lpla21_ON_TAP');
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
                    readOnly: true,
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
                ].divide(SizedBox(height: 2.0)),
              ),
              Builder(
                builder: (context) {
                  if (widget.customClassRefDoc?.isCustomSlot ?? false) {
                    return Column(
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
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
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
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
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
                          validator: _model.textController2Validator
                              .asValidator(context),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 5.0),
                          child: Row(
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
                            ].divide(SizedBox(width: 4.0)),
                          ),
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
                                        'Keysmx_${slotsItem.slotId.toString()}',
                                      ),
                                      slotData: slotsItem,
                                      instituteSlots: _model.instituteSlots,
                                      slotCallback: (updatedSlotData) async {
                                        logFirebaseEvent(
                                            'EDIT_CUSTOM_CLASS_Container_smxt4chk_CAL');
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
                                            'EDIT_CUSTOM_CLASS_Container_smxt4chk_CAL');
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
                                'EDIT_CUSTOM_CLASS__ADD_TIME_SLOT_BTN_ON_');
                            logFirebaseEvent('Button_update_component_state');
                            _model.addToClassSlots(SlotMetadataStruct(
                              slotId: random_data.randomInteger(100000, 999999),
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
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .titleSmallIsCustom,
                                ),
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ].divide(SizedBox(height: 2.0)),
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
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>(
                                _model.dropDownValue ??= widget
                                    .customClassRefDoc?.slotData.slotName,
                              ),
                              options: functions.filterAlreadyEnrolledSlots(
                                  _model.instituteSlots.toList(),
                                  (currentUserDocument?.coursesEnrolled
                                              .toList() ??
                                          [])
                                      .map((e) => e.courseID)
                                      .toList()),
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue = val);
                                logFirebaseEvent(
                                    'EDIT_CUSTOM_CLASS_DropDown_67ap8j2g_ON_F');
                                logFirebaseEvent(
                                    'DropDown_update_component_state');
                                _model.instituteSlotSelected =
                                    _model.dropDownValue;
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'EDIT_CUSTOM_CLASS_COMP_CANCEL_BTN_ON_TAP');
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
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'EDIT_CUSTOM_CLASS_SAVE_CLASS_BTN_ON_TAP');
                        logFirebaseEvent('Button_backend_call');

                        await widget.customClassRefDoc!.reference
                            .update(createCustomClassesRecordData(
                          slotData: updateSlotInfoStruct(
                            SlotInfoStruct(
                              slotName: _model.textController2.text,
                              slotMetadata: _model.classSlots,
                            ),
                            clearUnsetFields: false,
                          ),
                        ));
                      },
                      text: 'Save Class',
                      options: FFButtonOptions(
                        width: 180.0,
                        height: 45.0,
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
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ].divide(SizedBox(width: 16.0)),
                ),
              ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ),
    );
  }
}
