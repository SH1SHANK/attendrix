import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/time_slot_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'create_custom_class_widget.dart' show CreateCustomClassWidget;
import 'package:flutter/material.dart';

class CreateCustomClassModel extends FlutterFlowModel<CreateCustomClassWidget> {
  ///  Local state fields for this page.

  List<SlotInfoStruct> instituteSlotsCall = [];
  void addToInstituteSlotsCall(SlotInfoStruct item) =>
      instituteSlotsCall.add(item);
  void removeFromInstituteSlotsCall(SlotInfoStruct item) =>
      instituteSlotsCall.remove(item);
  void removeAtIndexFromInstituteSlotsCall(int index) =>
      instituteSlotsCall.removeAt(index);
  void insertAtIndexInInstituteSlotsCall(int index, SlotInfoStruct item) =>
      instituteSlotsCall.insert(index, item);
  void updateInstituteSlotsCallAtIndex(
          int index, Function(SlotInfoStruct) updateFn) =>
      instituteSlotsCall[index] = updateFn(instituteSlotsCall[index]);

  bool isCustomSlot = false;

  List<SlotMetadataStruct> addedSlots = [];
  void addToAddedSlots(SlotMetadataStruct item) => addedSlots.add(item);
  void removeFromAddedSlots(SlotMetadataStruct item) => addedSlots.remove(item);
  void removeAtIndexFromAddedSlots(int index) => addedSlots.removeAt(index);
  void insertAtIndexInAddedSlots(int index, SlotMetadataStruct item) =>
      addedSlots.insert(index, item);
  void updateAddedSlotsAtIndex(
          int index, Function(SlotMetadataStruct) updateFn) =>
      addedSlots[index] = updateFn(addedSlots[index]);

  String? selectedInstituteSlot;

  SlotsListStruct? slotsList;
  void updateSlotsListStruct(Function(SlotsListStruct) updateFn) {
    updateFn(slotsList ??= SlotsListStruct());
  }

  DateTime? startDate;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Institute Slots)] action in createCustomClass widget.
  ApiCallResponse? instituteSlots;
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
  DateTime? datePicked;
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
