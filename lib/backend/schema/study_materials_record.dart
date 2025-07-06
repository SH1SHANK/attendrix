import 'dart:async';

import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// The studyMaterials collection serves as the central repository for all
/// uploaded or shared study material files such as PDFs, videos, images, and
/// notes.
///
/// Each document in this collection represents a unique file and stores
/// global metadata including the file name, type, size, upload timestamp,
/// MIME type, Firebase Storage path, and owner information. It also includes
/// public visibility flags, global tags for searchability, and optional
/// preview URLs. This collection is optimized for minimal duplication by
/// isolating per-user customization into a dedicated subcollection.
class StudyMaterialsRecord extends FirestoreRecord {
  StudyMaterialsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "fileName" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  bool hasFileName() => _fileName != null;

  // "filePath" field.
  String? _filePath;
  String get filePath => _filePath ?? '';
  bool hasFilePath() => _filePath != null;

  // "globalTags" field.
  List<String>? _globalTags;
  List<String> get globalTags => _globalTags ?? const [];
  bool hasGlobalTags() => _globalTags != null;

  // "mimeType" field.
  String? _mimeType;
  String get mimeType => _mimeType ?? '';
  bool hasMimeType() => _mimeType != null;

  // "parentPath" field.
  String? _parentPath;
  String get parentPath => _parentPath ?? '';
  bool hasParentPath() => _parentPath != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "material_type" field.
  StudyMaterialType? _materialType;
  StudyMaterialType? get materialType => _materialType;
  bool hasMaterialType() => _materialType != null;

  // "fileSize_Bytes" field.
  int? _fileSizeBytes;
  int get fileSizeBytes => _fileSizeBytes ?? 0;
  bool hasFileSizeBytes() => _fileSizeBytes != null;

  // "nestedPath" field.
  String? _nestedPath;
  String get nestedPath => _nestedPath ?? '';
  bool hasNestedPath() => _nestedPath != null;

  void _initializeFields() {
    _fileName = snapshotData['fileName'] as String?;
    _filePath = snapshotData['filePath'] as String?;
    _globalTags = getDataList(snapshotData['globalTags']);
    _mimeType = snapshotData['mimeType'] as String?;
    _parentPath = snapshotData['parentPath'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _materialType = snapshotData['material_type'] is StudyMaterialType
        ? snapshotData['material_type']
        : deserializeEnum<StudyMaterialType>(snapshotData['material_type']);
    _fileSizeBytes = castToType<int>(snapshotData['fileSize_Bytes']);
    _nestedPath = snapshotData['nestedPath'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('studyMaterials');

  static Stream<StudyMaterialsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StudyMaterialsRecord.fromSnapshot(s));

  static Future<StudyMaterialsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StudyMaterialsRecord.fromSnapshot(s));

  static StudyMaterialsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StudyMaterialsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StudyMaterialsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StudyMaterialsRecord._(reference, mapFromFirestore(data));

  static StudyMaterialsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      StudyMaterialsRecord.getDocumentFromData(
        {
          'fileName': snapshot.data['fileName'],
          'filePath': snapshot.data['filePath'],
          'globalTags': safeGet(
            () => snapshot.data['globalTags'].toList(),
          ),
          'mimeType': snapshot.data['mimeType'],
          'parentPath': snapshot.data['parentPath'],
          'created_at': convertAlgoliaParam(
            snapshot.data['created_at'],
            ParamType.DateTime,
            false,
          ),
          'material_type': convertAlgoliaParam<StudyMaterialType>(
            snapshot.data['material_type'],
            ParamType.Enum,
            false,
          ),
          'fileSize_Bytes': convertAlgoliaParam(
            snapshot.data['fileSize_Bytes'],
            ParamType.int,
            false,
          ),
          'nestedPath': snapshot.data['nestedPath'],
        },
        StudyMaterialsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<StudyMaterialsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'studyMaterials',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'StudyMaterialsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StudyMaterialsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStudyMaterialsRecordData({
  String? fileName,
  String? filePath,
  String? mimeType,
  String? parentPath,
  DateTime? createdAt,
  StudyMaterialType? materialType,
  int? fileSizeBytes,
  String? nestedPath,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'fileName': fileName,
      'filePath': filePath,
      'mimeType': mimeType,
      'parentPath': parentPath,
      'created_at': createdAt,
      'material_type': materialType,
      'fileSize_Bytes': fileSizeBytes,
      'nestedPath': nestedPath,
    }.withoutNulls,
  );

  return firestoreData;
}

class StudyMaterialsRecordDocumentEquality
    implements Equality<StudyMaterialsRecord> {
  const StudyMaterialsRecordDocumentEquality();

  @override
  bool equals(StudyMaterialsRecord? e1, StudyMaterialsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.fileName == e2?.fileName &&
        e1?.filePath == e2?.filePath &&
        listEquality.equals(e1?.globalTags, e2?.globalTags) &&
        e1?.mimeType == e2?.mimeType &&
        e1?.parentPath == e2?.parentPath &&
        e1?.createdAt == e2?.createdAt &&
        e1?.materialType == e2?.materialType &&
        e1?.fileSizeBytes == e2?.fileSizeBytes &&
        e1?.nestedPath == e2?.nestedPath;
  }

  @override
  int hash(StudyMaterialsRecord? e) => const ListEquality().hash([
        e?.fileName,
        e?.filePath,
        e?.globalTags,
        e?.mimeType,
        e?.parentPath,
        e?.createdAt,
        e?.materialType,
        e?.fileSizeBytes,
        e?.nestedPath
      ]);

  @override
  bool isValidKey(Object? o) => o is StudyMaterialsRecord;
}
