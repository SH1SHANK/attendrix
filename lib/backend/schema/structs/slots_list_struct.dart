// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SlotsListStruct extends FFFirebaseStruct {
  SlotsListStruct({
    List<SlotMetadataStruct>? slots,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _slots = slots,
        super(firestoreUtilData);

  // "Slots" field.
  List<SlotMetadataStruct>? _slots;
  List<SlotMetadataStruct> get slots => _slots ?? const [];
  set slots(List<SlotMetadataStruct>? val) => _slots = val;

  void updateSlots(Function(List<SlotMetadataStruct>) updateFn) {
    updateFn(_slots ??= []);
  }

  bool hasSlots() => _slots != null;

  static SlotsListStruct fromMap(Map<String, dynamic> data) => SlotsListStruct(
        slots: getStructList(
          data['Slots'],
          SlotMetadataStruct.fromMap,
        ),
      );

  static SlotsListStruct? maybeFromMap(dynamic data) => data is Map
      ? SlotsListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Slots': _slots?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Slots': serializeParam(
          _slots,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SlotsListStruct fromSerializableMap(Map<String, dynamic> data) =>
      SlotsListStruct(
        slots: deserializeStructParam<SlotMetadataStruct>(
          data['Slots'],
          ParamType.DataStruct,
          true,
          structBuilder: SlotMetadataStruct.fromSerializableMap,
        ),
      );

  static SlotsListStruct fromAlgoliaData(Map<String, dynamic> data) =>
      SlotsListStruct(
        slots: convertAlgoliaParam<SlotMetadataStruct>(
          data['Slots'],
          ParamType.DataStruct,
          true,
          structBuilder: SlotMetadataStruct.fromAlgoliaData,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'SlotsListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SlotsListStruct && listEquality.equals(slots, other.slots);
  }

  @override
  int get hashCode => const ListEquality().hash([slots]);
}

SlotsListStruct createSlotsListStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SlotsListStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SlotsListStruct? updateSlotsListStruct(
  SlotsListStruct? slotsList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    slotsList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSlotsListStructData(
  Map<String, dynamic> firestoreData,
  SlotsListStruct? slotsList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (slotsList == null) {
    return;
  }
  if (slotsList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && slotsList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final slotsListData = getSlotsListFirestoreData(slotsList, forFieldValue);
  final nestedData = slotsListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = slotsList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSlotsListFirestoreData(
  SlotsListStruct? slotsList, [
  bool forFieldValue = false,
]) {
  if (slotsList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(slotsList.toMap());

  // Add any Firestore field values
  slotsList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSlotsListListFirestoreData(
  List<SlotsListStruct>? slotsLists,
) =>
    slotsLists?.map((e) => getSlotsListFirestoreData(e, true)).toList() ?? [];
