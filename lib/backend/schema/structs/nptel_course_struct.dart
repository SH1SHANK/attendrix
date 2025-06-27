// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NptelCourseStruct extends FFFirebaseStruct {
  NptelCourseStruct({
    String? courseID,
    String? semesterID,
    String? courseName,
    int? credits,
    String? syllabusAssets,
    String? courseFaculty,
    CourseType2Struct? courseType,
    bool? isElective,
    List<String>? electiveScope,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _courseID = courseID,
        _semesterID = semesterID,
        _courseName = courseName,
        _credits = credits,
        _syllabusAssets = syllabusAssets,
        _courseFaculty = courseFaculty,
        _courseType = courseType,
        _isElective = isElective,
        _electiveScope = electiveScope,
        super(firestoreUtilData);

  // "courseID" field.
  String? _courseID;
  String get courseID => _courseID ?? '';
  set courseID(String? val) => _courseID = val;

  bool hasCourseID() => _courseID != null;

  // "semesterID" field.
  String? _semesterID;
  String get semesterID => _semesterID ?? '';
  set semesterID(String? val) => _semesterID = val;

  bool hasSemesterID() => _semesterID != null;

  // "courseName" field.
  String? _courseName;
  String get courseName => _courseName ?? '';
  set courseName(String? val) => _courseName = val;

  bool hasCourseName() => _courseName != null;

  // "credits" field.
  int? _credits;
  int get credits => _credits ?? 0;
  set credits(int? val) => _credits = val;

  void incrementCredits(int amount) => credits = credits + amount;

  bool hasCredits() => _credits != null;

  // "syllabusAssets" field.
  String? _syllabusAssets;
  String get syllabusAssets => _syllabusAssets ?? '';
  set syllabusAssets(String? val) => _syllabusAssets = val;

  bool hasSyllabusAssets() => _syllabusAssets != null;

  // "courseFaculty" field.
  String? _courseFaculty;
  String get courseFaculty => _courseFaculty ?? '';
  set courseFaculty(String? val) => _courseFaculty = val;

  bool hasCourseFaculty() => _courseFaculty != null;

  // "courseType" field.
  CourseType2Struct? _courseType;
  CourseType2Struct get courseType => _courseType ?? CourseType2Struct();
  set courseType(CourseType2Struct? val) => _courseType = val;

  void updateCourseType(Function(CourseType2Struct) updateFn) {
    updateFn(_courseType ??= CourseType2Struct());
  }

  bool hasCourseType() => _courseType != null;

  // "isElective" field.
  bool? _isElective;
  bool get isElective => _isElective ?? false;
  set isElective(bool? val) => _isElective = val;

  bool hasIsElective() => _isElective != null;

  // "electiveScope" field.
  List<String>? _electiveScope;
  List<String> get electiveScope => _electiveScope ?? const [];
  set electiveScope(List<String>? val) => _electiveScope = val;

  void updateElectiveScope(Function(List<String>) updateFn) {
    updateFn(_electiveScope ??= []);
  }

  bool hasElectiveScope() => _electiveScope != null;

  static NptelCourseStruct fromMap(Map<String, dynamic> data) =>
      NptelCourseStruct(
        courseID: data['courseID'] as String?,
        semesterID: data['semesterID'] as String?,
        courseName: data['courseName'] as String?,
        credits: castToType<int>(data['credits']),
        syllabusAssets: data['syllabusAssets'] as String?,
        courseFaculty: data['courseFaculty'] as String?,
        courseType: data['courseType'] is CourseType2Struct
            ? data['courseType']
            : CourseType2Struct.maybeFromMap(data['courseType']),
        isElective: data['isElective'] as bool?,
        electiveScope: getDataList(data['electiveScope']),
      );

  static NptelCourseStruct? maybeFromMap(dynamic data) => data is Map
      ? NptelCourseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'courseID': _courseID,
        'semesterID': _semesterID,
        'courseName': _courseName,
        'credits': _credits,
        'syllabusAssets': _syllabusAssets,
        'courseFaculty': _courseFaculty,
        'courseType': _courseType?.toMap(),
        'isElective': _isElective,
        'electiveScope': _electiveScope,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'courseID': serializeParam(
          _courseID,
          ParamType.String,
        ),
        'semesterID': serializeParam(
          _semesterID,
          ParamType.String,
        ),
        'courseName': serializeParam(
          _courseName,
          ParamType.String,
        ),
        'credits': serializeParam(
          _credits,
          ParamType.int,
        ),
        'syllabusAssets': serializeParam(
          _syllabusAssets,
          ParamType.String,
        ),
        'courseFaculty': serializeParam(
          _courseFaculty,
          ParamType.String,
        ),
        'courseType': serializeParam(
          _courseType,
          ParamType.DataStruct,
        ),
        'isElective': serializeParam(
          _isElective,
          ParamType.bool,
        ),
        'electiveScope': serializeParam(
          _electiveScope,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static NptelCourseStruct fromSerializableMap(Map<String, dynamic> data) =>
      NptelCourseStruct(
        courseID: deserializeParam(
          data['courseID'],
          ParamType.String,
          false,
        ),
        semesterID: deserializeParam(
          data['semesterID'],
          ParamType.String,
          false,
        ),
        courseName: deserializeParam(
          data['courseName'],
          ParamType.String,
          false,
        ),
        credits: deserializeParam(
          data['credits'],
          ParamType.int,
          false,
        ),
        syllabusAssets: deserializeParam(
          data['syllabusAssets'],
          ParamType.String,
          false,
        ),
        courseFaculty: deserializeParam(
          data['courseFaculty'],
          ParamType.String,
          false,
        ),
        courseType: deserializeStructParam(
          data['courseType'],
          ParamType.DataStruct,
          false,
          structBuilder: CourseType2Struct.fromSerializableMap,
        ),
        isElective: deserializeParam(
          data['isElective'],
          ParamType.bool,
          false,
        ),
        electiveScope: deserializeParam<String>(
          data['electiveScope'],
          ParamType.String,
          true,
        ),
      );

  static NptelCourseStruct fromAlgoliaData(Map<String, dynamic> data) =>
      NptelCourseStruct(
        courseID: convertAlgoliaParam(
          data['courseID'],
          ParamType.String,
          false,
        ),
        semesterID: convertAlgoliaParam(
          data['semesterID'],
          ParamType.String,
          false,
        ),
        courseName: convertAlgoliaParam(
          data['courseName'],
          ParamType.String,
          false,
        ),
        credits: convertAlgoliaParam(
          data['credits'],
          ParamType.int,
          false,
        ),
        syllabusAssets: convertAlgoliaParam(
          data['syllabusAssets'],
          ParamType.String,
          false,
        ),
        courseFaculty: convertAlgoliaParam(
          data['courseFaculty'],
          ParamType.String,
          false,
        ),
        courseType: convertAlgoliaParam(
          data['courseType'],
          ParamType.DataStruct,
          false,
          structBuilder: CourseType2Struct.fromAlgoliaData,
        ),
        isElective: convertAlgoliaParam(
          data['isElective'],
          ParamType.bool,
          false,
        ),
        electiveScope: convertAlgoliaParam<String>(
          data['electiveScope'],
          ParamType.String,
          true,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'NptelCourseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NptelCourseStruct &&
        courseID == other.courseID &&
        semesterID == other.semesterID &&
        courseName == other.courseName &&
        credits == other.credits &&
        syllabusAssets == other.syllabusAssets &&
        courseFaculty == other.courseFaculty &&
        courseType == other.courseType &&
        isElective == other.isElective &&
        listEquality.equals(electiveScope, other.electiveScope);
  }

  @override
  int get hashCode => const ListEquality().hash([
        courseID,
        semesterID,
        courseName,
        credits,
        syllabusAssets,
        courseFaculty,
        courseType,
        isElective,
        electiveScope
      ]);
}

NptelCourseStruct createNptelCourseStruct({
  String? courseID,
  String? semesterID,
  String? courseName,
  int? credits,
  String? syllabusAssets,
  String? courseFaculty,
  CourseType2Struct? courseType,
  bool? isElective,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NptelCourseStruct(
      courseID: courseID,
      semesterID: semesterID,
      courseName: courseName,
      credits: credits,
      syllabusAssets: syllabusAssets,
      courseFaculty: courseFaculty,
      courseType: courseType ?? (clearUnsetFields ? CourseType2Struct() : null),
      isElective: isElective,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NptelCourseStruct? updateNptelCourseStruct(
  NptelCourseStruct? nptelCourse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nptelCourse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNptelCourseStructData(
  Map<String, dynamic> firestoreData,
  NptelCourseStruct? nptelCourse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nptelCourse == null) {
    return;
  }
  if (nptelCourse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nptelCourse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nptelCourseData =
      getNptelCourseFirestoreData(nptelCourse, forFieldValue);
  final nestedData =
      nptelCourseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = nptelCourse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNptelCourseFirestoreData(
  NptelCourseStruct? nptelCourse, [
  bool forFieldValue = false,
]) {
  if (nptelCourse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nptelCourse.toMap());

  // Handle nested data for "courseType" field.
  addCourseType2StructData(
    firestoreData,
    nptelCourse.hasCourseType() ? nptelCourse.courseType : null,
    'courseType',
    forFieldValue,
  );

  // Add any Firestore field values
  nptelCourse.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNptelCourseListFirestoreData(
  List<NptelCourseStruct>? nptelCourses,
) =>
    nptelCourses?.map((e) => getNptelCourseFirestoreData(e, true)).toList() ??
    [];
