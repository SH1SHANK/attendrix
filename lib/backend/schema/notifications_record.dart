import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "notificationID" field.
  String? _notificationID;
  String get notificationID => _notificationID ?? '';
  bool hasNotificationID() => _notificationID != null;

  // "recordID" field.
  String? _recordID;
  String get recordID => _recordID ?? '';
  bool hasRecordID() => _recordID != null;

  // "recordType" field.
  RecordType? _recordType;
  RecordType? get recordType => _recordType;
  bool hasRecordType() => _recordType != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "NotificationTime" field.
  DateTime? _notificationTime;
  DateTime? get notificationTime => _notificationTime;
  bool hasNotificationTime() => _notificationTime != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _notificationID = snapshotData['notificationID'] as String?;
    _recordID = snapshotData['recordID'] as String?;
    _recordType = snapshotData['recordType'] is RecordType
        ? snapshotData['recordType']
        : deserializeEnum<RecordType>(snapshotData['recordType']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _notificationTime = snapshotData['NotificationTime'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('notifications')
          : FirebaseFirestore.instance.collectionGroup('notifications');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('notifications').doc(id);

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  String? notificationID,
  String? recordID,
  RecordType? recordType,
  DateTime? createdAt,
  DateTime? notificationTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'notificationID': notificationID,
      'recordID': recordID,
      'recordType': recordType,
      'created_at': createdAt,
      'NotificationTime': notificationTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    return e1?.notificationID == e2?.notificationID &&
        e1?.recordID == e2?.recordID &&
        e1?.recordType == e2?.recordType &&
        e1?.createdAt == e2?.createdAt &&
        e1?.notificationTime == e2?.notificationTime;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.notificationID,
        e?.recordID,
        e?.recordType,
        e?.createdAt,
        e?.notificationTime
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
