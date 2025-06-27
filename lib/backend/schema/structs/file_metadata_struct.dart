// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FileMetadataStruct extends FFFirebaseStruct {
  FileMetadataStruct({
    String? path,
    String? title,
    String? fileType,
    int? sizeBytes,
    String? createdAt,
    String? lastOpened,
    int? isFavorite,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _path = path,
        _title = title,
        _fileType = fileType,
        _sizeBytes = sizeBytes,
        _createdAt = createdAt,
        _lastOpened = lastOpened,
        _isFavorite = isFavorite,
        super(firestoreUtilData);

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "file_type" field.
  String? _fileType;
  String get fileType => _fileType ?? '';
  set fileType(String? val) => _fileType = val;

  bool hasFileType() => _fileType != null;

  // "size_bytes" field.
  int? _sizeBytes;
  int get sizeBytes => _sizeBytes ?? 0;
  set sizeBytes(int? val) => _sizeBytes = val;

  void incrementSizeBytes(int amount) => sizeBytes = sizeBytes + amount;

  bool hasSizeBytes() => _sizeBytes != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "last_opened" field.
  String? _lastOpened;
  String get lastOpened => _lastOpened ?? '';
  set lastOpened(String? val) => _lastOpened = val;

  bool hasLastOpened() => _lastOpened != null;

  // "is_favorite" field.
  int? _isFavorite;
  int get isFavorite => _isFavorite ?? 0;
  set isFavorite(int? val) => _isFavorite = val;

  void incrementIsFavorite(int amount) => isFavorite = isFavorite + amount;

  bool hasIsFavorite() => _isFavorite != null;

  static FileMetadataStruct fromMap(Map<String, dynamic> data) =>
      FileMetadataStruct(
        path: data['path'] as String?,
        title: data['title'] as String?,
        fileType: data['file_type'] as String?,
        sizeBytes: castToType<int>(data['size_bytes']),
        createdAt: data['created_at'] as String?,
        lastOpened: data['last_opened'] as String?,
        isFavorite: castToType<int>(data['is_favorite']),
      );

  static FileMetadataStruct? maybeFromMap(dynamic data) => data is Map
      ? FileMetadataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'path': _path,
        'title': _title,
        'file_type': _fileType,
        'size_bytes': _sizeBytes,
        'created_at': _createdAt,
        'last_opened': _lastOpened,
        'is_favorite': _isFavorite,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'file_type': serializeParam(
          _fileType,
          ParamType.String,
        ),
        'size_bytes': serializeParam(
          _sizeBytes,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'last_opened': serializeParam(
          _lastOpened,
          ParamType.String,
        ),
        'is_favorite': serializeParam(
          _isFavorite,
          ParamType.int,
        ),
      }.withoutNulls;

  static FileMetadataStruct fromSerializableMap(Map<String, dynamic> data) =>
      FileMetadataStruct(
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        fileType: deserializeParam(
          data['file_type'],
          ParamType.String,
          false,
        ),
        sizeBytes: deserializeParam(
          data['size_bytes'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        lastOpened: deserializeParam(
          data['last_opened'],
          ParamType.String,
          false,
        ),
        isFavorite: deserializeParam(
          data['is_favorite'],
          ParamType.int,
          false,
        ),
      );

  static FileMetadataStruct fromAlgoliaData(Map<String, dynamic> data) =>
      FileMetadataStruct(
        path: convertAlgoliaParam(
          data['path'],
          ParamType.String,
          false,
        ),
        title: convertAlgoliaParam(
          data['title'],
          ParamType.String,
          false,
        ),
        fileType: convertAlgoliaParam(
          data['file_type'],
          ParamType.String,
          false,
        ),
        sizeBytes: convertAlgoliaParam(
          data['size_bytes'],
          ParamType.int,
          false,
        ),
        createdAt: convertAlgoliaParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        lastOpened: convertAlgoliaParam(
          data['last_opened'],
          ParamType.String,
          false,
        ),
        isFavorite: convertAlgoliaParam(
          data['is_favorite'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'FileMetadataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FileMetadataStruct &&
        path == other.path &&
        title == other.title &&
        fileType == other.fileType &&
        sizeBytes == other.sizeBytes &&
        createdAt == other.createdAt &&
        lastOpened == other.lastOpened &&
        isFavorite == other.isFavorite;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [path, title, fileType, sizeBytes, createdAt, lastOpened, isFavorite]);
}

FileMetadataStruct createFileMetadataStruct({
  String? path,
  String? title,
  String? fileType,
  int? sizeBytes,
  String? createdAt,
  String? lastOpened,
  int? isFavorite,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FileMetadataStruct(
      path: path,
      title: title,
      fileType: fileType,
      sizeBytes: sizeBytes,
      createdAt: createdAt,
      lastOpened: lastOpened,
      isFavorite: isFavorite,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FileMetadataStruct? updateFileMetadataStruct(
  FileMetadataStruct? fileMetadata, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fileMetadata
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFileMetadataStructData(
  Map<String, dynamic> firestoreData,
  FileMetadataStruct? fileMetadata,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fileMetadata == null) {
    return;
  }
  if (fileMetadata.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fileMetadata.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fileMetadataData =
      getFileMetadataFirestoreData(fileMetadata, forFieldValue);
  final nestedData =
      fileMetadataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fileMetadata.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFileMetadataFirestoreData(
  FileMetadataStruct? fileMetadata, [
  bool forFieldValue = false,
]) {
  if (fileMetadata == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fileMetadata.toMap());

  // Add any Firestore field values
  fileMetadata.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFileMetadataListFirestoreData(
  List<FileMetadataStruct>? fileMetadatas,
) =>
    fileMetadatas?.map((e) => getFileMetadataFirestoreData(e, true)).toList() ??
    [];
