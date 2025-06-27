// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BatchFacultyStruct extends FFFirebaseStruct {
  BatchFacultyStruct({
    String? batch01,
    String? batch02,
    String? batch03,
    String? batch04,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _batch01 = batch01,
        _batch02 = batch02,
        _batch03 = batch03,
        _batch04 = batch04,
        super(firestoreUtilData);

  // "batch01" field.
  String? _batch01;
  String get batch01 => _batch01 ?? '';
  set batch01(String? val) => _batch01 = val;

  bool hasBatch01() => _batch01 != null;

  // "batch02" field.
  String? _batch02;
  String get batch02 => _batch02 ?? '';
  set batch02(String? val) => _batch02 = val;

  bool hasBatch02() => _batch02 != null;

  // "batch03" field.
  String? _batch03;
  String get batch03 => _batch03 ?? '';
  set batch03(String? val) => _batch03 = val;

  bool hasBatch03() => _batch03 != null;

  // "batch04" field.
  String? _batch04;
  String get batch04 => _batch04 ?? '';
  set batch04(String? val) => _batch04 = val;

  bool hasBatch04() => _batch04 != null;

  static BatchFacultyStruct fromMap(Map<String, dynamic> data) =>
      BatchFacultyStruct(
        batch01: data['batch01'] as String?,
        batch02: data['batch02'] as String?,
        batch03: data['batch03'] as String?,
        batch04: data['batch04'] as String?,
      );

  static BatchFacultyStruct? maybeFromMap(dynamic data) => data is Map
      ? BatchFacultyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'batch01': _batch01,
        'batch02': _batch02,
        'batch03': _batch03,
        'batch04': _batch04,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'batch01': serializeParam(
          _batch01,
          ParamType.String,
        ),
        'batch02': serializeParam(
          _batch02,
          ParamType.String,
        ),
        'batch03': serializeParam(
          _batch03,
          ParamType.String,
        ),
        'batch04': serializeParam(
          _batch04,
          ParamType.String,
        ),
      }.withoutNulls;

  static BatchFacultyStruct fromSerializableMap(Map<String, dynamic> data) =>
      BatchFacultyStruct(
        batch01: deserializeParam(
          data['batch01'],
          ParamType.String,
          false,
        ),
        batch02: deserializeParam(
          data['batch02'],
          ParamType.String,
          false,
        ),
        batch03: deserializeParam(
          data['batch03'],
          ParamType.String,
          false,
        ),
        batch04: deserializeParam(
          data['batch04'],
          ParamType.String,
          false,
        ),
      );

  static BatchFacultyStruct fromAlgoliaData(Map<String, dynamic> data) =>
      BatchFacultyStruct(
        batch01: convertAlgoliaParam(
          data['batch01'],
          ParamType.String,
          false,
        ),
        batch02: convertAlgoliaParam(
          data['batch02'],
          ParamType.String,
          false,
        ),
        batch03: convertAlgoliaParam(
          data['batch03'],
          ParamType.String,
          false,
        ),
        batch04: convertAlgoliaParam(
          data['batch04'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'BatchFacultyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BatchFacultyStruct &&
        batch01 == other.batch01 &&
        batch02 == other.batch02 &&
        batch03 == other.batch03 &&
        batch04 == other.batch04;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([batch01, batch02, batch03, batch04]);
}

BatchFacultyStruct createBatchFacultyStruct({
  String? batch01,
  String? batch02,
  String? batch03,
  String? batch04,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BatchFacultyStruct(
      batch01: batch01,
      batch02: batch02,
      batch03: batch03,
      batch04: batch04,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BatchFacultyStruct? updateBatchFacultyStruct(
  BatchFacultyStruct? batchFaculty, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    batchFaculty
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBatchFacultyStructData(
  Map<String, dynamic> firestoreData,
  BatchFacultyStruct? batchFaculty,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (batchFaculty == null) {
    return;
  }
  if (batchFaculty.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && batchFaculty.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final batchFacultyData =
      getBatchFacultyFirestoreData(batchFaculty, forFieldValue);
  final nestedData =
      batchFacultyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = batchFaculty.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBatchFacultyFirestoreData(
  BatchFacultyStruct? batchFaculty, [
  bool forFieldValue = false,
]) {
  if (batchFaculty == null) {
    return {};
  }
  final firestoreData = mapToFirestore(batchFaculty.toMap());

  // Add any Firestore field values
  batchFaculty.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBatchFacultyListFirestoreData(
  List<BatchFacultyStruct>? batchFacultys,
) =>
    batchFacultys?.map((e) => getBatchFacultyFirestoreData(e, true)).toList() ??
    [];
