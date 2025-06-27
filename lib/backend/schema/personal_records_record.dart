import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PersonalRecordsRecord extends FirestoreRecord {
  PersonalRecordsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "record_id" field.
  String? _recordId;
  String get recordId => _recordId ?? '';
  bool hasRecordId() => _recordId != null;

  // "note_title" field.
  String? _noteTitle;
  String get noteTitle => _noteTitle ?? '';
  bool hasNoteTitle() => _noteTitle != null;

  // "note_body" field.
  String? _noteBody;
  String get noteBody => _noteBody ?? '';
  bool hasNoteBody() => _noteBody != null;

  // "entity_type" field.
  RecordType? _entityType;
  RecordType? get entityType => _entityType;
  bool hasEntityType() => _entityType != null;

  // "note_type" field.
  String? _noteType;
  String get noteType => _noteType ?? '';
  bool hasNoteType() => _noteType != null;

  // "marks_obtained" field.
  double? _marksObtained;
  double get marksObtained => _marksObtained ?? 0.0;
  bool hasMarksObtained() => _marksObtained != null;

  // "total_marks" field.
  double? _totalMarks;
  double get totalMarks => _totalMarks ?? 0.0;
  bool hasTotalMarks() => _totalMarks != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "last_modified_at" field.
  DateTime? _lastModifiedAt;
  DateTime? get lastModifiedAt => _lastModifiedAt;
  bool hasLastModifiedAt() => _lastModifiedAt != null;

  // "attachments" field.
  String? _attachments;
  String get attachments => _attachments ?? '';
  bool hasAttachments() => _attachments != null;

  // "colorSchema" field.
  Color? _colorSchema;
  Color? get colorSchema => _colorSchema;
  bool hasColorSchema() => _colorSchema != null;

  // "tags" field.
  List<String>? _tags;
  List<String> get tags => _tags ?? const [];
  bool hasTags() => _tags != null;

  // "courseID" field.
  String? _courseID;
  String get courseID => _courseID ?? '';
  bool hasCourseID() => _courseID != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _recordId = snapshotData['record_id'] as String?;
    _noteTitle = snapshotData['note_title'] as String?;
    _noteBody = snapshotData['note_body'] as String?;
    _entityType = snapshotData['entity_type'] is RecordType
        ? snapshotData['entity_type']
        : deserializeEnum<RecordType>(snapshotData['entity_type']);
    _noteType = snapshotData['note_type'] as String?;
    _marksObtained = castToType<double>(snapshotData['marks_obtained']);
    _totalMarks = castToType<double>(snapshotData['total_marks']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _lastModifiedAt = snapshotData['last_modified_at'] as DateTime?;
    _attachments = snapshotData['attachments'] as String?;
    _colorSchema = getSchemaColor(snapshotData['colorSchema']);
    _tags = getDataList(snapshotData['tags']);
    _courseID = snapshotData['courseID'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('personalRecords')
          : FirebaseFirestore.instance.collectionGroup('personalRecords');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('personalRecords').doc(id);

  static Stream<PersonalRecordsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PersonalRecordsRecord.fromSnapshot(s));

  static Future<PersonalRecordsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PersonalRecordsRecord.fromSnapshot(s));

  static PersonalRecordsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PersonalRecordsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PersonalRecordsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PersonalRecordsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PersonalRecordsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PersonalRecordsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPersonalRecordsRecordData({
  String? recordId,
  String? noteTitle,
  String? noteBody,
  RecordType? entityType,
  String? noteType,
  double? marksObtained,
  double? totalMarks,
  DateTime? createdAt,
  DateTime? lastModifiedAt,
  String? attachments,
  Color? colorSchema,
  String? courseID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'record_id': recordId,
      'note_title': noteTitle,
      'note_body': noteBody,
      'entity_type': entityType,
      'note_type': noteType,
      'marks_obtained': marksObtained,
      'total_marks': totalMarks,
      'created_at': createdAt,
      'last_modified_at': lastModifiedAt,
      'attachments': attachments,
      'colorSchema': colorSchema,
      'courseID': courseID,
    }.withoutNulls,
  );

  return firestoreData;
}

class PersonalRecordsRecordDocumentEquality
    implements Equality<PersonalRecordsRecord> {
  const PersonalRecordsRecordDocumentEquality();

  @override
  bool equals(PersonalRecordsRecord? e1, PersonalRecordsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.recordId == e2?.recordId &&
        e1?.noteTitle == e2?.noteTitle &&
        e1?.noteBody == e2?.noteBody &&
        e1?.entityType == e2?.entityType &&
        e1?.noteType == e2?.noteType &&
        e1?.marksObtained == e2?.marksObtained &&
        e1?.totalMarks == e2?.totalMarks &&
        e1?.createdAt == e2?.createdAt &&
        e1?.lastModifiedAt == e2?.lastModifiedAt &&
        e1?.attachments == e2?.attachments &&
        e1?.colorSchema == e2?.colorSchema &&
        listEquality.equals(e1?.tags, e2?.tags) &&
        e1?.courseID == e2?.courseID;
  }

  @override
  int hash(PersonalRecordsRecord? e) => const ListEquality().hash([
        e?.recordId,
        e?.noteTitle,
        e?.noteBody,
        e?.entityType,
        e?.noteType,
        e?.marksObtained,
        e?.totalMarks,
        e?.createdAt,
        e?.lastModifiedAt,
        e?.attachments,
        e?.colorSchema,
        e?.tags,
        e?.courseID
      ]);

  @override
  bool isValidKey(Object? o) => o is PersonalRecordsRecord;
}
