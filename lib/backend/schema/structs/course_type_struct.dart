// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CourseTypeStruct extends FFFirebaseStruct {
  CourseTypeStruct({
    String? courseType,
    String? electiveCategory,
    bool? isLab,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _courseType = courseType,
        _electiveCategory = electiveCategory,
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

  // "isLab" field.
  bool? _isLab;
  bool get isLab => _isLab ?? false;
  set isLab(bool? val) => _isLab = val;

  bool hasIsLab() => _isLab != null;

  static CourseTypeStruct fromMap(Map<String, dynamic> data) =>
      CourseTypeStruct(
        courseType: data['courseType'] as String?,
        electiveCategory: data['electiveCategory'] as String?,
        isLab: data['isLab'] as bool?,
      );

  static CourseTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? CourseTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'courseType': _courseType,
        'electiveCategory': _electiveCategory,
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
        'isLab': serializeParam(
          _isLab,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CourseTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      CourseTypeStruct(
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
        isLab: deserializeParam(
          data['isLab'],
          ParamType.bool,
          false,
        ),
      );

  static CourseTypeStruct fromAlgoliaData(Map<String, dynamic> data) =>
      CourseTypeStruct(
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
  String toString() => 'CourseTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CourseTypeStruct &&
        courseType == other.courseType &&
        electiveCategory == other.electiveCategory &&
        isLab == other.isLab;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([courseType, electiveCategory, isLab]);
}

CourseTypeStruct createCourseTypeStruct({
  String? courseType,
  String? electiveCategory,
  bool? isLab,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CourseTypeStruct(
      courseType: courseType,
      electiveCategory: electiveCategory,
      isLab: isLab,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CourseTypeStruct? updateCourseTypeStruct(
  CourseTypeStruct? courseTypeStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    courseTypeStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCourseTypeStructData(
  Map<String, dynamic> firestoreData,
  CourseTypeStruct? courseTypeStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (courseTypeStruct == null) {
    return;
  }
  if (courseTypeStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && courseTypeStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final courseTypeStructData =
      getCourseTypeFirestoreData(courseTypeStruct, forFieldValue);
  final nestedData =
      courseTypeStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = courseTypeStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCourseTypeFirestoreData(
  CourseTypeStruct? courseTypeStruct, [
  bool forFieldValue = false,
]) {
  if (courseTypeStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(courseTypeStruct.toMap());

  // Add any Firestore field values
  courseTypeStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCourseTypeListFirestoreData(
  List<CourseTypeStruct>? courseTypeStructs,
) =>
    courseTypeStructs
        ?.map((e) => getCourseTypeFirestoreData(e, true))
        .toList() ??
    [];
