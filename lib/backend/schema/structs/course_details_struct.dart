// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CourseDetailsStruct extends FFFirebaseStruct {
  CourseDetailsStruct({
    String? courseID,
    int? credits,
    int? gradeSelected,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _courseID = courseID,
        _credits = credits,
        _gradeSelected = gradeSelected,
        super(firestoreUtilData);

  // "courseID" field.
  String? _courseID;
  String get courseID => _courseID ?? '';
  set courseID(String? val) => _courseID = val;

  bool hasCourseID() => _courseID != null;

  // "credits" field.
  int? _credits;
  int get credits => _credits ?? 0;
  set credits(int? val) => _credits = val;

  void incrementCredits(int amount) => credits = credits + amount;

  bool hasCredits() => _credits != null;

  // "gradeSelected" field.
  int? _gradeSelected;
  int get gradeSelected => _gradeSelected ?? 0;
  set gradeSelected(int? val) => _gradeSelected = val;

  void incrementGradeSelected(int amount) =>
      gradeSelected = gradeSelected + amount;

  bool hasGradeSelected() => _gradeSelected != null;

  static CourseDetailsStruct fromMap(Map<String, dynamic> data) =>
      CourseDetailsStruct(
        courseID: data['courseID'] as String?,
        credits: castToType<int>(data['credits']),
        gradeSelected: castToType<int>(data['gradeSelected']),
      );

  static CourseDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? CourseDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'courseID': _courseID,
        'credits': _credits,
        'gradeSelected': _gradeSelected,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'courseID': serializeParam(
          _courseID,
          ParamType.String,
        ),
        'credits': serializeParam(
          _credits,
          ParamType.int,
        ),
        'gradeSelected': serializeParam(
          _gradeSelected,
          ParamType.int,
        ),
      }.withoutNulls;

  static CourseDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      CourseDetailsStruct(
        courseID: deserializeParam(
          data['courseID'],
          ParamType.String,
          false,
        ),
        credits: deserializeParam(
          data['credits'],
          ParamType.int,
          false,
        ),
        gradeSelected: deserializeParam(
          data['gradeSelected'],
          ParamType.int,
          false,
        ),
      );

  static CourseDetailsStruct fromAlgoliaData(Map<String, dynamic> data) =>
      CourseDetailsStruct(
        courseID: convertAlgoliaParam(
          data['courseID'],
          ParamType.String,
          false,
        ),
        credits: convertAlgoliaParam(
          data['credits'],
          ParamType.int,
          false,
        ),
        gradeSelected: convertAlgoliaParam(
          data['gradeSelected'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'CourseDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CourseDetailsStruct &&
        courseID == other.courseID &&
        credits == other.credits &&
        gradeSelected == other.gradeSelected;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([courseID, credits, gradeSelected]);
}

CourseDetailsStruct createCourseDetailsStruct({
  String? courseID,
  int? credits,
  int? gradeSelected,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CourseDetailsStruct(
      courseID: courseID,
      credits: credits,
      gradeSelected: gradeSelected,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CourseDetailsStruct? updateCourseDetailsStruct(
  CourseDetailsStruct? courseDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    courseDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCourseDetailsStructData(
  Map<String, dynamic> firestoreData,
  CourseDetailsStruct? courseDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (courseDetails == null) {
    return;
  }
  if (courseDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && courseDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final courseDetailsData =
      getCourseDetailsFirestoreData(courseDetails, forFieldValue);
  final nestedData =
      courseDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = courseDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCourseDetailsFirestoreData(
  CourseDetailsStruct? courseDetails, [
  bool forFieldValue = false,
]) {
  if (courseDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(courseDetails.toMap());

  // Add any Firestore field values
  courseDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCourseDetailsListFirestoreData(
  List<CourseDetailsStruct>? courseDetailss,
) =>
    courseDetailss
        ?.map((e) => getCourseDetailsFirestoreData(e, true))
        .toList() ??
    [];
