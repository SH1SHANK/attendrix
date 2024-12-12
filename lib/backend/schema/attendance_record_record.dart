import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AttendanceRecordRecord extends FirestoreRecord {
  AttendanceRecordRecord._(
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

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "isPresent" field.
  bool? _isPresent;
  bool get isPresent => _isPresent ?? false;
  bool hasIsPresent() => _isPresent != null;

  // "checkin_time" field.
  DateTime? _checkinTime;
  DateTime? get checkinTime => _checkinTime;
  bool hasCheckinTime() => _checkinTime != null;

  // "ClassId" field.
  String? _classId;
  String get classId => _classId ?? '';
  bool hasClassId() => _classId != null;

  void _initializeFields() {
    _batch = snapshotData['batch'] as String?;
    _courseName = snapshotData['course_name'] as String?;
    _classDate = snapshotData['classDate'] as DateTime?;
    _username = snapshotData['username'] as String?;
    _userId = snapshotData['userId'] as String?;
    _isPresent = snapshotData['isPresent'] as bool?;
    _checkinTime = snapshotData['checkin_time'] as DateTime?;
    _classId = snapshotData['ClassId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('attendance_record');

  static Stream<AttendanceRecordRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AttendanceRecordRecord.fromSnapshot(s));

  static Future<AttendanceRecordRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AttendanceRecordRecord.fromSnapshot(s));

  static AttendanceRecordRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AttendanceRecordRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AttendanceRecordRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AttendanceRecordRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AttendanceRecordRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AttendanceRecordRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAttendanceRecordRecordData({
  String? batch,
  String? courseName,
  DateTime? classDate,
  String? username,
  String? userId,
  bool? isPresent,
  DateTime? checkinTime,
  String? classId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'batch': batch,
      'course_name': courseName,
      'classDate': classDate,
      'username': username,
      'userId': userId,
      'isPresent': isPresent,
      'checkin_time': checkinTime,
      'ClassId': classId,
    }.withoutNulls,
  );

  return firestoreData;
}

class AttendanceRecordRecordDocumentEquality
    implements Equality<AttendanceRecordRecord> {
  const AttendanceRecordRecordDocumentEquality();

  @override
  bool equals(AttendanceRecordRecord? e1, AttendanceRecordRecord? e2) {
    return e1?.batch == e2?.batch &&
        e1?.courseName == e2?.courseName &&
        e1?.classDate == e2?.classDate &&
        e1?.username == e2?.username &&
        e1?.userId == e2?.userId &&
        e1?.isPresent == e2?.isPresent &&
        e1?.checkinTime == e2?.checkinTime &&
        e1?.classId == e2?.classId;
  }

  @override
  int hash(AttendanceRecordRecord? e) => const ListEquality().hash([
        e?.batch,
        e?.courseName,
        e?.classDate,
        e?.username,
        e?.userId,
        e?.isPresent,
        e?.checkinTime,
        e?.classId
      ]);

  @override
  bool isValidKey(Object? o) => o is AttendanceRecordRecord;
}
