// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SlotInfoStruct extends FFFirebaseStruct {
  SlotInfoStruct({
    String? slotName,
    List<SlotMetadataStruct>? slotMetadata,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _slotName = slotName,
        _slotMetadata = slotMetadata,
        super(firestoreUtilData);

  // "slotName" field.
  String? _slotName;
  String get slotName => _slotName ?? '';
  set slotName(String? val) => _slotName = val;

  bool hasSlotName() => _slotName != null;

  // "slotMetadata" field.
  List<SlotMetadataStruct>? _slotMetadata;
  List<SlotMetadataStruct> get slotMetadata => _slotMetadata ?? const [];
  set slotMetadata(List<SlotMetadataStruct>? val) => _slotMetadata = val;

  void updateSlotMetadata(Function(List<SlotMetadataStruct>) updateFn) {
    updateFn(_slotMetadata ??= []);
  }

  bool hasSlotMetadata() => _slotMetadata != null;

  static SlotInfoStruct fromMap(Map<String, dynamic> data) => SlotInfoStruct(
        slotName: data['slotName'] as String?,
        slotMetadata: getStructList(
          data['slotMetadata'],
          SlotMetadataStruct.fromMap,
        ),
      );

  static SlotInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? SlotInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'slotName': _slotName,
        'slotMetadata': _slotMetadata?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'slotName': serializeParam(
          _slotName,
          ParamType.String,
        ),
        'slotMetadata': serializeParam(
          _slotMetadata,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SlotInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      SlotInfoStruct(
        slotName: deserializeParam(
          data['slotName'],
          ParamType.String,
          false,
        ),
        slotMetadata: deserializeStructParam<SlotMetadataStruct>(
          data['slotMetadata'],
          ParamType.DataStruct,
          true,
          structBuilder: SlotMetadataStruct.fromSerializableMap,
        ),
      );

  static SlotInfoStruct fromAlgoliaData(Map<String, dynamic> data) =>
      SlotInfoStruct(
        slotName: convertAlgoliaParam(
          data['slotName'],
          ParamType.String,
          false,
        ),
        slotMetadata: convertAlgoliaParam<SlotMetadataStruct>(
          data['slotMetadata'],
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
  String toString() => 'SlotInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SlotInfoStruct &&
        slotName == other.slotName &&
        listEquality.equals(slotMetadata, other.slotMetadata);
  }

  @override
  int get hashCode => const ListEquality().hash([slotName, slotMetadata]);
}

SlotInfoStruct createSlotInfoStruct({
  String? slotName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SlotInfoStruct(
      slotName: slotName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SlotInfoStruct? updateSlotInfoStruct(
  SlotInfoStruct? slotInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    slotInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSlotInfoStructData(
  Map<String, dynamic> firestoreData,
  SlotInfoStruct? slotInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (slotInfo == null) {
    return;
  }
  if (slotInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && slotInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final slotInfoData = getSlotInfoFirestoreData(slotInfo, forFieldValue);
  final nestedData = slotInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = slotInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSlotInfoFirestoreData(
  SlotInfoStruct? slotInfo, [
  bool forFieldValue = false,
]) {
  if (slotInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(slotInfo.toMap());

  // Add any Firestore field values
  slotInfo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSlotInfoListFirestoreData(
  List<SlotInfoStruct>? slotInfos,
) =>
    slotInfos?.map((e) => getSlotInfoFirestoreData(e, true)).toList() ?? [];
