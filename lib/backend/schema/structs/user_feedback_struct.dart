// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserFeedbackStruct extends FFFirebaseStruct {
  UserFeedbackStruct({
    String? status,
    String? message,
    int? amplixDiff,
    bool? fullDayAttendance,
    int? attendedClasses,
    int? totalClasses,
    List<String>? attendedClassIds,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _message = message,
        _amplixDiff = amplixDiff,
        _fullDayAttendance = fullDayAttendance,
        _attendedClasses = attendedClasses,
        _totalClasses = totalClasses,
        _attendedClassIds = attendedClassIds,
        super(firestoreUtilData);

  // "status" field.
  String? _status;
  String get status => _status ?? 'error';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "message" field.
  String? _message;
  String get message =>
      _message ??
      'Oops! Some required information seems to be missing. Please refresh and try again.';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "amplixDiff" field.
  int? _amplixDiff;
  int get amplixDiff => _amplixDiff ?? 0;
  set amplixDiff(int? val) => _amplixDiff = val;

  void incrementAmplixDiff(int amount) => amplixDiff = amplixDiff + amount;

  bool hasAmplixDiff() => _amplixDiff != null;

  // "fullDayAttendance" field.
  bool? _fullDayAttendance;
  bool get fullDayAttendance => _fullDayAttendance ?? false;
  set fullDayAttendance(bool? val) => _fullDayAttendance = val;

  bool hasFullDayAttendance() => _fullDayAttendance != null;

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

  // "attendedClassIds" field.
  List<String>? _attendedClassIds;
  List<String> get attendedClassIds => _attendedClassIds ?? const [];
  set attendedClassIds(List<String>? val) => _attendedClassIds = val;

  void updateAttendedClassIds(Function(List<String>) updateFn) {
    updateFn(_attendedClassIds ??= []);
  }

  bool hasAttendedClassIds() => _attendedClassIds != null;

  static UserFeedbackStruct fromMap(Map<String, dynamic> data) =>
      UserFeedbackStruct(
        status: data['status'] as String?,
        message: data['message'] as String?,
        amplixDiff: castToType<int>(data['amplixDiff']),
        fullDayAttendance: data['fullDayAttendance'] as bool?,
        attendedClasses: castToType<int>(data['attendedClasses']),
        totalClasses: castToType<int>(data['totalClasses']),
        attendedClassIds: getDataList(data['attendedClassIds']),
      );

  static UserFeedbackStruct? maybeFromMap(dynamic data) => data is Map
      ? UserFeedbackStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'message': _message,
        'amplixDiff': _amplixDiff,
        'fullDayAttendance': _fullDayAttendance,
        'attendedClasses': _attendedClasses,
        'totalClasses': _totalClasses,
        'attendedClassIds': _attendedClassIds,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'amplixDiff': serializeParam(
          _amplixDiff,
          ParamType.int,
        ),
        'fullDayAttendance': serializeParam(
          _fullDayAttendance,
          ParamType.bool,
        ),
        'attendedClasses': serializeParam(
          _attendedClasses,
          ParamType.int,
        ),
        'totalClasses': serializeParam(
          _totalClasses,
          ParamType.int,
        ),
        'attendedClassIds': serializeParam(
          _attendedClassIds,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static UserFeedbackStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserFeedbackStruct(
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        amplixDiff: deserializeParam(
          data['amplixDiff'],
          ParamType.int,
          false,
        ),
        fullDayAttendance: deserializeParam(
          data['fullDayAttendance'],
          ParamType.bool,
          false,
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
        attendedClassIds: deserializeParam<String>(
          data['attendedClassIds'],
          ParamType.String,
          true,
        ),
      );

  static UserFeedbackStruct fromAlgoliaData(Map<String, dynamic> data) =>
      UserFeedbackStruct(
        status: convertAlgoliaParam(
          data['status'],
          ParamType.String,
          false,
        ),
        message: convertAlgoliaParam(
          data['message'],
          ParamType.String,
          false,
        ),
        amplixDiff: convertAlgoliaParam(
          data['amplixDiff'],
          ParamType.int,
          false,
        ),
        fullDayAttendance: convertAlgoliaParam(
          data['fullDayAttendance'],
          ParamType.bool,
          false,
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
        attendedClassIds: convertAlgoliaParam<String>(
          data['attendedClassIds'],
          ParamType.String,
          true,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'UserFeedbackStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UserFeedbackStruct &&
        status == other.status &&
        message == other.message &&
        amplixDiff == other.amplixDiff &&
        fullDayAttendance == other.fullDayAttendance &&
        attendedClasses == other.attendedClasses &&
        totalClasses == other.totalClasses &&
        listEquality.equals(attendedClassIds, other.attendedClassIds);
  }

  @override
  int get hashCode => const ListEquality().hash([
        status,
        message,
        amplixDiff,
        fullDayAttendance,
        attendedClasses,
        totalClasses,
        attendedClassIds
      ]);
}

UserFeedbackStruct createUserFeedbackStruct({
  String? status,
  String? message,
  int? amplixDiff,
  bool? fullDayAttendance,
  int? attendedClasses,
  int? totalClasses,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserFeedbackStruct(
      status: status,
      message: message,
      amplixDiff: amplixDiff,
      fullDayAttendance: fullDayAttendance,
      attendedClasses: attendedClasses,
      totalClasses: totalClasses,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserFeedbackStruct? updateUserFeedbackStruct(
  UserFeedbackStruct? userFeedback, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userFeedback
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserFeedbackStructData(
  Map<String, dynamic> firestoreData,
  UserFeedbackStruct? userFeedback,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userFeedback == null) {
    return;
  }
  if (userFeedback.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userFeedback.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userFeedbackData =
      getUserFeedbackFirestoreData(userFeedback, forFieldValue);
  final nestedData =
      userFeedbackData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userFeedback.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserFeedbackFirestoreData(
  UserFeedbackStruct? userFeedback, [
  bool forFieldValue = false,
]) {
  if (userFeedback == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userFeedback.toMap());

  // Add any Firestore field values
  userFeedback.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserFeedbackListFirestoreData(
  List<UserFeedbackStruct>? userFeedbacks,
) =>
    userFeedbacks?.map((e) => getUserFeedbackFirestoreData(e, true)).toList() ??
    [];
