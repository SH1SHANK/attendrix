// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class StreakHistoryStruct extends FFFirebaseStruct {
  StreakHistoryStruct({
    DateTime? streakDate,
    int? streakNumber,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _streakDate = streakDate,
        _streakNumber = streakNumber,
        super(firestoreUtilData);

  // "streakDate" field.
  DateTime? _streakDate;
  DateTime get streakDate =>
      _streakDate ?? DateTime.fromMicrosecondsSinceEpoch(1746037800000000);
  set streakDate(DateTime? val) => _streakDate = val;

  bool hasStreakDate() => _streakDate != null;

  // "streakNumber" field.
  int? _streakNumber;
  int get streakNumber => _streakNumber ?? 0;
  set streakNumber(int? val) => _streakNumber = val;

  void incrementStreakNumber(int amount) =>
      streakNumber = streakNumber + amount;

  bool hasStreakNumber() => _streakNumber != null;

  static StreakHistoryStruct fromMap(Map<String, dynamic> data) =>
      StreakHistoryStruct(
        streakDate: data['streakDate'] as DateTime?,
        streakNumber: castToType<int>(data['streakNumber']),
      );

  static StreakHistoryStruct? maybeFromMap(dynamic data) => data is Map
      ? StreakHistoryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'streakDate': _streakDate,
        'streakNumber': _streakNumber,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'streakDate': serializeParam(
          _streakDate,
          ParamType.DateTime,
        ),
        'streakNumber': serializeParam(
          _streakNumber,
          ParamType.int,
        ),
      }.withoutNulls;

  static StreakHistoryStruct fromSerializableMap(Map<String, dynamic> data) =>
      StreakHistoryStruct(
        streakDate: deserializeParam(
          data['streakDate'],
          ParamType.DateTime,
          false,
        ),
        streakNumber: deserializeParam(
          data['streakNumber'],
          ParamType.int,
          false,
        ),
      );

  static StreakHistoryStruct fromAlgoliaData(Map<String, dynamic> data) =>
      StreakHistoryStruct(
        streakDate: convertAlgoliaParam(
          data['streakDate'],
          ParamType.DateTime,
          false,
        ),
        streakNumber: convertAlgoliaParam(
          data['streakNumber'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'StreakHistoryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StreakHistoryStruct &&
        streakDate == other.streakDate &&
        streakNumber == other.streakNumber;
  }

  @override
  int get hashCode => const ListEquality().hash([streakDate, streakNumber]);
}

StreakHistoryStruct createStreakHistoryStruct({
  DateTime? streakDate,
  int? streakNumber,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StreakHistoryStruct(
      streakDate: streakDate,
      streakNumber: streakNumber,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StreakHistoryStruct? updateStreakHistoryStruct(
  StreakHistoryStruct? streakHistory, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    streakHistory
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStreakHistoryStructData(
  Map<String, dynamic> firestoreData,
  StreakHistoryStruct? streakHistory,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (streakHistory == null) {
    return;
  }
  if (streakHistory.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && streakHistory.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final streakHistoryData =
      getStreakHistoryFirestoreData(streakHistory, forFieldValue);
  final nestedData =
      streakHistoryData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = streakHistory.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStreakHistoryFirestoreData(
  StreakHistoryStruct? streakHistory, [
  bool forFieldValue = false,
]) {
  if (streakHistory == null) {
    return {};
  }
  final firestoreData = mapToFirestore(streakHistory.toMap());

  // Add any Firestore field values
  streakHistory.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStreakHistoryListFirestoreData(
  List<StreakHistoryStruct>? streakHistorys,
) =>
    streakHistorys
        ?.map((e) => getStreakHistoryFirestoreData(e, true))
        .toList() ??
    [];
