// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CourseType2Struct extends FFFirebaseStruct {
  CourseType2Struct({
    String? courseType,
    String? electiveCategory,
    String? department,
    bool? isLab,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _courseType = courseType,
        _electiveCategory = electiveCategory,
        _department = department,
        _isLab = isLab,
        super(firestoreUtilData);

  // "courseType" field.
  String? _courseType;
  String get courseType => _courseType ?? '';
  set courseType(String? val) => _courseType = val;

  bool hasCourseType() => _courseType != null;

  // "electiveCategory" field.
  String? _electiveCategory;
  String get electiveCategory => _electiveCategory ?? '';
  set electiveCategory(String? val) => _electiveCategory = val;

  bool hasElectiveCategory() => _electiveCategory != null;

  // "department" field.
  String? _department;
  String get department => _department ?? '';
  set department(String? val) => _department = val;

  bool hasDepartment() => _department != null;

  // "isLab" field.
  bool? _isLab;
  bool get isLab => _isLab ?? false;
  set isLab(bool? val) => _isLab = val;

  bool hasIsLab() => _isLab != null;

  static CourseType2Struct fromMap(Map<String, dynamic> data) =>
      CourseType2Struct(
        courseType: data['courseType'] as String?,
        electiveCategory: data['electiveCategory'] as String?,
        department: data['department'] as String?,
        isLab: data['isLab'] as bool?,
      );

  static CourseType2Struct? maybeFromMap(dynamic data) => data is Map
      ? CourseType2Struct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'courseType': _courseType,
        'electiveCategory': _electiveCategory,
        'department': _department,
        'isLab': _isLab,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'courseType': serializeParam(
          _courseType,
          ParamType.String,
        ),
        'electiveCategory': serializeParam(
          _electiveCategory,
          ParamType.String,
        ),
        'department': serializeParam(
          _department,
          ParamType.String,
        ),
        'isLab': serializeParam(
          _isLab,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CourseType2Struct fromSerializableMap(Map<String, dynamic> data) =>
      CourseType2Struct(
        courseType: deserializeParam(
          data['courseType'],
          ParamType.String,
          false,
        ),
        electiveCategory: deserializeParam(
          data['electiveCategory'],
          ParamType.String,
          false,
        ),
        department: deserializeParam(
          data['department'],
          ParamType.String,
          false,
        ),
        isLab: deserializeParam(
          data['isLab'],
          ParamType.bool,
          false,
        ),
      );

  static CourseType2Struct fromAlgoliaData(Map<String, dynamic> data) =>
      CourseType2Struct(
        courseType: convertAlgoliaParam(
          data['courseType'],
          ParamType.String,
          false,
        ),
        electiveCategory: convertAlgoliaParam(
          data['electiveCategory'],
          ParamType.String,
          false,
        ),
        department: convertAlgoliaParam(
          data['department'],
          ParamType.String,
          false,
        ),
        isLab: convertAlgoliaParam(
          data['isLab'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'CourseType2Struct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CourseType2Struct &&
        courseType == other.courseType &&
        electiveCategory == other.electiveCategory &&
        department == other.department &&
        isLab == other.isLab;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([courseType, electiveCategory, department, isLab]);
}

CourseType2Struct createCourseType2Struct({
  String? courseType,
  String? electiveCategory,
  String? department,
  bool? isLab,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CourseType2Struct(
      courseType: courseType,
      electiveCategory: electiveCategory,
      department: department,
      isLab: isLab,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CourseType2Struct? updateCourseType2Struct(
  CourseType2Struct? courseType2, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    courseType2
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCourseType2StructData(
  Map<String, dynamic> firestoreData,
  CourseType2Struct? courseType2,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (courseType2 == null) {
    return;
  }
  if (courseType2.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && courseType2.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final courseType2Data =
      getCourseType2FirestoreData(courseType2, forFieldValue);
  final nestedData =
      courseType2Data.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = courseType2.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCourseType2FirestoreData(
  CourseType2Struct? courseType2, [
  bool forFieldValue = false,
]) {
  if (courseType2 == null) {
    return {};
  }
  final firestoreData = mapToFirestore(courseType2.toMap());

  // Add any Firestore field values
  courseType2.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCourseType2ListFirestoreData(
  List<CourseType2Struct>? courseType2s,
) =>
    courseType2s?.map((e) => getCourseType2FirestoreData(e, true)).toList() ??
    [];
