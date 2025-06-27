// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ClassRowStruct extends FFFirebaseStruct {
  ClassRowStruct({
    String? classID,
    String? courseID,
    String? courseName,
    String? classStartTime,
    String? classEndTime,
    bool? isCustomClass,
    String? weekday,
    DateTime? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _classID = classID,
        _courseID = courseID,
        _courseName = courseName,
        _classStartTime = classStartTime,
        _classEndTime = classEndTime,
        _isCustomClass = isCustomClass,
        _weekday = weekday,
        _createdAt = createdAt,
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

  // "courseName" field.
  String? _courseName;
  String get courseName => _courseName ?? '';
  set courseName(String? val) => _courseName = val;

  bool hasCourseName() => _courseName != null;

  // "classStartTime" field.
  String? _classStartTime;
  String get classStartTime => _classStartTime ?? '';
  set classStartTime(String? val) => _classStartTime = val;

  bool hasClassStartTime() => _classStartTime != null;

  // "classEndTime" field.
  String? _classEndTime;
  String get classEndTime => _classEndTime ?? '';
  set classEndTime(String? val) => _classEndTime = val;

  bool hasClassEndTime() => _classEndTime != null;

  // "isCustomClass" field.
  bool? _isCustomClass;
  bool get isCustomClass => _isCustomClass ?? false;
  set isCustomClass(bool? val) => _isCustomClass = val;

  bool hasIsCustomClass() => _isCustomClass != null;

  // "weekday" field.
  String? _weekday;
  String get weekday => _weekday ?? 'sunday';
  set weekday(String? val) => _weekday = val;

  bool hasWeekday() => _weekday != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime get createdAt =>
      _createdAt ?? DateTime.fromMicrosecondsSinceEpoch(1748716200000000);
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static ClassRowStruct fromMap(Map<String, dynamic> data) => ClassRowStruct(
        classID: data['classID'] as String?,
        courseID: data['courseID'] as String?,
        courseName: data['courseName'] as String?,
        classStartTime: data['classStartTime'] as String?,
        classEndTime: data['classEndTime'] as String?,
        isCustomClass: data['isCustomClass'] as bool?,
        weekday: data['weekday'] as String?,
        createdAt: data['createdAt'] as DateTime?,
      );

  static ClassRowStruct? maybeFromMap(dynamic data) =>
      data is Map ? ClassRowStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'classID': _classID,
        'courseID': _courseID,
        'courseName': _courseName,
        'classStartTime': _classStartTime,
        'classEndTime': _classEndTime,
        'isCustomClass': _isCustomClass,
        'weekday': _weekday,
        'createdAt': _createdAt,
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
        'courseName': serializeParam(
          _courseName,
          ParamType.String,
        ),
        'classStartTime': serializeParam(
          _classStartTime,
          ParamType.String,
        ),
        'classEndTime': serializeParam(
          _classEndTime,
          ParamType.String,
        ),
        'isCustomClass': serializeParam(
          _isCustomClass,
          ParamType.bool,
        ),
        'weekday': serializeParam(
          _weekday,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ClassRowStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClassRowStruct(
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
        courseName: deserializeParam(
          data['courseName'],
          ParamType.String,
          false,
        ),
        classStartTime: deserializeParam(
          data['classStartTime'],
          ParamType.String,
          false,
        ),
        classEndTime: deserializeParam(
          data['classEndTime'],
          ParamType.String,
          false,
        ),
        isCustomClass: deserializeParam(
          data['isCustomClass'],
          ParamType.bool,
          false,
        ),
        weekday: deserializeParam(
          data['weekday'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  static ClassRowStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ClassRowStruct(
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
        courseName: convertAlgoliaParam(
          data['courseName'],
          ParamType.String,
          false,
        ),
        classStartTime: convertAlgoliaParam(
          data['classStartTime'],
          ParamType.String,
          false,
        ),
        classEndTime: convertAlgoliaParam(
          data['classEndTime'],
          ParamType.String,
          false,
        ),
        isCustomClass: convertAlgoliaParam(
          data['isCustomClass'],
          ParamType.bool,
          false,
        ),
        weekday: convertAlgoliaParam(
          data['weekday'],
          ParamType.String,
          false,
        ),
        createdAt: convertAlgoliaParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ClassRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClassRowStruct &&
        classID == other.classID &&
        courseID == other.courseID &&
        courseName == other.courseName &&
        classStartTime == other.classStartTime &&
        classEndTime == other.classEndTime &&
        isCustomClass == other.isCustomClass &&
        weekday == other.weekday &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        classID,
        courseID,
        courseName,
        classStartTime,
        classEndTime,
        isCustomClass,
        weekday,
        createdAt
      ]);
}

ClassRowStruct createClassRowStruct({
  String? classID,
  String? courseID,
  String? courseName,
  String? classStartTime,
  String? classEndTime,
  bool? isCustomClass,
  String? weekday,
  DateTime? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClassRowStruct(
      classID: classID,
      courseID: courseID,
      courseName: courseName,
      classStartTime: classStartTime,
      classEndTime: classEndTime,
      isCustomClass: isCustomClass,
      weekday: weekday,
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClassRowStruct? updateClassRowStruct(
  ClassRowStruct? classRow, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    classRow
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClassRowStructData(
  Map<String, dynamic> firestoreData,
  ClassRowStruct? classRow,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (classRow == null) {
    return;
  }
  if (classRow.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && classRow.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final classRowData = getClassRowFirestoreData(classRow, forFieldValue);
  final nestedData = classRowData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = classRow.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClassRowFirestoreData(
  ClassRowStruct? classRow, [
  bool forFieldValue = false,
]) {
  if (classRow == null) {
    return {};
  }
  final firestoreData = mapToFirestore(classRow.toMap());

  // Add any Firestore field values
  classRow.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClassRowListFirestoreData(
  List<ClassRowStruct>? classRows,
) =>
    classRows?.map((e) => getClassRowFirestoreData(e, true)).toList() ?? [];
