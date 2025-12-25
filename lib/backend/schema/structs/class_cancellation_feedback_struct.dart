// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ClassCancellationFeedbackStruct extends FFFirebaseStruct {
  ClassCancellationFeedbackStruct({
    String? status,
    String? message,
    int? affectedUsersCount,
    int? totalAmplixDeducted,
    bool? hasErrors,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _message = message,
        _affectedUsersCount = affectedUsersCount,
        _totalAmplixDeducted = totalAmplixDeducted,
        _hasErrors = hasErrors,
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

  // "affectedUsersCount" field.
  int? _affectedUsersCount;
  int get affectedUsersCount => _affectedUsersCount ?? 0;
  set affectedUsersCount(int? val) => _affectedUsersCount = val;

  void incrementAffectedUsersCount(int amount) =>
      affectedUsersCount = affectedUsersCount + amount;

  bool hasAffectedUsersCount() => _affectedUsersCount != null;

  // "totalAmplixDeducted" field.
  int? _totalAmplixDeducted;
  int get totalAmplixDeducted => _totalAmplixDeducted ?? 0;
  set totalAmplixDeducted(int? val) => _totalAmplixDeducted = val;

  void incrementTotalAmplixDeducted(int amount) =>
      totalAmplixDeducted = totalAmplixDeducted + amount;

  bool hasTotalAmplixDeducted() => _totalAmplixDeducted != null;

  // "hasErrors" field.
  bool? _hasErrors;
  bool get hasErrors => _hasErrors ?? false;
  set hasErrors(bool? val) => _hasErrors = val;

  bool hasHasErrors() => _hasErrors != null;

  static ClassCancellationFeedbackStruct fromMap(Map<String, dynamic> data) =>
      ClassCancellationFeedbackStruct(
        status: data['status'] as String?,
        message: data['message'] as String?,
        affectedUsersCount: castToType<int>(data['affectedUsersCount']),
        totalAmplixDeducted: castToType<int>(data['totalAmplixDeducted']),
        hasErrors: data['hasErrors'] as bool?,
      );

  static ClassCancellationFeedbackStruct? maybeFromMap(dynamic data) => data
          is Map
      ? ClassCancellationFeedbackStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'message': _message,
        'affectedUsersCount': _affectedUsersCount,
        'totalAmplixDeducted': _totalAmplixDeducted,
        'hasErrors': _hasErrors,
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
        'affectedUsersCount': serializeParam(
          _affectedUsersCount,
          ParamType.int,
        ),
        'totalAmplixDeducted': serializeParam(
          _totalAmplixDeducted,
          ParamType.int,
        ),
        'hasErrors': serializeParam(
          _hasErrors,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ClassCancellationFeedbackStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClassCancellationFeedbackStruct(
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
        affectedUsersCount: deserializeParam(
          data['affectedUsersCount'],
          ParamType.int,
          false,
        ),
        totalAmplixDeducted: deserializeParam(
          data['totalAmplixDeducted'],
          ParamType.int,
          false,
        ),
        hasErrors: deserializeParam(
          data['hasErrors'],
          ParamType.bool,
          false,
        ),
      );

  static ClassCancellationFeedbackStruct fromAlgoliaData(
          Map<String, dynamic> data) =>
      ClassCancellationFeedbackStruct(
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
        affectedUsersCount: convertAlgoliaParam(
          data['affectedUsersCount'],
          ParamType.int,
          false,
        ),
        totalAmplixDeducted: convertAlgoliaParam(
          data['totalAmplixDeducted'],
          ParamType.int,
          false,
        ),
        hasErrors: convertAlgoliaParam(
          data['hasErrors'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ClassCancellationFeedbackStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClassCancellationFeedbackStruct &&
        status == other.status &&
        message == other.message &&
        affectedUsersCount == other.affectedUsersCount &&
        totalAmplixDeducted == other.totalAmplixDeducted &&
        hasErrors == other.hasErrors;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [status, message, affectedUsersCount, totalAmplixDeducted, hasErrors]);
}

ClassCancellationFeedbackStruct createClassCancellationFeedbackStruct({
  String? status,
  String? message,
  int? affectedUsersCount,
  int? totalAmplixDeducted,
  bool? hasErrors,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClassCancellationFeedbackStruct(
      status: status,
      message: message,
      affectedUsersCount: affectedUsersCount,
      totalAmplixDeducted: totalAmplixDeducted,
      hasErrors: hasErrors,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClassCancellationFeedbackStruct? updateClassCancellationFeedbackStruct(
  ClassCancellationFeedbackStruct? classCancellationFeedback, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    classCancellationFeedback
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClassCancellationFeedbackStructData(
  Map<String, dynamic> firestoreData,
  ClassCancellationFeedbackStruct? classCancellationFeedback,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (classCancellationFeedback == null) {
    return;
  }
  if (classCancellationFeedback.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      classCancellationFeedback.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final classCancellationFeedbackData =
      getClassCancellationFeedbackFirestoreData(
          classCancellationFeedback, forFieldValue);
  final nestedData =
      classCancellationFeedbackData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      classCancellationFeedback.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClassCancellationFeedbackFirestoreData(
  ClassCancellationFeedbackStruct? classCancellationFeedback, [
  bool forFieldValue = false,
]) {
  if (classCancellationFeedback == null) {
    return {};
  }
  final firestoreData = mapToFirestore(classCancellationFeedback.toMap());

  // Add any Firestore field values
  classCancellationFeedback.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClassCancellationFeedbackListFirestoreData(
  List<ClassCancellationFeedbackStruct>? classCancellationFeedbacks,
) =>
    classCancellationFeedbacks
        ?.map((e) => getClassCancellationFeedbackFirestoreData(e, true))
        .toList() ??
    [];
