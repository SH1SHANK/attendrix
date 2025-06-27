// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CourseFacultyStruct extends FFFirebaseStruct {
  CourseFacultyStruct({
    String? electiveFaculty,
    List<String>? batchFaculty,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _electiveFaculty = electiveFaculty,
        _batchFaculty = batchFaculty,
        super(firestoreUtilData);

  // "electiveFaculty" field.
  String? _electiveFaculty;
  String get electiveFaculty => _electiveFaculty ?? '';
  set electiveFaculty(String? val) => _electiveFaculty = val;

  bool hasElectiveFaculty() => _electiveFaculty != null;

  // "batchFaculty" field.
  List<String>? _batchFaculty;
  List<String> get batchFaculty => _batchFaculty ?? const [];
  set batchFaculty(List<String>? val) => _batchFaculty = val;

  void updateBatchFaculty(Function(List<String>) updateFn) {
    updateFn(_batchFaculty ??= []);
  }

  bool hasBatchFaculty() => _batchFaculty != null;

  static CourseFacultyStruct fromMap(Map<String, dynamic> data) =>
      CourseFacultyStruct(
        electiveFaculty: data['electiveFaculty'] as String?,
        batchFaculty: getDataList(data['batchFaculty']),
      );

  static CourseFacultyStruct? maybeFromMap(dynamic data) => data is Map
      ? CourseFacultyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'electiveFaculty': _electiveFaculty,
        'batchFaculty': _batchFaculty,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'electiveFaculty': serializeParam(
          _electiveFaculty,
          ParamType.String,
        ),
        'batchFaculty': serializeParam(
          _batchFaculty,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static CourseFacultyStruct fromSerializableMap(Map<String, dynamic> data) =>
      CourseFacultyStruct(
        electiveFaculty: deserializeParam(
          data['electiveFaculty'],
          ParamType.String,
          false,
        ),
        batchFaculty: deserializeParam<String>(
          data['batchFaculty'],
          ParamType.String,
          true,
        ),
      );

  static CourseFacultyStruct fromAlgoliaData(Map<String, dynamic> data) =>
      CourseFacultyStruct(
        electiveFaculty: convertAlgoliaParam(
          data['electiveFaculty'],
          ParamType.String,
          false,
        ),
        batchFaculty: convertAlgoliaParam<String>(
          data['batchFaculty'],
          ParamType.String,
          true,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'CourseFacultyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CourseFacultyStruct &&
        electiveFaculty == other.electiveFaculty &&
        listEquality.equals(batchFaculty, other.batchFaculty);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([electiveFaculty, batchFaculty]);
}

CourseFacultyStruct createCourseFacultyStruct({
  String? electiveFaculty,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CourseFacultyStruct(
      electiveFaculty: electiveFaculty,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CourseFacultyStruct? updateCourseFacultyStruct(
  CourseFacultyStruct? courseFaculty, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    courseFaculty
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCourseFacultyStructData(
  Map<String, dynamic> firestoreData,
  CourseFacultyStruct? courseFaculty,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (courseFaculty == null) {
    return;
  }
  if (courseFaculty.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && courseFaculty.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final courseFacultyData =
      getCourseFacultyFirestoreData(courseFaculty, forFieldValue);
  final nestedData =
      courseFacultyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = courseFaculty.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCourseFacultyFirestoreData(
  CourseFacultyStruct? courseFaculty, [
  bool forFieldValue = false,
]) {
  if (courseFaculty == null) {
    return {};
  }
  final firestoreData = mapToFirestore(courseFaculty.toMap());

  // Add any Firestore field values
  courseFaculty.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCourseFacultyListFirestoreData(
  List<CourseFacultyStruct>? courseFacultys,
) =>
    courseFacultys
        ?.map((e) => getCourseFacultyFirestoreData(e, true))
        .toList() ??
    [];
