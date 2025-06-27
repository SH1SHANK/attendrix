import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/time_slot_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'custom_class_widget.dart' show CustomClassWidget;
import 'package:flutter/material.dart';

class CustomClassModel extends FlutterFlowModel<CustomClassWidget> {
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

  // Stores action output result for [Backend Call - API (Institute Slots)] action in customClass widget.
  ApiCallResponse? initituteSlotsAPICall;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for DropDown widget.
  bool? dropDownValue1;
  FormFieldController<bool>? dropDownValueController1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // Models for timeSlot dynamic component.
  late FlutterFlowDynamicModels<TimeSlotModel> timeSlotModels;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for CountController widget.
  int? countControllerValue;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CustomClassesRecord? generatedCustomClass;

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

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    timeSlotModels.dispose();
  }
}
