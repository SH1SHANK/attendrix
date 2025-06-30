// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class MissedClassDetailsStruct extends FFFirebaseStruct {
  MissedClassDetailsStruct({
    String? classID,
    String? courseID,
    DateTime? classStartTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _classID = classID,
        _courseID = courseID,
        _classStartTime = classStartTime,
        super(firestoreUtilData);

  // "classID" field.
  String? _classID;
  String get classID => _classID ?? '';
  set classID(String? val) => _classID = val;

  bool hasClassID() => _classID != null;

  // "courseID" field.
  String? _courseID;
  String get courseID => _courseID ?? '';
  set courseID(String? val) => _courseID = val;

  bool hasCourseID() => _courseID != null;

  // "classStartTime" field.
  DateTime? _classStartTime;
  DateTime? get classStartTime => _classStartTime;
  set classStartTime(DateTime? val) => _classStartTime = val;

  bool hasClassStartTime() => _classStartTime != null;

  static MissedClassDetailsStruct fromMap(Map<String, dynamic> data) =>
      MissedClassDetailsStruct(
        classID: data['classID'] as String?,
        courseID: data['courseID'] as String?,
        classStartTime: data['classStartTime'] as DateTime?,
      );

  static MissedClassDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? MissedClassDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'classID': _classID,
        'courseID': _courseID,
        'classStartTime': _classStartTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'classID': serializeParam(
          _classID,
          ParamType.String,
        ),
        'courseID': serializeParam(
          _courseID,
          ParamType.String,
        ),
        'classStartTime': serializeParam(
          _classStartTime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static MissedClassDetailsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      MissedClassDetailsStruct(
        classID: deserializeParam(
          data['classID'],
          ParamType.String,
          false,
        ),
        courseID: deserializeParam(
          data['courseID'],
          ParamType.String,
          false,
        ),
        classStartTime: deserializeParam(
          data['classStartTime'],
          ParamType.DateTime,
          false,
        ),
      );

  static MissedClassDetailsStruct fromAlgoliaData(Map<String, dynamic> data) =>
      MissedClassDetailsStruct(
        classID: convertAlgoliaParam(
          data['classID'],
          ParamType.String,
          false,
        ),
        courseID: convertAlgoliaParam(
          data['courseID'],
          ParamType.String,
          false,
        ),
        classStartTime: convertAlgoliaParam(
          data['classStartTime'],
          ParamType.DateTime,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'MissedClassDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MissedClassDetailsStruct &&
        classID == other.classID &&
        courseID == other.courseID &&
        classStartTime == other.classStartTime;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([classID, courseID, classStartTime]);
}

MissedClassDetailsStruct createMissedClassDetailsStruct({
  String? classID,
  String? courseID,
  DateTime? classStartTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MissedClassDetailsStruct(
      classID: classID,
      courseID: courseID,
      classStartTime: classStartTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MissedClassDetailsStruct? updateMissedClassDetailsStruct(
  MissedClassDetailsStruct? missedClassDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    missedClassDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMissedClassDetailsStructData(
  Map<String, dynamic> firestoreData,
  MissedClassDetailsStruct? missedClassDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (missedClassDetails == null) {
    return;
  }
  if (missedClassDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && missedClassDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final missedClassDetailsData =
      getMissedClassDetailsFirestoreData(missedClassDetails, forFieldValue);
  final nestedData =
      missedClassDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      missedClassDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMissedClassDetailsFirestoreData(
  MissedClassDetailsStruct? missedClassDetails, [
  bool forFieldValue = false,
]) {
  if (missedClassDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(missedClassDetails.toMap());

  // Add any Firestore field values
  missedClassDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMissedClassDetailsListFirestoreData(
  List<MissedClassDetailsStruct>? missedClassDetailss,
) =>
    missedClassDetailss
        ?.map((e) => getMissedClassDetailsFirestoreData(e, true))
        .toList() ??
    [];
