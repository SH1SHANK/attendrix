import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'time_slot_model.dart';
export 'time_slot_model.dart';

class TimeSlotWidget extends StatefulWidget {
  const TimeSlotWidget({
    super.key,
    this.slotData,
    this.slotCallback,
    this.deleteSlot,
    this.instituteSlots,
  });

  final SlotMetadataStruct? slotData;
  final Future Function(SlotMetadataStruct? updatedSlotData)? slotCallback;
  final Future Function(int? deleteSlot)? deleteSlot;
  final List<SlotInfoStruct>? instituteSlots;

  @override
  State<TimeSlotWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  late TimeSlotModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimeSlotModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 400.0,
        height: 160.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 3.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 12.0, 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, -1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Slot Day:',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('TIME_SLOT_COMP_Icon_qkp6b9l6_ON_TAP');
                      logFirebaseEvent('Icon_execute_callback');
                      await widget.deleteSlot?.call(
                        widget.slotData?.slotId,
                      );
                    },
                    child: Icon(
                      FFIcons.ktrash,
                      color: FlutterFlowTheme.of(context).absentRed,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              child: FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController ??=
                    FormFieldController<String>(
                  _model.dropDownValue ??= 'Monday',
                ),
                options: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ],
                onChanged: (val) async {
                  safeSetState(() => _model.dropDownValue = val);
                  logFirebaseEvent('TIME_SLOT_DropDown_fwv3099c_ON_FORM_WIDG');
                  logFirebaseEvent('DropDown_execute_callback');
                  await widget.slotCallback?.call(
                    SlotMetadataStruct(
                      slotId: widget.slotData?.slotId,
                      weekday: _model.dropDownValue,
                      startTime:
                          _model.datePicked1?.secondsSinceEpoch.toString(),
                      endTime:
                          _model.datePicked2?.secondsSinceEpoch.toString(),
                    ),
                  );
                },
                width: double.infinity,
                height: 45.0,
                textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).labelMediumFamily,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).labelMediumIsCustom,
                    ),
                hintText: 'Select The Day...',
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 24.0,
                ),
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                elevation: 1.0,
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderWidth: 2.0,
                borderRadius: 12.0,
                margin: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                isSearchable: false,
                isMultiSelect: false,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'TIME_SLOT_COMP_Container_j0jptrdw_ON_TAP');
                            logFirebaseEvent('Container_date_time_picker');

                            final _datePicked1Time = await showTimePicker(
                              context: context,
                              barrierDismissible: false,
                              initialTime:
                                  TimeOfDay.fromDateTime(getCurrentTimestamp),
                              builder: (context, child) {
                                return wrapInMaterialTimePickerTheme(
                                  context,
                                  child!,
                                  headerBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  headerForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  headerTextStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
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
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedDateTimeBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  selectedDateTimeForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  actionButtonForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 24.0,
                                );
                              },
                            );
                            if (_datePicked1Time != null) {
                              safeSetState(() {
                                _model.datePicked1 = DateTime(
                                  getCurrentTimestamp.year,
                                  getCurrentTimestamp.month,
                                  getCurrentTimestamp.day,
                                  _datePicked1Time.hour,
                                  _datePicked1Time.minute,
                                );
                              });
                            } else if (_model.datePicked1 != null) {
                              safeSetState(() {
                                _model.datePicked1 = getCurrentTimestamp;
                              });
                            }
                            if (_model.datePicked1 != null) {
                              if (functions.checkForSlotConflicts(
                                  (currentUserDocument?.coursesEnrolled
                                              .toList() ??
                                          [])
                                      .map((e) => e.courseID)
                                      .toList(),
                                  _model.dropDownValue!,
                                  _model.datePicked1!,
                                  widget.instituteSlots!.toList(),
                                  _model.datePicked2)) {
                                logFirebaseEvent(
                                    'Container_update_component_state');
                                _model.conflictsAvailable = true;
                                safeSetState(() {});
                              } else {
                                logFirebaseEvent('Container_execute_callback');
                                await widget.slotCallback?.call(
                                  SlotMetadataStruct(
                                    slotId: widget.slotData?.slotId,
                                    weekday: _model.dropDownValue,
                                    startTime: _model
                                        .datePicked1?.secondsSinceEpoch
                                        .toString(),
                                    endTime: _model
                                        .datePicked2?.secondsSinceEpoch
                                        .toString(),
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            width: 110.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(14.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  6.0, 0.0, 6.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FFIcons.kclockCountdown,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 18.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat(
                                          "jm",
                                          _model.datePicked1,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        'Start Time',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'TIME_SLOT_COMP_Container_lkf6aj92_ON_TAP');
                            logFirebaseEvent('Container_date_time_picker');

                            final _datePicked2Time = await showTimePicker(
                              context: context,
                              barrierDismissible: false,
                              initialTime:
                                  TimeOfDay.fromDateTime(getCurrentTimestamp),
                              builder: (context, child) {
                                return wrapInMaterialTimePickerTheme(
                                  context,
                                  child!,
                                  headerBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  headerForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  headerTextStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
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
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedDateTimeBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  selectedDateTimeForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  actionButtonForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 24.0,
                                );
                              },
                            );
                            if (_datePicked2Time != null) {
                              safeSetState(() {
                                _model.datePicked2 = DateTime(
                                  getCurrentTimestamp.year,
                                  getCurrentTimestamp.month,
                                  getCurrentTimestamp.day,
                                  _datePicked2Time.hour,
                                  _datePicked2Time.minute,
                                );
                              });
                            } else if (_model.datePicked2 != null) {
                              safeSetState(() {
                                _model.datePicked2 = getCurrentTimestamp;
                              });
                            }
                            if (_model.datePicked2 != null) {
                              if (functions.checkForSlotConflicts(
                                  (currentUserDocument?.coursesEnrolled
                                              .toList() ??
                                          [])
                                      .map((e) => e.courseID)
                                      .toList(),
                                  _model.dropDownValue!,
                                  _model.datePicked1!,
                                  widget.instituteSlots!.toList(),
                                  _model.datePicked2)) {
                                logFirebaseEvent(
                                    'Container_update_component_state');
                                _model.conflictsAvailable = true;
                                safeSetState(() {});
                              } else {
                                logFirebaseEvent('Container_execute_callback');
                                await widget.slotCallback?.call(
                                  SlotMetadataStruct(
                                    slotId: widget.slotData?.slotId,
                                    weekday: _model.dropDownValue,
                                    startTime: _model
                                        .datePicked1?.secondsSinceEpoch
                                        .toString(),
                                    endTime: _model
                                        .datePicked2?.secondsSinceEpoch
                                        .toString(),
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            width: 110.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(14.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  6.0, 0.0, 6.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FFIcons.kclockCountdown,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 18.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat(
                                          "jm",
                                          _model.datePicked2,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        'End Time',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelSmallIsCustom,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (valueOrDefault<bool>(
              _model.conflictsAvailable,
              false,
            ))
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(14.0, 5.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      FFIcons.kwarningBold,
                      color: FlutterFlowTheme.of(context).absentRed,
                      size: 16.0,
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.0, -1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Conflicts with your existing timeslots.',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: FlutterFlowTheme.of(context).absentRed,
                                fontSize: 11.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
