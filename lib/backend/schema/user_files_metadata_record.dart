import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserFilesMetadataRecord extends FirestoreRecord {
  UserFilesMetadataRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  bool hasUserID() => _userID != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "tags" field.
  List<String>? _tags;
  List<String> get tags => _tags ?? const [];
  bool hasTags() => _tags != null;

  // "priority" field.
  int? _priority;
  int get priority => _priority ?? 0;
  bool hasPriority() => _priority != null;

  // "last_opened_at" field.
  DateTime? _lastOpenedAt;
  DateTime? get lastOpenedAt => _lastOpenedAt;
  bool hasLastOpenedAt() => _lastOpenedAt != null;

  // "open_count" field.
  int? _openCount;
  int get openCount => _openCount ?? 0;
  bool hasOpenCount() => _openCount != null;

  // "isFavorite" field.
  bool? _isFavorite;
  bool get isFavorite => _isFavorite ?? false;
  bool hasIsFavorite() => _isFavorite != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _userID = snapshotData['userID'] as String?;
    _notes = snapshotData['notes'] as String?;
    _tags = getDataList(snapshotData['tags']);
    _priority = castToType<int>(snapshotData['priority']);
    _lastOpenedAt = snapshotData['last_opened_at'] as DateTime?;
    _openCount = castToType<int>(snapshotData['open_count']);
    _isFavorite = snapshotData['isFavorite'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('userFilesMetadata')
          : FirebaseFirestore.instance.collectionGroup('userFilesMetadata');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('userFilesMetadata').doc(id);

  static Stream<UserFilesMetadataRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserFilesMetadataRecord.fromSnapshot(s));

  static Future<UserFilesMetadataRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => UserFilesMetadataRecord.fromSnapshot(s));

  static UserFilesMetadataRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserFilesMetadataRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserFilesMetadataRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserFilesMetadataRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserFilesMetadataRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserFilesMetadataRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserFilesMetadataRecordData({
  String? userID,
  String? notes,
  int? priority,
  DateTime? lastOpenedAt,
  int? openCount,
  bool? isFavorite,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userID': userID,
      'notes': notes,
      'priority': priority,
      'last_opened_at': lastOpenedAt,
      'open_count': openCount,
      'isFavorite': isFavorite,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserFilesMetadataRecordDocumentEquality
    implements Equality<UserFilesMetadataRecord> {
  const UserFilesMetadataRecordDocumentEquality();

  @override
  bool equals(UserFilesMetadataRecord? e1, UserFilesMetadataRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userID == e2?.userID &&
        e1?.notes == e2?.notes &&
        listEquality.equals(e1?.tags, e2?.tags) &&
        e1?.priority == e2?.priority &&
        e1?.lastOpenedAt == e2?.lastOpenedAt &&
        e1?.openCount == e2?.openCount &&
        e1?.isFavorite == e2?.isFavorite;
  }

  @override
  int hash(UserFilesMetadataRecord? e) => const ListEquality().hash([
        e?.userID,
        e?.notes,
        e?.tags,
        e?.priority,
        e?.lastOpenedAt,
        e?.openCount,
        e?.isFavorite
      ]);

  @override
  bool isValidKey(Object? o) => o is UserFilesMetadataRecord;
}
