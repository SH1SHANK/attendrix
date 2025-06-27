// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CoursesEnrolledStruct extends FFFirebaseStruct {
  CoursesEnrolledStruct({
    String? courseID,
    String? courseName,
    CourseTypeStruct? courseType,
    CourseFacultyStruct? courseFaculty,
    int? attendedClasses,
    int? totalClasses,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _courseID = courseID,
        _courseName = courseName,
        _courseType = courseType,
        _courseFaculty = courseFaculty,
        _attendedClasses = attendedClasses,
        _totalClasses = totalClasses,
        super(firestoreUtilData);

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

  // "courseType" field.
  CourseTypeStruct? _courseType;
  CourseTypeStruct get courseType => _courseType ?? CourseTypeStruct();
  set courseType(CourseTypeStruct? val) => _courseType = val;

  void updateCourseType(Function(CourseTypeStruct) updateFn) {
    updateFn(_courseType ??= CourseTypeStruct());
  }

  bool hasCourseType() => _courseType != null;

  // "courseFaculty" field.
  CourseFacultyStruct? _courseFaculty;
  CourseFacultyStruct get courseFaculty =>
      _courseFaculty ?? CourseFacultyStruct();
  set courseFaculty(CourseFacultyStruct? val) => _courseFaculty = val;

  void updateCourseFaculty(Function(CourseFacultyStruct) updateFn) {
    updateFn(_courseFaculty ??= CourseFacultyStruct());
  }

  bool hasCourseFaculty() => _courseFaculty != null;

  // "attendedClasses" field.
  int? _attendedClasses;
  int get attendedClasses => _attendedClasses ?? 0;
  set attendedClasses(int? val) => _attendedClasses = val;

  void incrementAttendedClasses(int amount) =>
      attendedClasses = attendedClasses + amount;

  bool hasAttendedClasses() => _attendedClasses != null;

  // "totalClasses" field.
  int? _totalClasses;
  int get totalClasses => _totalClasses ?? 0;
  set totalClasses(int? val) => _totalClasses = val;

  void incrementTotalClasses(int amount) =>
      totalClasses = totalClasses + amount;

  bool hasTotalClasses() => _totalClasses != null;

  static CoursesEnrolledStruct fromMap(Map<String, dynamic> data) =>
      CoursesEnrolledStruct(
        courseID: data['courseID'] as String?,
        courseName: data['courseName'] as String?,
        courseType: data['courseType'] is CourseTypeStruct
            ? data['courseType']
            : CourseTypeStruct.maybeFromMap(data['courseType']),
        courseFaculty: data['courseFaculty'] is CourseFacultyStruct
            ? data['courseFaculty']
            : CourseFacultyStruct.maybeFromMap(data['courseFaculty']),
        attendedClasses: castToType<int>(data['attendedClasses']),
        totalClasses: castToType<int>(data['totalClasses']),
      );

  static CoursesEnrolledStruct? maybeFromMap(dynamic data) => data is Map
      ? CoursesEnrolledStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'courseID': _courseID,
        'courseName': _courseName,
        'courseType': _courseType?.toMap(),
        'courseFaculty': _courseFaculty?.toMap(),
        'attendedClasses': _attendedClasses,
        'totalClasses': _totalClasses,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'courseID': serializeParam(
          _courseID,
          ParamType.String,
        ),
        'courseName': serializeParam(
          _courseName,
          ParamType.String,
        ),
        'courseType': serializeParam(
          _courseType,
          ParamType.DataStruct,
        ),
        'courseFaculty': serializeParam(
          _courseFaculty,
          ParamType.DataStruct,
        ),
        'attendedClasses': serializeParam(
          _attendedClasses,
          ParamType.int,
        ),
        'totalClasses': serializeParam(
          _totalClasses,
          ParamType.int,
        ),
      }.withoutNulls;

  static CoursesEnrolledStruct fromSerializableMap(Map<String, dynamic> data) =>
      CoursesEnrolledStruct(
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
        courseType: deserializeStructParam(
          data['courseType'],
          ParamType.DataStruct,
          false,
          structBuilder: CourseTypeStruct.fromSerializableMap,
        ),
        courseFaculty: deserializeStructParam(
          data['courseFaculty'],
          ParamType.DataStruct,
          false,
          structBuilder: CourseFacultyStruct.fromSerializableMap,
        ),
        attendedClasses: deserializeParam(
          data['attendedClasses'],
          ParamType.int,
          false,
        ),
        totalClasses: deserializeParam(
          data['totalClasses'],
          ParamType.int,
          false,
        ),
      );

  static CoursesEnrolledStruct fromAlgoliaData(Map<String, dynamic> data) =>
      CoursesEnrolledStruct(
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
        courseType: convertAlgoliaParam(
          data['courseType'],
          ParamType.DataStruct,
          false,
          structBuilder: CourseTypeStruct.fromAlgoliaData,
        ),
        courseFaculty: convertAlgoliaParam(
          data['courseFaculty'],
          ParamType.DataStruct,
          false,
          structBuilder: CourseFacultyStruct.fromAlgoliaData,
        ),
        attendedClasses: convertAlgoliaParam(
          data['attendedClasses'],
          ParamType.int,
          false,
        ),
        totalClasses: convertAlgoliaParam(
          data['totalClasses'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'CoursesEnrolledStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CoursesEnrolledStruct &&
        courseID == other.courseID &&
        courseName == other.courseName &&
        courseType == other.courseType &&
        courseFaculty == other.courseFaculty &&
        attendedClasses == other.attendedClasses &&
        totalClasses == other.totalClasses;
  }

  @override
  int get hashCode => const ListEquality().hash([
        courseID,
        courseName,
        courseType,
        courseFaculty,
        attendedClasses,
        totalClasses
      ]);
}

CoursesEnrolledStruct createCoursesEnrolledStruct({
  String? courseID,
  String? courseName,
  CourseTypeStruct? courseType,
  CourseFacultyStruct? courseFaculty,
  int? attendedClasses,
  int? totalClasses,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CoursesEnrolledStruct(
      courseID: courseID,
      courseName: courseName,
      courseType: courseType ?? (clearUnsetFields ? CourseTypeStruct() : null),
      courseFaculty:
          courseFaculty ?? (clearUnsetFields ? CourseFacultyStruct() : null),
      attendedClasses: attendedClasses,
      totalClasses: totalClasses,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CoursesEnrolledStruct? updateCoursesEnrolledStruct(
  CoursesEnrolledStruct? coursesEnrolled, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    coursesEnrolled
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCoursesEnrolledStructData(
  Map<String, dynamic> firestoreData,
  CoursesEnrolledStruct? coursesEnrolled,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (coursesEnrolled == null) {
    return;
  }
  if (coursesEnrolled.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && coursesEnrolled.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final coursesEnrolledData =
      getCoursesEnrolledFirestoreData(coursesEnrolled, forFieldValue);
  final nestedData =
      coursesEnrolledData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = coursesEnrolled.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCoursesEnrolledFirestoreData(
  CoursesEnrolledStruct? coursesEnrolled, [
  bool forFieldValue = false,
]) {
  if (coursesEnrolled == null) {
    return {};
  }
  final firestoreData = mapToFirestore(coursesEnrolled.toMap());

  // Handle nested data for "courseType" field.
  addCourseTypeStructData(
    firestoreData,
    coursesEnrolled.hasCourseType() ? coursesEnrolled.courseType : null,
    'courseType',
    forFieldValue,
  );

  // Handle nested data for "courseFaculty" field.
  addCourseFacultyStructData(
    firestoreData,
    coursesEnrolled.hasCourseFaculty() ? coursesEnrolled.courseFaculty : null,
    'courseFaculty',
    forFieldValue,
  );

  // Add any Firestore field values
  coursesEnrolled.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCoursesEnrolledListFirestoreData(
  List<CoursesEnrolledStruct>? coursesEnrolleds,
) =>
    coursesEnrolleds
        ?.map((e) => getCoursesEnrolledFirestoreData(e, true))
        .toList() ??
    [];
