// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserGreetingMessageStruct extends FFFirebaseStruct {
  UserGreetingMessageStruct({
    String? primaryMessage,
    String? secondaryMessage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _primaryMessage = primaryMessage,
        _secondaryMessage = secondaryMessage,
        super(firestoreUtilData);

  // "primaryMessage" field.
  String? _primaryMessage;
  String get primaryMessage => _primaryMessage ?? '';
  set primaryMessage(String? val) => _primaryMessage = val;

  bool hasPrimaryMessage() => _primaryMessage != null;

  // "secondaryMessage" field.
  String? _secondaryMessage;
  String get secondaryMessage => _secondaryMessage ?? '';
  set secondaryMessage(String? val) => _secondaryMessage = val;

  bool hasSecondaryMessage() => _secondaryMessage != null;

  static UserGreetingMessageStruct fromMap(Map<String, dynamic> data) =>
      UserGreetingMessageStruct(
        primaryMessage: data['primaryMessage'] as String?,
        secondaryMessage: data['secondaryMessage'] as String?,
      );

  static UserGreetingMessageStruct? maybeFromMap(dynamic data) => data is Map
      ? UserGreetingMessageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'primaryMessage': _primaryMessage,
        'secondaryMessage': _secondaryMessage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'primaryMessage': serializeParam(
          _primaryMessage,
          ParamType.String,
        ),
        'secondaryMessage': serializeParam(
          _secondaryMessage,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserGreetingMessageStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      UserGreetingMessageStruct(
        primaryMessage: deserializeParam(
          data['primaryMessage'],
          ParamType.String,
          false,
        ),
        secondaryMessage: deserializeParam(
          data['secondaryMessage'],
          ParamType.String,
          false,
        ),
      );

  static UserGreetingMessageStruct fromAlgoliaData(Map<String, dynamic> data) =>
      UserGreetingMessageStruct(
        primaryMessage: convertAlgoliaParam(
          data['primaryMessage'],
          ParamType.String,
          false,
        ),
        secondaryMessage: convertAlgoliaParam(
          data['secondaryMessage'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'UserGreetingMessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserGreetingMessageStruct &&
        primaryMessage == other.primaryMessage &&
        secondaryMessage == other.secondaryMessage;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([primaryMessage, secondaryMessage]);
}

UserGreetingMessageStruct createUserGreetingMessageStruct({
  String? primaryMessage,
  String? secondaryMessage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserGreetingMessageStruct(
      primaryMessage: primaryMessage,
      secondaryMessage: secondaryMessage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserGreetingMessageStruct? updateUserGreetingMessageStruct(
  UserGreetingMessageStruct? userGreetingMessage, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userGreetingMessage
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserGreetingMessageStructData(
  Map<String, dynamic> firestoreData,
  UserGreetingMessageStruct? userGreetingMessage,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userGreetingMessage == null) {
    return;
  }
  if (userGreetingMessage.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userGreetingMessage.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userGreetingMessageData =
      getUserGreetingMessageFirestoreData(userGreetingMessage, forFieldValue);
  final nestedData =
      userGreetingMessageData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      userGreetingMessage.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserGreetingMessageFirestoreData(
  UserGreetingMessageStruct? userGreetingMessage, [
  bool forFieldValue = false,
]) {
  if (userGreetingMessage == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userGreetingMessage.toMap());

  // Add any Firestore field values
  userGreetingMessage.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserGreetingMessageListFirestoreData(
  List<UserGreetingMessageStruct>? userGreetingMessages,
) =>
    userGreetingMessages
        ?.map((e) => getUserGreetingMessageFirestoreData(e, true))
        .toList() ??
    [];
