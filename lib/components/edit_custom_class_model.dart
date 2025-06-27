import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/time_slot_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_custom_class_widget.dart' show EditCustomClassWidget;
import 'package:flutter/material.dart';

class EditCustomClassModel extends FlutterFlowModel<EditCustomClassWidget> {
  ///  Local state fields for this component.

  bool createCustomClass = false;

  List<SlotMetadataStruct> classSlots = [];
  void addToClassSlots(SlotMetadataStruct item) => classSlots.add(item);
  void removeFromClassSlots(SlotMetadataStruct item) => classSlots.remove(item);
  void removeAtIndexFromClassSlots(int index) => classSlots.removeAt(index);
  void insertAtIndexInClassSlots(int index, SlotMetadataStruct item) =>
      classSlots.insert(index, item);
  void updateClassSlotsAtIndex(
          int index, Function(SlotMetadataStruct) updateFn) =>
      classSlots[index] = updateFn(classSlots[index]);

  String? instituteSlotSelected = 'A';

  List<SlotInfoStruct> instituteSlots = [];
  void addToInstituteSlots(SlotInfoStruct item) => instituteSlots.add(item);
  void removeFromInstituteSlots(SlotInfoStruct item) =>
      instituteSlots.remove(item);
  void removeAtIndexFromInstituteSlots(int index) =>
      instituteSlots.removeAt(index);
  void insertAtIndexInInstituteSlots(int index, SlotInfoStruct item) =>
      instituteSlots.insert(index, item);
  void updateInstituteSlotsAtIndex(
          int index, Function(SlotInfoStruct) updateFn) =>
      instituteSlots[index] = updateFn(instituteSlots[index]);

  SlotsListStruct? slotsList;
  void updateSlotsListStruct(Function(SlotsListStruct) updateFn) {
    updateFn(slotsList ??= SlotsListStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Institute Slots)] action in editCustomClass widget.
  ApiCallResponse? initituteSlotsAPICall;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Models for timeSlot dynamic component.
  late FlutterFlowDynamicModels<TimeSlotModel> timeSlotModels;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {
    timeSlotModels = FlutterFlowDynamicModels(() => TimeSlotModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    timeSlotModels.dispose();
  }
}
