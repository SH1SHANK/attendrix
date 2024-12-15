import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExamsRecord extends FirestoreRecord {
  ExamsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "batch" field.
  String? _batch;
  String get batch => _batch ?? '';
  bool hasBatch() => _batch != null;

  // "examId" field.
  String? _examId;
  String get examId => _examId ?? '';
  bool hasExamId() => _examId != null;

  // "examName" field.
  String? _examName;
  String get examName => _examName ?? '';
  bool hasExamName() => _examName != null;

  // "examStartTime" field.
  DateTime? _examStartTime;
  DateTime? get examStartTime => _examStartTime;
  bool hasExamStartTime() => _examStartTime != null;

  // "examEndTime" field.
  DateTime? _examEndTime;
  DateTime? get examEndTime => _examEndTime;
  bool hasExamEndTime() => _examEndTime != null;

  // "examType" field.
  String? _examType;
  String get examType => _examType ?? '';
  bool hasExamType() => _examType != null;

  // "examPlace" field.
  String? _examPlace;
  String get examPlace => _examPlace ?? '';
  bool hasExamPlace() => _examPlace != null;

  // "examSyllabus" field.
  String? _examSyllabus;
  String get examSyllabus => _examSyllabus ?? '';
  bool hasExamSyllabus() => _examSyllabus != null;

  void _initializeFields() {
    _batch = snapshotData['batch'] as String?;
    _examId = snapshotData['examId'] as String?;
    _examName = snapshotData['examName'] as String?;
    _examStartTime = snapshotData['examStartTime'] as DateTime?;
    _examEndTime = snapshotData['examEndTime'] as DateTime?;
    _examType = snapshotData['examType'] as String?;
    _examPlace = snapshotData['examPlace'] as String?;
    _examSyllabus = snapshotData['examSyllabus'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('exams');

  static Stream<ExamsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ExamsRecord.fromSnapshot(s));

  static Future<ExamsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ExamsRecord.fromSnapshot(s));

  static ExamsRecord fromSnapshot(DocumentSnapshot snapshot) => ExamsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ExamsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ExamsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ExamsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ExamsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createExamsRecordData({
  String? batch,
  String? examId,
  String? examName,
  DateTime? examStartTime,
  DateTime? examEndTime,
  String? examType,
  String? examPlace,
  String? examSyllabus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'batch': batch,
      'examId': examId,
      'examName': examName,
      'examStartTime': examStartTime,
      'examEndTime': examEndTime,
      'examType': examType,
      'examPlace': examPlace,
      'examSyllabus': examSyllabus,
    }.withoutNulls,
  );

  return firestoreData;
}

class ExamsRecordDocumentEquality implements Equality<ExamsRecord> {
  const ExamsRecordDocumentEquality();

  @override
  bool equals(ExamsRecord? e1, ExamsRecord? e2) {
    return e1?.batch == e2?.batch &&
        e1?.examId == e2?.examId &&
        e1?.examName == e2?.examName &&
        e1?.examStartTime == e2?.examStartTime &&
        e1?.examEndTime == e2?.examEndTime &&
        e1?.examType == e2?.examType &&
        e1?.examPlace == e2?.examPlace &&
        e1?.examSyllabus == e2?.examSyllabus;
  }

  @override
  int hash(ExamsRecord? e) => const ListEquality().hash([
        e?.batch,
        e?.examId,
        e?.examName,
        e?.examStartTime,
        e?.examEndTime,
        e?.examType,
        e?.examPlace,
        e?.examSyllabus
      ]);

  @override
  bool isValidKey(Object? o) => o is ExamsRecord;
}
