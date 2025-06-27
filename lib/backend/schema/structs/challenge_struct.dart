// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ChallengeStruct extends FFFirebaseStruct {
  ChallengeStruct({
    String? progressID,
    String? challengeID,
    String? challengeName,
    String? challengeDescription,
    String? challengeCondition,
    String? challengeKey,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _progressID = progressID,
        _challengeID = challengeID,
        _challengeName = challengeName,
        _challengeDescription = challengeDescription,
        _challengeCondition = challengeCondition,
        _challengeKey = challengeKey,
        super(firestoreUtilData);

  // "progressID" field.
  String? _progressID;
  String get progressID => _progressID ?? '';
  set progressID(String? val) => _progressID = val;

  bool hasProgressID() => _progressID != null;

  // "challengeID" field.
  String? _challengeID;
  String get challengeID => _challengeID ?? 'W0W';
  set challengeID(String? val) => _challengeID = val;

  bool hasChallengeID() => _challengeID != null;

  // "challengeName" field.
  String? _challengeName;
  String get challengeName => _challengeName ?? '';
  set challengeName(String? val) => _challengeName = val;

  bool hasChallengeName() => _challengeName != null;

  // "challengeDescription" field.
  String? _challengeDescription;
  String get challengeDescription => _challengeDescription ?? '';
  set challengeDescription(String? val) => _challengeDescription = val;

  bool hasChallengeDescription() => _challengeDescription != null;

  // "challengeCondition" field.
  String? _challengeCondition;
  String get challengeCondition => _challengeCondition ?? 'invalid';
  set challengeCondition(String? val) => _challengeCondition = val;

  bool hasChallengeCondition() => _challengeCondition != null;

  // "challengeKey" field.
  String? _challengeKey;
  String get challengeKey => _challengeKey ?? '0524-W0W';
  set challengeKey(String? val) => _challengeKey = val;

  bool hasChallengeKey() => _challengeKey != null;

  static ChallengeStruct fromMap(Map<String, dynamic> data) => ChallengeStruct(
        progressID: data['progressID'] as String?,
        challengeID: data['challengeID'] as String?,
        challengeName: data['challengeName'] as String?,
        challengeDescription: data['challengeDescription'] as String?,
        challengeCondition: data['challengeCondition'] as String?,
        challengeKey: data['challengeKey'] as String?,
      );

  static ChallengeStruct? maybeFromMap(dynamic data) => data is Map
      ? ChallengeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'progressID': _progressID,
        'challengeID': _challengeID,
        'challengeName': _challengeName,
        'challengeDescription': _challengeDescription,
        'challengeCondition': _challengeCondition,
        'challengeKey': _challengeKey,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'progressID': serializeParam(
          _progressID,
          ParamType.String,
        ),
        'challengeID': serializeParam(
          _challengeID,
          ParamType.String,
        ),
        'challengeName': serializeParam(
          _challengeName,
          ParamType.String,
        ),
        'challengeDescription': serializeParam(
          _challengeDescription,
          ParamType.String,
        ),
        'challengeCondition': serializeParam(
          _challengeCondition,
          ParamType.String,
        ),
        'challengeKey': serializeParam(
          _challengeKey,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChallengeStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChallengeStruct(
        progressID: deserializeParam(
          data['progressID'],
          ParamType.String,
          false,
        ),
        challengeID: deserializeParam(
          data['challengeID'],
          ParamType.String,
          false,
        ),
        challengeName: deserializeParam(
          data['challengeName'],
          ParamType.String,
          false,
        ),
        challengeDescription: deserializeParam(
          data['challengeDescription'],
          ParamType.String,
          false,
        ),
        challengeCondition: deserializeParam(
          data['challengeCondition'],
          ParamType.String,
          false,
        ),
        challengeKey: deserializeParam(
          data['challengeKey'],
          ParamType.String,
          false,
        ),
      );

  static ChallengeStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ChallengeStruct(
        progressID: convertAlgoliaParam(
          data['progressID'],
          ParamType.String,
          false,
        ),
        challengeID: convertAlgoliaParam(
          data['challengeID'],
          ParamType.String,
          false,
        ),
        challengeName: convertAlgoliaParam(
          data['challengeName'],
          ParamType.String,
          false,
        ),
        challengeDescription: convertAlgoliaParam(
          data['challengeDescription'],
          ParamType.String,
          false,
        ),
        challengeCondition: convertAlgoliaParam(
          data['challengeCondition'],
          ParamType.String,
          false,
        ),
        challengeKey: convertAlgoliaParam(
          data['challengeKey'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ChallengeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChallengeStruct &&
        progressID == other.progressID &&
        challengeID == other.challengeID &&
        challengeName == other.challengeName &&
        challengeDescription == other.challengeDescription &&
        challengeCondition == other.challengeCondition &&
        challengeKey == other.challengeKey;
  }

  @override
  int get hashCode => const ListEquality().hash([
        progressID,
        challengeID,
        challengeName,
        challengeDescription,
        challengeCondition,
        challengeKey
      ]);
}

ChallengeStruct createChallengeStruct({
  String? progressID,
  String? challengeID,
  String? challengeName,
  String? challengeDescription,
  String? challengeCondition,
  String? challengeKey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChallengeStruct(
      progressID: progressID,
      challengeID: challengeID,
      challengeName: challengeName,
      challengeDescription: challengeDescription,
      challengeCondition: challengeCondition,
      challengeKey: challengeKey,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChallengeStruct? updateChallengeStruct(
  ChallengeStruct? challenge, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    challenge
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChallengeStructData(
  Map<String, dynamic> firestoreData,
  ChallengeStruct? challenge,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (challenge == null) {
    return;
  }
  if (challenge.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && challenge.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final challengeData = getChallengeFirestoreData(challenge, forFieldValue);
  final nestedData = challengeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = challenge.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChallengeFirestoreData(
  ChallengeStruct? challenge, [
  bool forFieldValue = false,
]) {
  if (challenge == null) {
    return {};
  }
  final firestoreData = mapToFirestore(challenge.toMap());

  // Add any Firestore field values
  challenge.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChallengeListFirestoreData(
  List<ChallengeStruct>? challenges,
) =>
    challenges?.map((e) => getChallengeFirestoreData(e, true)).toList() ?? [];
