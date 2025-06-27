// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SlotMetadataStruct extends FFFirebaseStruct {
  SlotMetadataStruct({
    int? slotId,
    String? weekday,
    String? startTime,
    String? endTime,
    bool? isPlusSlot,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _slotId = slotId,
        _weekday = weekday,
        _startTime = startTime,
        _endTime = endTime,
        _isPlusSlot = isPlusSlot,
        super(firestoreUtilData);

  // "slotId" field.
  int? _slotId;
  int get slotId => _slotId ?? 0;
  set slotId(int? val) => _slotId = val;

  void incrementSlotId(int amount) => slotId = slotId + amount;

  bool hasSlotId() => _slotId != null;

  // "weekday" field.
  String? _weekday;
  String get weekday => _weekday ?? '';
  set weekday(String? val) => _weekday = val;

  bool hasWeekday() => _weekday != null;

  // "startTime" field.
  String? _startTime;
  String get startTime => _startTime ?? '';
  set startTime(String? val) => _startTime = val;

  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  String? _endTime;
  String get endTime => _endTime ?? '';
  set endTime(String? val) => _endTime = val;

  bool hasEndTime() => _endTime != null;

  // "isPlusSlot" field.
  bool? _isPlusSlot;
  bool get isPlusSlot => _isPlusSlot ?? false;
  set isPlusSlot(bool? val) => _isPlusSlot = val;

  bool hasIsPlusSlot() => _isPlusSlot != null;

  static SlotMetadataStruct fromMap(Map<String, dynamic> data) =>
      SlotMetadataStruct(
        slotId: castToType<int>(data['slotId']),
        weekday: data['weekday'] as String?,
        startTime: data['startTime'] as String?,
        endTime: data['endTime'] as String?,
        isPlusSlot: data['isPlusSlot'] as bool?,
      );

  static SlotMetadataStruct? maybeFromMap(dynamic data) => data is Map
      ? SlotMetadataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'slotId': _slotId,
        'weekday': _weekday,
        'startTime': _startTime,
        'endTime': _endTime,
        'isPlusSlot': _isPlusSlot,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'slotId': serializeParam(
          _slotId,
          ParamType.int,
        ),
        'weekday': serializeParam(
          _weekday,
          ParamType.String,
        ),
        'startTime': serializeParam(
          _startTime,
          ParamType.String,
        ),
        'endTime': serializeParam(
          _endTime,
          ParamType.String,
        ),
        'isPlusSlot': serializeParam(
          _isPlusSlot,
          ParamType.bool,
        ),
      }.withoutNulls;

  static SlotMetadataStruct fromSerializableMap(Map<String, dynamic> data) =>
      SlotMetadataStruct(
        slotId: deserializeParam(
          data['slotId'],
          ParamType.int,
          false,
        ),
        weekday: deserializeParam(
          data['weekday'],
          ParamType.String,
          false,
        ),
        startTime: deserializeParam(
          data['startTime'],
          ParamType.String,
          false,
        ),
        endTime: deserializeParam(
          data['endTime'],
          ParamType.String,
          false,
        ),
        isPlusSlot: deserializeParam(
          data['isPlusSlot'],
          ParamType.bool,
          false,
        ),
      );

  static SlotMetadataStruct fromAlgoliaData(Map<String, dynamic> data) =>
      SlotMetadataStruct(
        slotId: convertAlgoliaParam(
          data['slotId'],
          ParamType.int,
          false,
        ),
        weekday: convertAlgoliaParam(
          data['weekday'],
          ParamType.String,
          false,
        ),
        startTime: convertAlgoliaParam(
          data['startTime'],
          ParamType.String,
          false,
        ),
        endTime: convertAlgoliaParam(
          data['endTime'],
          ParamType.String,
          false,
        ),
        isPlusSlot: convertAlgoliaParam(
          data['isPlusSlot'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'SlotMetadataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SlotMetadataStruct &&
        slotId == other.slotId &&
        weekday == other.weekday &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        isPlusSlot == other.isPlusSlot;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([slotId, weekday, startTime, endTime, isPlusSlot]);
}

SlotMetadataStruct createSlotMetadataStruct({
  int? slotId,
  String? weekday,
  String? startTime,
  String? endTime,
  bool? isPlusSlot,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SlotMetadataStruct(
      slotId: slotId,
      weekday: weekday,
      startTime: startTime,
      endTime: endTime,
      isPlusSlot: isPlusSlot,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SlotMetadataStruct? updateSlotMetadataStruct(
  SlotMetadataStruct? slotMetadata, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    slotMetadata
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSlotMetadataStructData(
  Map<String, dynamic> firestoreData,
  SlotMetadataStruct? slotMetadata,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (slotMetadata == null) {
    return;
  }
  if (slotMetadata.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && slotMetadata.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final slotMetadataData =
      getSlotMetadataFirestoreData(slotMetadata, forFieldValue);
  final nestedData =
      slotMetadataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = slotMetadata.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSlotMetadataFirestoreData(
  SlotMetadataStruct? slotMetadata, [
  bool forFieldValue = false,
]) {
  if (slotMetadata == null) {
    return {};
  }
  final firestoreData = mapToFirestore(slotMetadata.toMap());

  // Add any Firestore field values
  slotMetadata.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSlotMetadataListFirestoreData(
  List<SlotMetadataStruct>? slotMetadatas,
) =>
    slotMetadatas?.map((e) => getSlotMetadataFirestoreData(e, true)).toList() ??
    [];
