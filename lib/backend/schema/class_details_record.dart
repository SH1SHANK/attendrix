import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClassDetailsRecord extends FirestoreRecord {
  ClassDetailsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "batch" field.
  String? _batch;
  String get batch => _batch ?? '';
  bool hasBatch() => _batch != null;

  // "course_name" field.
  String? _courseName;
  String get courseName => _courseName ?? '';
  bool hasCourseName() => _courseName != null;

  void _initializeFields() {
    _batch = snapshotData['batch'] as String?;
    _courseName = snapshotData['course_name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('classDetails');

  static Stream<ClassDetailsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ClassDetailsRecord.fromSnapshot(s));

  static Future<ClassDetailsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ClassDetailsRecord.fromSnapshot(s));

  static ClassDetailsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ClassDetailsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ClassDetailsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ClassDetailsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ClassDetailsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ClassDetailsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createClassDetailsRecordData({
  String? batch,
  String? courseName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'batch': batch,
      'course_name': courseName,
    }.withoutNulls,
  );

  return firestoreData;
}

class ClassDetailsRecordDocumentEquality
    implements Equality<ClassDetailsRecord> {
  const ClassDetailsRecordDocumentEquality();

  @override
  bool equals(ClassDetailsRecord? e1, ClassDetailsRecord? e2) {
    return e1?.batch == e2?.batch && e1?.courseName == e2?.courseName;
  }

  @override
  int hash(ClassDetailsRecord? e) =>
      const ListEquality().hash([e?.batch, e?.courseName]);

  @override
  bool isValidKey(Object? o) => o is ClassDetailsRecord;
}
