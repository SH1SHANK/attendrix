// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FeedbackStruct extends FFFirebaseStruct {
  FeedbackStruct({
    String? status,
    String? message,
    String? error,
    String? details,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _message = message,
        _error = error,
        _details = details,
        super(firestoreUtilData);

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "error" field.
  String? _error;
  String get error => _error ?? '';
  set error(String? val) => _error = val;

  bool hasError() => _error != null;

  // "details" field.
  String? _details;
  String get details => _details ?? '';
  set details(String? val) => _details = val;

  bool hasDetails() => _details != null;

  static FeedbackStruct fromMap(Map<String, dynamic> data) => FeedbackStruct(
        status: data['status'] as String?,
        message: data['message'] as String?,
        error: data['error'] as String?,
        details: data['details'] as String?,
      );

  static FeedbackStruct? maybeFromMap(dynamic data) =>
      data is Map ? FeedbackStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'message': _message,
        'error': _error,
        'details': _details,
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
        'error': serializeParam(
          _error,
          ParamType.String,
        ),
        'details': serializeParam(
          _details,
          ParamType.String,
        ),
      }.withoutNulls;

  static FeedbackStruct fromSerializableMap(Map<String, dynamic> data) =>
      FeedbackStruct(
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
        error: deserializeParam(
          data['error'],
          ParamType.String,
          false,
        ),
        details: deserializeParam(
          data['details'],
          ParamType.String,
          false,
        ),
      );

  static FeedbackStruct fromAlgoliaData(Map<String, dynamic> data) =>
      FeedbackStruct(
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
        error: convertAlgoliaParam(
          data['error'],
          ParamType.String,
          false,
        ),
        details: convertAlgoliaParam(
          data['details'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'FeedbackStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FeedbackStruct &&
        status == other.status &&
        message == other.message &&
        error == other.error &&
        details == other.details;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([status, message, error, details]);
}

FeedbackStruct createFeedbackStruct({
  String? status,
  String? message,
  String? error,
  String? details,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FeedbackStruct(
      status: status,
      message: message,
      error: error,
      details: details,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FeedbackStruct? updateFeedbackStruct(
  FeedbackStruct? feedback, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    feedback
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFeedbackStructData(
  Map<String, dynamic> firestoreData,
  FeedbackStruct? feedback,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (feedback == null) {
    return;
  }
  if (feedback.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && feedback.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final feedbackData = getFeedbackFirestoreData(feedback, forFieldValue);
  final nestedData = feedbackData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = feedback.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFeedbackFirestoreData(
  FeedbackStruct? feedback, [
  bool forFieldValue = false,
]) {
  if (feedback == null) {
    return {};
  }
  final firestoreData = mapToFirestore(feedback.toMap());

  // Add any Firestore field values
  feedback.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFeedbackListFirestoreData(
  List<FeedbackStruct>? feedbacks,
) =>
    feedbacks?.map((e) => getFeedbackFirestoreData(e, true)).toList() ?? [];
