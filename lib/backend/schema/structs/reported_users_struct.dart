// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ReportedUsersStruct extends FFFirebaseStruct {
  ReportedUsersStruct({
    String? userID,
    String? username,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userID = userID,
        _username = username,
        super(firestoreUtilData);

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  set userID(String? val) => _userID = val;

  bool hasUserID() => _userID != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  set username(String? val) => _username = val;

  bool hasUsername() => _username != null;

  static ReportedUsersStruct fromMap(Map<String, dynamic> data) =>
      ReportedUsersStruct(
        userID: data['userID'] as String?,
        username: data['username'] as String?,
      );

  static ReportedUsersStruct? maybeFromMap(dynamic data) => data is Map
      ? ReportedUsersStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userID': _userID,
        'username': _username,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userID': serializeParam(
          _userID,
          ParamType.String,
        ),
        'username': serializeParam(
          _username,
          ParamType.String,
        ),
      }.withoutNulls;

  static ReportedUsersStruct fromSerializableMap(Map<String, dynamic> data) =>
      ReportedUsersStruct(
        userID: deserializeParam(
          data['userID'],
          ParamType.String,
          false,
        ),
        username: deserializeParam(
          data['username'],
          ParamType.String,
          false,
        ),
      );

  static ReportedUsersStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ReportedUsersStruct(
        userID: convertAlgoliaParam(
          data['userID'],
          ParamType.String,
          false,
        ),
        username: convertAlgoliaParam(
          data['username'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ReportedUsersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ReportedUsersStruct &&
        userID == other.userID &&
        username == other.username;
  }

  @override
  int get hashCode => const ListEquality().hash([userID, username]);
}

ReportedUsersStruct createReportedUsersStruct({
  String? userID,
  String? username,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReportedUsersStruct(
      userID: userID,
      username: username,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReportedUsersStruct? updateReportedUsersStruct(
  ReportedUsersStruct? reportedUsers, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    reportedUsers
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReportedUsersStructData(
  Map<String, dynamic> firestoreData,
  ReportedUsersStruct? reportedUsers,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (reportedUsers == null) {
    return;
  }
  if (reportedUsers.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && reportedUsers.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final reportedUsersData =
      getReportedUsersFirestoreData(reportedUsers, forFieldValue);
  final nestedData =
      reportedUsersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = reportedUsers.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReportedUsersFirestoreData(
  ReportedUsersStruct? reportedUsers, [
  bool forFieldValue = false,
]) {
  if (reportedUsers == null) {
    return {};
  }
  final firestoreData = mapToFirestore(reportedUsers.toMap());

  // Add any Firestore field values
  reportedUsers.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getReportedUsersListFirestoreData(
  List<ReportedUsersStruct>? reportedUserss,
) =>
    reportedUserss
        ?.map((e) => getReportedUsersFirestoreData(e, true))
        .toList() ??
    [];
