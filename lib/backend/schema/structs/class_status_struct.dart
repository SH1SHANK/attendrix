// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClassStatusStruct extends FFFirebaseStruct {
  ClassStatusStruct({
    int? classCancellationScore,
    List<ReportedUsersStruct>? reportedUsers,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _classCancellationScore = classCancellationScore,
        _reportedUsers = reportedUsers,
        super(firestoreUtilData);

  // "classCancellationScore" field.
  int? _classCancellationScore;
  int get classCancellationScore => _classCancellationScore ?? 0;
  set classCancellationScore(int? val) => _classCancellationScore = val;

  void incrementClassCancellationScore(int amount) =>
      classCancellationScore = classCancellationScore + amount;

  bool hasClassCancellationScore() => _classCancellationScore != null;

  // "reportedUsers" field.
  List<ReportedUsersStruct>? _reportedUsers;
  List<ReportedUsersStruct> get reportedUsers => _reportedUsers ?? const [];
  set reportedUsers(List<ReportedUsersStruct>? val) => _reportedUsers = val;

  void updateReportedUsers(Function(List<ReportedUsersStruct>) updateFn) {
    updateFn(_reportedUsers ??= []);
  }

  bool hasReportedUsers() => _reportedUsers != null;

  static ClassStatusStruct fromMap(Map<String, dynamic> data) =>
      ClassStatusStruct(
        classCancellationScore: castToType<int>(data['classCancellationScore']),
        reportedUsers: getStructList(
          data['reportedUsers'],
          ReportedUsersStruct.fromMap,
        ),
      );

  static ClassStatusStruct? maybeFromMap(dynamic data) => data is Map
      ? ClassStatusStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'classCancellationScore': _classCancellationScore,
        'reportedUsers': _reportedUsers?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'classCancellationScore': serializeParam(
          _classCancellationScore,
          ParamType.int,
        ),
        'reportedUsers': serializeParam(
          _reportedUsers,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ClassStatusStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClassStatusStruct(
        classCancellationScore: deserializeParam(
          data['classCancellationScore'],
          ParamType.int,
          false,
        ),
        reportedUsers: deserializeStructParam<ReportedUsersStruct>(
          data['reportedUsers'],
          ParamType.DataStruct,
          true,
          structBuilder: ReportedUsersStruct.fromSerializableMap,
        ),
      );

  static ClassStatusStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ClassStatusStruct(
        classCancellationScore: convertAlgoliaParam(
          data['classCancellationScore'],
          ParamType.int,
          false,
        ),
        reportedUsers: convertAlgoliaParam<ReportedUsersStruct>(
          data['reportedUsers'],
          ParamType.DataStruct,
          true,
          structBuilder: ReportedUsersStruct.fromAlgoliaData,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ClassStatusStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ClassStatusStruct &&
        classCancellationScore == other.classCancellationScore &&
        listEquality.equals(reportedUsers, other.reportedUsers);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([classCancellationScore, reportedUsers]);
}

ClassStatusStruct createClassStatusStruct({
  int? classCancellationScore,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClassStatusStruct(
      classCancellationScore: classCancellationScore,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClassStatusStruct? updateClassStatusStruct(
  ClassStatusStruct? classStatus, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    classStatus
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClassStatusStructData(
  Map<String, dynamic> firestoreData,
  ClassStatusStruct? classStatus,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (classStatus == null) {
    return;
  }
  if (classStatus.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && classStatus.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final classStatusData =
      getClassStatusFirestoreData(classStatus, forFieldValue);
  final nestedData =
      classStatusData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = classStatus.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClassStatusFirestoreData(
  ClassStatusStruct? classStatus, [
  bool forFieldValue = false,
]) {
  if (classStatus == null) {
    return {};
  }
  final firestoreData = mapToFirestore(classStatus.toMap());

  // Add any Firestore field values
  classStatus.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClassStatusListFirestoreData(
  List<ClassStatusStruct>? classStatuss,
) =>
    classStatuss?.map((e) => getClassStatusFirestoreData(e, true)).toList() ??
    [];
