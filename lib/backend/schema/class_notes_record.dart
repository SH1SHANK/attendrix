import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClassNotesRecord extends FirestoreRecord {
  ClassNotesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "classID" field.
  String? _classID;
  String get classID => _classID ?? '';
  bool hasClassID() => _classID != null;

  // "courseName" field.
  String? _courseName;
  String get courseName => _courseName ?? '';
  bool hasCourseName() => _courseName != null;

  // "classStartTime" field.
  DateTime? _classStartTime;
  DateTime? get classStartTime => _classStartTime;
  bool hasClassStartTime() => _classStartTime != null;

  // "noteTitle" field.
  String? _noteTitle;
  String get noteTitle => _noteTitle ?? '';
  bool hasNoteTitle() => _noteTitle != null;

  // "noteDescription" field.
  String? _noteDescription;
  String get noteDescription => _noteDescription ?? '';
  bool hasNoteDescription() => _noteDescription != null;

  // "hasAttachments" field.
  bool? _hasAttachments;
  bool get hasAttachments => _hasAttachments ?? false;
  bool hasHasAttachments() => _hasAttachments != null;

  // "noteColor" field.
  Color? _noteColor;
  Color? get noteColor => _noteColor;
  bool hasNoteColor() => _noteColor != null;

  // "tagsAttached" field.
  List<String>? _tagsAttached;
  List<String> get tagsAttached => _tagsAttached ?? const [];
  bool hasTagsAttached() => _tagsAttached != null;

  // "attachmentAdded" field.
  FileInfoStruct? _attachmentAdded;
  FileInfoStruct get attachmentAdded => _attachmentAdded ?? FileInfoStruct();
  bool hasAttachmentAdded() => _attachmentAdded != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _classID = snapshotData['classID'] as String?;
    _courseName = snapshotData['courseName'] as String?;
    _classStartTime = snapshotData['classStartTime'] as DateTime?;
    _noteTitle = snapshotData['noteTitle'] as String?;
    _noteDescription = snapshotData['noteDescription'] as String?;
    _hasAttachments = snapshotData['hasAttachments'] as bool?;
    _noteColor = getSchemaColor(snapshotData['noteColor']);
    _tagsAttached = getDataList(snapshotData['tagsAttached']);
    _attachmentAdded = snapshotData['attachmentAdded'] is FileInfoStruct
        ? snapshotData['attachmentAdded']
        : FileInfoStruct.maybeFromMap(snapshotData['attachmentAdded']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('classNotes')
          : FirebaseFirestore.instance.collectionGroup('classNotes');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('classNotes').doc(id);

  static Stream<ClassNotesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ClassNotesRecord.fromSnapshot(s));

  static Future<ClassNotesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ClassNotesRecord.fromSnapshot(s));

  static ClassNotesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ClassNotesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ClassNotesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ClassNotesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ClassNotesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ClassNotesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createClassNotesRecordData({
  String? classID,
  String? courseName,
  DateTime? classStartTime,
  String? noteTitle,
  String? noteDescription,
  bool? hasAttachments,
  Color? noteColor,
  FileInfoStruct? attachmentAdded,
  DateTime? createdAt,
  DateTime? modifiedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'classID': classID,
      'courseName': courseName,
      'classStartTime': classStartTime,
      'noteTitle': noteTitle,
      'noteDescription': noteDescription,
      'hasAttachments': hasAttachments,
      'noteColor': noteColor,
      'attachmentAdded': FileInfoStruct().toMap(),
      'created_at': createdAt,
      'modified_at': modifiedAt,
    }.withoutNulls,
  );

  // Handle nested data for "attachmentAdded" field.
  addFileInfoStructData(firestoreData, attachmentAdded, 'attachmentAdded');

  return firestoreData;
}

class ClassNotesRecordDocumentEquality implements Equality<ClassNotesRecord> {
  const ClassNotesRecordDocumentEquality();

  @override
  bool equals(ClassNotesRecord? e1, ClassNotesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.classID == e2?.classID &&
        e1?.courseName == e2?.courseName &&
        e1?.classStartTime == e2?.classStartTime &&
        e1?.noteTitle == e2?.noteTitle &&
        e1?.noteDescription == e2?.noteDescription &&
        e1?.hasAttachments == e2?.hasAttachments &&
        e1?.noteColor == e2?.noteColor &&
        listEquality.equals(e1?.tagsAttached, e2?.tagsAttached) &&
        e1?.attachmentAdded == e2?.attachmentAdded &&
        e1?.createdAt == e2?.createdAt &&
        e1?.modifiedAt == e2?.modifiedAt;
  }

  @override
  int hash(ClassNotesRecord? e) => const ListEquality().hash([
        e?.classID,
        e?.courseName,
        e?.classStartTime,
        e?.noteTitle,
        e?.noteDescription,
        e?.hasAttachments,
        e?.noteColor,
        e?.tagsAttached,
        e?.attachmentAdded,
        e?.createdAt,
        e?.modifiedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is ClassNotesRecord;
}
