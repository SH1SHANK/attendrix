// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ApodAPIStruct extends FFFirebaseStruct {
  ApodAPIStruct({
    String? date,
    String? title,
    String? explanation,
    String? url,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _title = title,
        _explanation = explanation,
        _url = url,
        super(firestoreUtilData);

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "explanation" field.
  String? _explanation;
  String get explanation => _explanation ?? '';
  set explanation(String? val) => _explanation = val;

  bool hasExplanation() => _explanation != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  static ApodAPIStruct fromMap(Map<String, dynamic> data) => ApodAPIStruct(
        date: data['date'] as String?,
        title: data['title'] as String?,
        explanation: data['explanation'] as String?,
        url: data['url'] as String?,
      );

  static ApodAPIStruct? maybeFromMap(dynamic data) =>
      data is Map ? ApodAPIStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'title': _title,
        'explanation': _explanation,
        'url': _url,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'explanation': serializeParam(
          _explanation,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
      }.withoutNulls;

  static ApodAPIStruct fromSerializableMap(Map<String, dynamic> data) =>
      ApodAPIStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        explanation: deserializeParam(
          data['explanation'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
      );

  static ApodAPIStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ApodAPIStruct(
        date: convertAlgoliaParam(
          data['date'],
          ParamType.String,
          false,
        ),
        title: convertAlgoliaParam(
          data['title'],
          ParamType.String,
          false,
        ),
        explanation: convertAlgoliaParam(
          data['explanation'],
          ParamType.String,
          false,
        ),
        url: convertAlgoliaParam(
          data['url'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ApodAPIStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ApodAPIStruct &&
        date == other.date &&
        title == other.title &&
        explanation == other.explanation &&
        url == other.url;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([date, title, explanation, url]);
}

ApodAPIStruct createApodAPIStruct({
  String? date,
  String? title,
  String? explanation,
  String? url,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ApodAPIStruct(
      date: date,
      title: title,
      explanation: explanation,
      url: url,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ApodAPIStruct? updateApodAPIStruct(
  ApodAPIStruct? apodAPI, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    apodAPI
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addApodAPIStructData(
  Map<String, dynamic> firestoreData,
  ApodAPIStruct? apodAPI,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (apodAPI == null) {
    return;
  }
  if (apodAPI.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && apodAPI.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final apodAPIData = getApodAPIFirestoreData(apodAPI, forFieldValue);
  final nestedData = apodAPIData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = apodAPI.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getApodAPIFirestoreData(
  ApodAPIStruct? apodAPI, [
  bool forFieldValue = false,
]) {
  if (apodAPI == null) {
    return {};
  }
  final firestoreData = mapToFirestore(apodAPI.toMap());

  // Add any Firestore field values
  apodAPI.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getApodAPIListFirestoreData(
  List<ApodAPIStruct>? apodAPIs,
) =>
    apodAPIs?.map((e) => getApodAPIFirestoreData(e, true)).toList() ?? [];
