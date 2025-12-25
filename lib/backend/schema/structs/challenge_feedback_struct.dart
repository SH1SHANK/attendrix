// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ChallengeFeedbackStruct extends FFFirebaseStruct {
  ChallengeFeedbackStruct({
    bool? status,
    String? message,
    int? claimableChallengesCount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _message = message,
        _claimableChallengesCount = claimableChallengesCount,
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

  // "claimable_challenges_count" field.
  int? _claimableChallengesCount;
  int get claimableChallengesCount => _claimableChallengesCount ?? 0;
  set claimableChallengesCount(int? val) => _claimableChallengesCount = val;

  void incrementClaimableChallengesCount(int amount) =>
      claimableChallengesCount = claimableChallengesCount + amount;

  bool hasClaimableChallengesCount() => _claimableChallengesCount != null;

  static ChallengeFeedbackStruct fromMap(Map<String, dynamic> data) =>
      ChallengeFeedbackStruct(
        status: data['status'] as bool?,
        message: data['message'] as String?,
        claimableChallengesCount:
            castToType<int>(data['claimable_challenges_count']),
      );

  static ChallengeFeedbackStruct? maybeFromMap(dynamic data) => data is Map
      ? ChallengeFeedbackStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'message': _message,
        'claimable_challenges_count': _claimableChallengesCount,
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
        'claimable_challenges_count': serializeParam(
          _claimableChallengesCount,
          ParamType.int,
        ),
      }.withoutNulls;

  static ChallengeFeedbackStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ChallengeFeedbackStruct(
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
        claimableChallengesCount: deserializeParam(
          data['claimable_challenges_count'],
          ParamType.int,
          false,
        ),
      );

  static ChallengeFeedbackStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ChallengeFeedbackStruct(
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
        claimableChallengesCount: convertAlgoliaParam(
          data['claimable_challenges_count'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ChallengeFeedbackStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChallengeFeedbackStruct &&
        status == other.status &&
        message == other.message &&
        claimableChallengesCount == other.claimableChallengesCount;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([status, message, claimableChallengesCount]);
}

ChallengeFeedbackStruct createChallengeFeedbackStruct({
  bool? status,
  String? message,
  int? claimableChallengesCount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChallengeFeedbackStruct(
      status: status,
      message: message,
      claimableChallengesCount: claimableChallengesCount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChallengeFeedbackStruct? updateChallengeFeedbackStruct(
  ChallengeFeedbackStruct? challengeFeedback, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    challengeFeedback
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChallengeFeedbackStructData(
  Map<String, dynamic> firestoreData,
  ChallengeFeedbackStruct? challengeFeedback,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (challengeFeedback == null) {
    return;
  }
  if (challengeFeedback.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && challengeFeedback.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final challengeFeedbackData =
      getChallengeFeedbackFirestoreData(challengeFeedback, forFieldValue);
  final nestedData =
      challengeFeedbackData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = challengeFeedback.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChallengeFeedbackFirestoreData(
  ChallengeFeedbackStruct? challengeFeedback, [
  bool forFieldValue = false,
]) {
  if (challengeFeedback == null) {
    return {};
  }
  final firestoreData = mapToFirestore(challengeFeedback.toMap());

  // Add any Firestore field values
  challengeFeedback.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChallengeFeedbackListFirestoreData(
  List<ChallengeFeedbackStruct>? challengeFeedbacks,
) =>
    challengeFeedbacks
        ?.map((e) => getChallengeFeedbackFirestoreData(e, true))
        .toList() ??
    [];
