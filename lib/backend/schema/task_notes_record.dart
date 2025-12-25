import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TaskNotesRecord extends FirestoreRecord {
  TaskNotesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "taskID" field.
  String? _taskID;
  String get taskID => _taskID ?? '';
  bool hasTaskID() => _taskID != null;

  // "obtainedMarks" field.
  double? _obtainedMarks;
  double get obtainedMarks => _obtainedMarks ?? 0.0;
  bool hasObtainedMarks() => _obtainedMarks != null;

  // "totalMarks" field.
  double? _totalMarks;
  double get totalMarks => _totalMarks ?? 0.0;
  bool hasTotalMarks() => _totalMarks != null;

  // "noteDescription" field.
  String? _noteDescription;
  String get noteDescription => _noteDescription ?? '';
  bool hasNoteDescription() => _noteDescription != null;

  // "examDetails" field.
  String? _examDetails;
  String get examDetails => _examDetails ?? '';
  bool hasExamDetails() => _examDetails != null;

  // "noteColor" field.
  Color? _noteColor;
  Color? get noteColor => _noteColor;
  bool hasNoteColor() => _noteColor != null;

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
    _taskID = snapshotData['taskID'] as String?;
    _obtainedMarks = castToType<double>(snapshotData['obtainedMarks']);
    _totalMarks = castToType<double>(snapshotData['totalMarks']);
    _noteDescription = snapshotData['noteDescription'] as String?;
    _examDetails = snapshotData['examDetails'] as String?;
    _noteColor = getSchemaColor(snapshotData['noteColor']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('taskNotes')
          : FirebaseFirestore.instance.collectionGroup('taskNotes');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('taskNotes').doc(id);

  static Stream<TaskNotesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TaskNotesRecord.fromSnapshot(s));

  static Future<TaskNotesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TaskNotesRecord.fromSnapshot(s));

  static TaskNotesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TaskNotesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TaskNotesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TaskNotesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TaskNotesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TaskNotesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTaskNotesRecordData({
  String? taskID,
  double? obtainedMarks,
  double? totalMarks,
  String? noteDescription,
  String? examDetails,
  Color? noteColor,
  DateTime? createdAt,
  DateTime? modifiedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'taskID': taskID,
      'obtainedMarks': obtainedMarks,
      'totalMarks': totalMarks,
      'noteDescription': noteDescription,
      'examDetails': examDetails,
      'noteColor': noteColor,
      'created_at': createdAt,
      'modified_at': modifiedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class TaskNotesRecordDocumentEquality implements Equality<TaskNotesRecord> {
  const TaskNotesRecordDocumentEquality();

  @override
  bool equals(TaskNotesRecord? e1, TaskNotesRecord? e2) {
    return e1?.taskID == e2?.taskID &&
        e1?.obtainedMarks == e2?.obtainedMarks &&
        e1?.totalMarks == e2?.totalMarks &&
        e1?.noteDescription == e2?.noteDescription &&
        e1?.examDetails == e2?.examDetails &&
        e1?.noteColor == e2?.noteColor &&
        e1?.createdAt == e2?.createdAt &&
        e1?.modifiedAt == e2?.modifiedAt;
  }

  @override
  int hash(TaskNotesRecord? e) => const ListEquality().hash([
        e?.taskID,
        e?.obtainedMarks,
        e?.totalMarks,
        e?.noteDescription,
        e?.examDetails,
        e?.noteColor,
        e?.createdAt,
        e?.modifiedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is TaskNotesRecord;
}
