import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AssignmentsRecord extends FirestoreRecord {
  AssignmentsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "assignmentName" field.
  String? _assignmentName;
  String get assignmentName => _assignmentName ?? '';
  bool hasAssignmentName() => _assignmentName != null;

  // "assignementSubject" field.
  String? _assignementSubject;
  String get assignementSubject => _assignementSubject ?? '';
  bool hasAssignementSubject() => _assignementSubject != null;

  // "assignmentDescription" field.
  String? _assignmentDescription;
  String get assignmentDescription => _assignmentDescription ?? '';
  bool hasAssignmentDescription() => _assignmentDescription != null;

  // "assignmentDeadline" field.
  DateTime? _assignmentDeadline;
  DateTime? get assignmentDeadline => _assignmentDeadline;
  bool hasAssignmentDeadline() => _assignmentDeadline != null;

  // "batch" field.
  String? _batch;
  String get batch => _batch ?? '';
  bool hasBatch() => _batch != null;

  void _initializeFields() {
    _assignmentName = snapshotData['assignmentName'] as String?;
    _assignementSubject = snapshotData['assignementSubject'] as String?;
    _assignmentDescription = snapshotData['assignmentDescription'] as String?;
    _assignmentDeadline = snapshotData['assignmentDeadline'] as DateTime?;
    _batch = snapshotData['batch'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('assignments');

  static Stream<AssignmentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AssignmentsRecord.fromSnapshot(s));

  static Future<AssignmentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AssignmentsRecord.fromSnapshot(s));

  static AssignmentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AssignmentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AssignmentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AssignmentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AssignmentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AssignmentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAssignmentsRecordData({
  String? assignmentName,
  String? assignementSubject,
  String? assignmentDescription,
  DateTime? assignmentDeadline,
  String? batch,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'assignmentName': assignmentName,
      'assignementSubject': assignementSubject,
      'assignmentDescription': assignmentDescription,
      'assignmentDeadline': assignmentDeadline,
      'batch': batch,
    }.withoutNulls,
  );

  return firestoreData;
}

class AssignmentsRecordDocumentEquality implements Equality<AssignmentsRecord> {
  const AssignmentsRecordDocumentEquality();

  @override
  bool equals(AssignmentsRecord? e1, AssignmentsRecord? e2) {
    return e1?.assignmentName == e2?.assignmentName &&
        e1?.assignementSubject == e2?.assignementSubject &&
        e1?.assignmentDescription == e2?.assignmentDescription &&
        e1?.assignmentDeadline == e2?.assignmentDeadline &&
        e1?.batch == e2?.batch;
  }

  @override
  int hash(AssignmentsRecord? e) => const ListEquality().hash([
        e?.assignmentName,
        e?.assignementSubject,
        e?.assignmentDescription,
        e?.assignmentDeadline,
        e?.batch
      ]);

  @override
  bool isValidKey(Object? o) => o is AssignmentsRecord;
}
