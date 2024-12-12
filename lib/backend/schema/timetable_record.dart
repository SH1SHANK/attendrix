import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TimetableRecord extends FirestoreRecord {
  TimetableRecord._(
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

  // "classDate" field.
  DateTime? _classDate;
  DateTime? get classDate => _classDate;
  bool hasClassDate() => _classDate != null;

  // "classStatus" field.
  ClassStatus? _classStatus;
  ClassStatus? get classStatus => _classStatus;
  bool hasClassStatus() => _classStatus != null;

  // "users" field.
  List<String>? _users;
  List<String> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "ClassId" field.
  String? _classId;
  String get classId => _classId ?? '';
  bool hasClassId() => _classId != null;

  // "scheduledDate" field.
  String? _scheduledDate;
  String get scheduledDate => _scheduledDate ?? '';
  bool hasScheduledDate() => _scheduledDate != null;

  void _initializeFields() {
    _batch = snapshotData['batch'] as String?;
    _courseName = snapshotData['course_name'] as String?;
    _classDate = snapshotData['classDate'] as DateTime?;
    _classStatus = snapshotData['classStatus'] is ClassStatus
        ? snapshotData['classStatus']
        : deserializeEnum<ClassStatus>(snapshotData['classStatus']);
    _users = getDataList(snapshotData['users']);
    _classId = snapshotData['ClassId'] as String?;
    _scheduledDate = snapshotData['scheduledDate'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('timetable');

  static Stream<TimetableRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TimetableRecord.fromSnapshot(s));

  static Future<TimetableRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TimetableRecord.fromSnapshot(s));

  static TimetableRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TimetableRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TimetableRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TimetableRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TimetableRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TimetableRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTimetableRecordData({
  String? batch,
  String? courseName,
  DateTime? classDate,
  ClassStatus? classStatus,
  String? classId,
  String? scheduledDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'batch': batch,
      'course_name': courseName,
      'classDate': classDate,
      'classStatus': classStatus,
      'ClassId': classId,
      'scheduledDate': scheduledDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class TimetableRecordDocumentEquality implements Equality<TimetableRecord> {
  const TimetableRecordDocumentEquality();

  @override
  bool equals(TimetableRecord? e1, TimetableRecord? e2) {
    const listEquality = ListEquality();
    return e1?.batch == e2?.batch &&
        e1?.courseName == e2?.courseName &&
        e1?.classDate == e2?.classDate &&
        e1?.classStatus == e2?.classStatus &&
        listEquality.equals(e1?.users, e2?.users) &&
        e1?.classId == e2?.classId &&
        e1?.scheduledDate == e2?.scheduledDate;
  }

  @override
  int hash(TimetableRecord? e) => const ListEquality().hash([
        e?.batch,
        e?.courseName,
        e?.classDate,
        e?.classStatus,
        e?.users,
        e?.classId,
        e?.scheduledDate
      ]);

  @override
  bool isValidKey(Object? o) => o is TimetableRecord;
}
