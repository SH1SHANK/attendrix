import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserPersonalVaultRecord extends FirestoreRecord {
  UserPersonalVaultRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  StudyMaterialType? _type;
  StudyMaterialType? get type => _type;
  bool hasType() => _type != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "parentPath" field.
  String? _parentPath;
  String get parentPath => _parentPath ?? '';
  bool hasParentPath() => _parentPath != null;

  // "filePath" field.
  String? _filePath;
  String get filePath => _filePath ?? '';
  bool hasFilePath() => _filePath != null;

  // "mimeType" field.
  String? _mimeType;
  String get mimeType => _mimeType ?? '';
  bool hasMimeType() => _mimeType != null;

  // "isDeleted" field.
  bool? _isDeleted;
  bool get isDeleted => _isDeleted ?? false;
  bool hasIsDeleted() => _isDeleted != null;

  // "deletedAt" field.
  DateTime? _deletedAt;
  DateTime? get deletedAt => _deletedAt;
  bool hasDeletedAt() => _deletedAt != null;

  // "sizeBytes" field.
  int? _sizeBytes;
  int get sizeBytes => _sizeBytes ?? 0;
  bool hasSizeBytes() => _sizeBytes != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "last_opened" field.
  DateTime? _lastOpened;
  DateTime? get lastOpened => _lastOpened;
  bool hasLastOpened() => _lastOpened != null;

  // "open_count" field.
  int? _openCount;
  int get openCount => _openCount ?? 0;
  bool hasOpenCount() => _openCount != null;

  // "is_favorite" field.
  bool? _isFavorite;
  bool get isFavorite => _isFavorite ?? false;
  bool hasIsFavorite() => _isFavorite != null;

  // "tags" field.
  List<String>? _tags;
  List<String> get tags => _tags ?? const [];
  bool hasTagsField() => _tags != null;

  // "isLocalOnly" field.
  bool? _isLocalOnly;
  bool get isLocalOnly => _isLocalOnly ?? false;
  bool hasIsLocalOnly() => _isLocalOnly != null;

  // "hasTags" field.
  bool? _hasTags;
  bool get hasTags => _hasTags ?? false;
  bool hasHasTags() => _hasTags != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _type = snapshotData['type'] is StudyMaterialType
        ? snapshotData['type']
        : deserializeEnum<StudyMaterialType>(snapshotData['type']);
    _name = snapshotData['name'] as String?;
    _parentPath = snapshotData['parentPath'] as String?;
    _filePath = snapshotData['filePath'] as String?;
    _mimeType = snapshotData['mimeType'] as String?;
    _isDeleted = snapshotData['isDeleted'] as bool?;
    _deletedAt = snapshotData['deletedAt'] as DateTime?;
    _sizeBytes = castToType<int>(snapshotData['sizeBytes']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _lastOpened = snapshotData['last_opened'] as DateTime?;
    _openCount = castToType<int>(snapshotData['open_count']);
    _isFavorite = snapshotData['is_favorite'] as bool?;
    _tags = getDataList(snapshotData['tags']);
    _isLocalOnly = snapshotData['isLocalOnly'] as bool?;
    _hasTags = snapshotData['hasTags'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('userPersonalVault')
          : FirebaseFirestore.instance.collectionGroup('userPersonalVault');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('userPersonalVault').doc(id);

  static Stream<UserPersonalVaultRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserPersonalVaultRecord.fromSnapshot(s));

  static Future<UserPersonalVaultRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => UserPersonalVaultRecord.fromSnapshot(s));

  static UserPersonalVaultRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserPersonalVaultRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserPersonalVaultRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserPersonalVaultRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserPersonalVaultRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserPersonalVaultRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserPersonalVaultRecordData({
  StudyMaterialType? type,
  String? name,
  String? parentPath,
  String? filePath,
  String? mimeType,
  bool? isDeleted,
  DateTime? deletedAt,
  int? sizeBytes,
  DateTime? createdAt,
  DateTime? lastOpened,
  int? openCount,
  bool? isFavorite,
  bool? isLocalOnly,
  bool? hasTags,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'name': name,
      'parentPath': parentPath,
      'filePath': filePath,
      'mimeType': mimeType,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt,
      'sizeBytes': sizeBytes,
      'created_at': createdAt,
      'last_opened': lastOpened,
      'open_count': openCount,
      'is_favorite': isFavorite,
      'isLocalOnly': isLocalOnly,
      'hasTags': hasTags,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserPersonalVaultRecordDocumentEquality
    implements Equality<UserPersonalVaultRecord> {
  const UserPersonalVaultRecordDocumentEquality();

  @override
  bool equals(UserPersonalVaultRecord? e1, UserPersonalVaultRecord? e2) {
    const listEquality = ListEquality();
    return e1?.type == e2?.type &&
        e1?.name == e2?.name &&
        e1?.parentPath == e2?.parentPath &&
        e1?.filePath == e2?.filePath &&
        e1?.mimeType == e2?.mimeType &&
        e1?.isDeleted == e2?.isDeleted &&
        e1?.deletedAt == e2?.deletedAt &&
        e1?.sizeBytes == e2?.sizeBytes &&
        e1?.createdAt == e2?.createdAt &&
        e1?.lastOpened == e2?.lastOpened &&
        e1?.openCount == e2?.openCount &&
        e1?.isFavorite == e2?.isFavorite &&
        listEquality.equals(e1?.tags, e2?.tags) &&
        e1?.isLocalOnly == e2?.isLocalOnly &&
        e1?.hasTags == e2?.hasTags;
  }

  @override
  int hash(UserPersonalVaultRecord? e) => const ListEquality().hash([
        e?.type,
        e?.name,
        e?.parentPath,
        e?.filePath,
        e?.mimeType,
        e?.isDeleted,
        e?.deletedAt,
        e?.sizeBytes,
        e?.createdAt,
        e?.lastOpened,
        e?.openCount,
        e?.isFavorite,
        e?.tags,
        e?.isLocalOnly,
        e?.hasTags
      ]);

  @override
  bool isValidKey(Object? o) => o is UserPersonalVaultRecord;
}
