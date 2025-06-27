// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserLevelMetadataStruct extends FFFirebaseStruct {
  UserLevelMetadataStruct({
    int? mageLevel,
    String? mageName,
    int? currentAmplix,
    int? nextAmplixMilestone,
    String? currentMageColor,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _mageLevel = mageLevel,
        _mageName = mageName,
        _currentAmplix = currentAmplix,
        _nextAmplixMilestone = nextAmplixMilestone,
        _currentMageColor = currentMageColor,
        super(firestoreUtilData);

  // "MageLevel" field.
  int? _mageLevel;
  int get mageLevel => _mageLevel ?? 0;
  set mageLevel(int? val) => _mageLevel = val;

  void incrementMageLevel(int amount) => mageLevel = mageLevel + amount;

  bool hasMageLevel() => _mageLevel != null;

  // "MageName" field.
  String? _mageName;
  String get mageName => _mageName ?? '';
  set mageName(String? val) => _mageName = val;

  bool hasMageName() => _mageName != null;

  // "currentAmplix" field.
  int? _currentAmplix;
  int get currentAmplix => _currentAmplix ?? 0;
  set currentAmplix(int? val) => _currentAmplix = val;

  void incrementCurrentAmplix(int amount) =>
      currentAmplix = currentAmplix + amount;

  bool hasCurrentAmplix() => _currentAmplix != null;

  // "NextAmplixMilestone" field.
  int? _nextAmplixMilestone;
  int get nextAmplixMilestone => _nextAmplixMilestone ?? 0;
  set nextAmplixMilestone(int? val) => _nextAmplixMilestone = val;

  void incrementNextAmplixMilestone(int amount) =>
      nextAmplixMilestone = nextAmplixMilestone + amount;

  bool hasNextAmplixMilestone() => _nextAmplixMilestone != null;

  // "currentMageColor" field.
  String? _currentMageColor;
  String get currentMageColor => _currentMageColor ?? '';
  set currentMageColor(String? val) => _currentMageColor = val;

  bool hasCurrentMageColor() => _currentMageColor != null;

  static UserLevelMetadataStruct fromMap(Map<String, dynamic> data) =>
      UserLevelMetadataStruct(
        mageLevel: castToType<int>(data['MageLevel']),
        mageName: data['MageName'] as String?,
        currentAmplix: castToType<int>(data['currentAmplix']),
        nextAmplixMilestone: castToType<int>(data['NextAmplixMilestone']),
        currentMageColor: data['currentMageColor'] as String?,
      );

  static UserLevelMetadataStruct? maybeFromMap(dynamic data) => data is Map
      ? UserLevelMetadataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'MageLevel': _mageLevel,
        'MageName': _mageName,
        'currentAmplix': _currentAmplix,
        'NextAmplixMilestone': _nextAmplixMilestone,
        'currentMageColor': _currentMageColor,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'MageLevel': serializeParam(
          _mageLevel,
          ParamType.int,
        ),
        'MageName': serializeParam(
          _mageName,
          ParamType.String,
        ),
        'currentAmplix': serializeParam(
          _currentAmplix,
          ParamType.int,
        ),
        'NextAmplixMilestone': serializeParam(
          _nextAmplixMilestone,
          ParamType.int,
        ),
        'currentMageColor': serializeParam(
          _currentMageColor,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserLevelMetadataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      UserLevelMetadataStruct(
        mageLevel: deserializeParam(
          data['MageLevel'],
          ParamType.int,
          false,
        ),
        mageName: deserializeParam(
          data['MageName'],
          ParamType.String,
          false,
        ),
        currentAmplix: deserializeParam(
          data['currentAmplix'],
          ParamType.int,
          false,
        ),
        nextAmplixMilestone: deserializeParam(
          data['NextAmplixMilestone'],
          ParamType.int,
          false,
        ),
        currentMageColor: deserializeParam(
          data['currentMageColor'],
          ParamType.String,
          false,
        ),
      );

  static UserLevelMetadataStruct fromAlgoliaData(Map<String, dynamic> data) =>
      UserLevelMetadataStruct(
        mageLevel: convertAlgoliaParam(
          data['MageLevel'],
          ParamType.int,
          false,
        ),
        mageName: convertAlgoliaParam(
          data['MageName'],
          ParamType.String,
          false,
        ),
        currentAmplix: convertAlgoliaParam(
          data['currentAmplix'],
          ParamType.int,
          false,
        ),
        nextAmplixMilestone: convertAlgoliaParam(
          data['NextAmplixMilestone'],
          ParamType.int,
          false,
        ),
        currentMageColor: convertAlgoliaParam(
          data['currentMageColor'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'UserLevelMetadataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserLevelMetadataStruct &&
        mageLevel == other.mageLevel &&
        mageName == other.mageName &&
        currentAmplix == other.currentAmplix &&
        nextAmplixMilestone == other.nextAmplixMilestone &&
        currentMageColor == other.currentMageColor;
  }

  @override
  int get hashCode => const ListEquality().hash([
        mageLevel,
        mageName,
        currentAmplix,
        nextAmplixMilestone,
        currentMageColor
      ]);
}

UserLevelMetadataStruct createUserLevelMetadataStruct({
  int? mageLevel,
  String? mageName,
  int? currentAmplix,
  int? nextAmplixMilestone,
  String? currentMageColor,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserLevelMetadataStruct(
      mageLevel: mageLevel,
      mageName: mageName,
      currentAmplix: currentAmplix,
      nextAmplixMilestone: nextAmplixMilestone,
      currentMageColor: currentMageColor,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserLevelMetadataStruct? updateUserLevelMetadataStruct(
  UserLevelMetadataStruct? userLevelMetadata, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userLevelMetadata
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserLevelMetadataStructData(
  Map<String, dynamic> firestoreData,
  UserLevelMetadataStruct? userLevelMetadata,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userLevelMetadata == null) {
    return;
  }
  if (userLevelMetadata.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userLevelMetadata.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userLevelMetadataData =
      getUserLevelMetadataFirestoreData(userLevelMetadata, forFieldValue);
  final nestedData =
      userLevelMetadataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userLevelMetadata.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserLevelMetadataFirestoreData(
  UserLevelMetadataStruct? userLevelMetadata, [
  bool forFieldValue = false,
]) {
  if (userLevelMetadata == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userLevelMetadata.toMap());

  // Add any Firestore field values
  userLevelMetadata.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserLevelMetadataListFirestoreData(
  List<UserLevelMetadataStruct>? userLevelMetadatas,
) =>
    userLevelMetadatas
        ?.map((e) => getUserLevelMetadataFirestoreData(e, true))
        .toList() ??
    [];
