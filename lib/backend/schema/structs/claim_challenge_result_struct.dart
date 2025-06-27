// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ClaimChallengeResultStruct extends FFFirebaseStruct {
  ClaimChallengeResultStruct({
    bool? status,
    String? message,
    int? amplixReward,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _message = message,
        _amplixReward = amplixReward,
        super(firestoreUtilData);

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "amplixReward" field.
  int? _amplixReward;
  int get amplixReward => _amplixReward ?? 0;
  set amplixReward(int? val) => _amplixReward = val;

  void incrementAmplixReward(int amount) =>
      amplixReward = amplixReward + amount;

  bool hasAmplixReward() => _amplixReward != null;

  static ClaimChallengeResultStruct fromMap(Map<String, dynamic> data) =>
      ClaimChallengeResultStruct(
        status: data['status'] as bool?,
        message: data['message'] as String?,
        amplixReward: castToType<int>(data['amplixReward']),
      );

  static ClaimChallengeResultStruct? maybeFromMap(dynamic data) => data is Map
      ? ClaimChallengeResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'message': _message,
        'amplixReward': _amplixReward,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'amplixReward': serializeParam(
          _amplixReward,
          ParamType.int,
        ),
      }.withoutNulls;

  static ClaimChallengeResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClaimChallengeResultStruct(
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        amplixReward: deserializeParam(
          data['amplixReward'],
          ParamType.int,
          false,
        ),
      );

  static ClaimChallengeResultStruct fromAlgoliaData(
          Map<String, dynamic> data) =>
      ClaimChallengeResultStruct(
        status: convertAlgoliaParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        message: convertAlgoliaParam(
          data['message'],
          ParamType.String,
          false,
        ),
        amplixReward: convertAlgoliaParam(
          data['amplixReward'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ClaimChallengeResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClaimChallengeResultStruct &&
        status == other.status &&
        message == other.message &&
        amplixReward == other.amplixReward;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([status, message, amplixReward]);
}

ClaimChallengeResultStruct createClaimChallengeResultStruct({
  bool? status,
  String? message,
  int? amplixReward,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClaimChallengeResultStruct(
      status: status,
      message: message,
      amplixReward: amplixReward,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClaimChallengeResultStruct? updateClaimChallengeResultStruct(
  ClaimChallengeResultStruct? claimChallengeResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    claimChallengeResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClaimChallengeResultStructData(
  Map<String, dynamic> firestoreData,
  ClaimChallengeResultStruct? claimChallengeResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (claimChallengeResult == null) {
    return;
  }
  if (claimChallengeResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && claimChallengeResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final claimChallengeResultData =
      getClaimChallengeResultFirestoreData(claimChallengeResult, forFieldValue);
  final nestedData =
      claimChallengeResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      claimChallengeResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClaimChallengeResultFirestoreData(
  ClaimChallengeResultStruct? claimChallengeResult, [
  bool forFieldValue = false,
]) {
  if (claimChallengeResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(claimChallengeResult.toMap());

  // Add any Firestore field values
  claimChallengeResult.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClaimChallengeResultListFirestoreData(
  List<ClaimChallengeResultStruct>? claimChallengeResults,
) =>
    claimChallengeResults
        ?.map((e) => getClaimChallengeResultFirestoreData(e, true))
        .toList() ??
    [];
