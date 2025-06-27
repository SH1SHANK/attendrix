// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FileInfoStruct extends FFFirebaseStruct {
  FileInfoStruct({
    String? name,
    String? filePath,
    String? mimeType,
    int? sizeBytes,
    DateTime? createdAt,
    DateTime? lastOpened,
    bool? isLocalOnly,
    String? status,
    String? message,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _filePath = filePath,
        _mimeType = mimeType,
        _sizeBytes = sizeBytes,
        _createdAt = createdAt,
        _lastOpened = lastOpened,
        _isLocalOnly = isLocalOnly,
        _status = status,
        _message = message,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "filePath" field.
  String? _filePath;
  String get filePath => _filePath ?? '';
  set filePath(String? val) => _filePath = val;

  bool hasFilePath() => _filePath != null;

  // "mimeType" field.
  String? _mimeType;
  String get mimeType => _mimeType ?? '';
  set mimeType(String? val) => _mimeType = val;

  bool hasMimeType() => _mimeType != null;

  // "sizeBytes" field.
  int? _sizeBytes;
  int get sizeBytes => _sizeBytes ?? 0;
  set sizeBytes(int? val) => _sizeBytes = val;

  void incrementSizeBytes(int amount) => sizeBytes = sizeBytes + amount;

  bool hasSizeBytes() => _sizeBytes != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "lastOpened" field.
  DateTime? _lastOpened;
  DateTime? get lastOpened => _lastOpened;
  set lastOpened(DateTime? val) => _lastOpened = val;

  bool hasLastOpened() => _lastOpened != null;

  // "isLocalOnly" field.
  bool? _isLocalOnly;
  bool get isLocalOnly => _isLocalOnly ?? false;
  set isLocalOnly(bool? val) => _isLocalOnly = val;

  bool hasIsLocalOnly() => _isLocalOnly != null;

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

  static FileInfoStruct fromMap(Map<String, dynamic> data) => FileInfoStruct(
        name: data['name'] as String?,
        filePath: data['filePath'] as String?,
        mimeType: data['mimeType'] as String?,
        sizeBytes: castToType<int>(data['sizeBytes']),
        createdAt: data['createdAt'] as DateTime?,
        lastOpened: data['lastOpened'] as DateTime?,
        isLocalOnly: data['isLocalOnly'] as bool?,
        status: data['status'] as String?,
        message: data['message'] as String?,
      );

  static FileInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? FileInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'filePath': _filePath,
        'mimeType': _mimeType,
        'sizeBytes': _sizeBytes,
        'createdAt': _createdAt,
        'lastOpened': _lastOpened,
        'isLocalOnly': _isLocalOnly,
        'status': _status,
        'message': _message,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'filePath': serializeParam(
          _filePath,
          ParamType.String,
        ),
        'mimeType': serializeParam(
          _mimeType,
          ParamType.String,
        ),
        'sizeBytes': serializeParam(
          _sizeBytes,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'lastOpened': serializeParam(
          _lastOpened,
          ParamType.DateTime,
        ),
        'isLocalOnly': serializeParam(
          _isLocalOnly,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
      }.withoutNulls;

  static FileInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      FileInfoStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        filePath: deserializeParam(
          data['filePath'],
          ParamType.String,
          false,
        ),
        mimeType: deserializeParam(
          data['mimeType'],
          ParamType.String,
          false,
        ),
        sizeBytes: deserializeParam(
          data['sizeBytes'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        lastOpened: deserializeParam(
          data['lastOpened'],
          ParamType.DateTime,
          false,
        ),
        isLocalOnly: deserializeParam(
          data['isLocalOnly'],
          ParamType.bool,
          false,
        ),
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
      );

  static FileInfoStruct fromAlgoliaData(Map<String, dynamic> data) =>
      FileInfoStruct(
        name: convertAlgoliaParam(
          data['name'],
          ParamType.String,
          false,
        ),
        filePath: convertAlgoliaParam(
          data['filePath'],
          ParamType.String,
          false,
        ),
        mimeType: convertAlgoliaParam(
          data['mimeType'],
          ParamType.String,
          false,
        ),
        sizeBytes: convertAlgoliaParam(
          data['sizeBytes'],
          ParamType.int,
          false,
        ),
        createdAt: convertAlgoliaParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        lastOpened: convertAlgoliaParam(
          data['lastOpened'],
          ParamType.DateTime,
          false,
        ),
        isLocalOnly: convertAlgoliaParam(
          data['isLocalOnly'],
          ParamType.bool,
          false,
        ),
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
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'FileInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FileInfoStruct &&
        name == other.name &&
        filePath == other.filePath &&
        mimeType == other.mimeType &&
        sizeBytes == other.sizeBytes &&
        createdAt == other.createdAt &&
        lastOpened == other.lastOpened &&
        isLocalOnly == other.isLocalOnly &&
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        filePath,
        mimeType,
        sizeBytes,
        createdAt,
        lastOpened,
        isLocalOnly,
        status,
        message
      ]);
}

FileInfoStruct createFileInfoStruct({
  String? name,
  String? filePath,
  String? mimeType,
  int? sizeBytes,
  DateTime? createdAt,
  DateTime? lastOpened,
  bool? isLocalOnly,
  String? status,
  String? message,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FileInfoStruct(
      name: name,
      filePath: filePath,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      createdAt: createdAt,
      lastOpened: lastOpened,
      isLocalOnly: isLocalOnly,
      status: status,
      message: message,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FileInfoStruct? updateFileInfoStruct(
  FileInfoStruct? fileInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fileInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFileInfoStructData(
  Map<String, dynamic> firestoreData,
  FileInfoStruct? fileInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fileInfo == null) {
    return;
  }
  if (fileInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fileInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fileInfoData = getFileInfoFirestoreData(fileInfo, forFieldValue);
  final nestedData = fileInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fileInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFileInfoFirestoreData(
  FileInfoStruct? fileInfo, [
  bool forFieldValue = false,
]) {
  if (fileInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fileInfo.toMap());

  // Add any Firestore field values
  fileInfo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFileInfoListFirestoreData(
  List<FileInfoStruct>? fileInfos,
) =>
    fileInfos?.map((e) => getFileInfoFirestoreData(e, true)).toList() ?? [];
