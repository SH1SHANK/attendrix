import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomClassesRecord extends FirestoreRecord {
  CustomClassesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "courseName" field.
  String? _courseName;
  String get courseName => _courseName ?? '';
  bool hasCourseName() => _courseName != null;

  // "courseDescription" field.
  String? _courseDescription;
  String get courseDescription => _courseDescription ?? '';
  bool hasCourseDescription() => _courseDescription != null;

  // "isCustomSlot" field.
  bool? _isCustomSlot;
  bool get isCustomSlot => _isCustomSlot ?? false;
  bool hasIsCustomSlot() => _isCustomSlot != null;

  // "slotData" field.
  SlotInfoStruct? _slotData;
  SlotInfoStruct get slotData => _slotData ?? SlotInfoStruct();
  bool hasSlotData() => _slotData != null;

  // "toggleNotfications" field.
  bool? _toggleNotfications;
  bool get toggleNotfications => _toggleNotfications ?? false;
  bool hasToggleNotfications() => _toggleNotfications != null;

  // "notificationMinutesBefore" field.
  int? _notificationMinutesBefore;
  int get notificationMinutesBefore => _notificationMinutesBefore ?? 0;
  bool hasNotificationMinutesBefore() => _notificationMinutesBefore != null;

  // "attendedClasses" field.
  List<DateTime>? _attendedClasses;
  List<DateTime> get attendedClasses => _attendedClasses ?? const [];
  bool hasAttendedClasses() => _attendedClasses != null;

  // "cancelledClasses" field.
  List<DateTime>? _cancelledClasses;
  List<DateTime> get cancelledClasses => _cancelledClasses ?? const [];
  bool hasCancelledClasses() => _cancelledClasses != null;

  // "classAssets" field.
  String? _classAssets;
  String get classAssets => _classAssets ?? '';
  bool hasClassAssets() => _classAssets != null;

  // "courseID" field.
  String? _courseID;
  String get courseID => _courseID ?? '';
  bool hasCourseID() => _courseID != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "lastNotified" field.
  DateTime? _lastNotified;
  DateTime? get lastNotified => _lastNotified;
  bool hasLastNotified() => _lastNotified != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _courseName = snapshotData['courseName'] as String?;
    _courseDescription = snapshotData['courseDescription'] as String?;
    _isCustomSlot = snapshotData['isCustomSlot'] as bool?;
    _slotData = snapshotData['slotData'] is SlotInfoStruct
        ? snapshotData['slotData']
        : SlotInfoStruct.maybeFromMap(snapshotData['slotData']);
    _toggleNotfications = snapshotData['toggleNotfications'] as bool?;
    _notificationMinutesBefore =
        castToType<int>(snapshotData['notificationMinutesBefore']);
    _attendedClasses = getDataList(snapshotData['attendedClasses']);
    _cancelledClasses = getDataList(snapshotData['cancelledClasses']);
    _classAssets = snapshotData['classAssets'] as String?;
    _courseID = snapshotData['courseID'] as String?;
    _isActive = snapshotData['isActive'] as bool?;
    _lastNotified = snapshotData['lastNotified'] as DateTime?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('customClasses')
          : FirebaseFirestore.instance.collectionGroup('customClasses');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('customClasses').doc(id);

  static Stream<CustomClassesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CustomClassesRecord.fromSnapshot(s));

  static Future<CustomClassesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CustomClassesRecord.fromSnapshot(s));

  static CustomClassesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CustomClassesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CustomClassesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CustomClassesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CustomClassesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CustomClassesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCustomClassesRecordData({
  String? courseName,
  String? courseDescription,
  bool? isCustomSlot,
  SlotInfoStruct? slotData,
  bool? toggleNotfications,
  int? notificationMinutesBefore,
  String? classAssets,
  String? courseID,
  bool? isActive,
  DateTime? lastNotified,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'courseName': courseName,
      'courseDescription': courseDescription,
      'isCustomSlot': isCustomSlot,
      'slotData': SlotInfoStruct().toMap(),
      'toggleNotfications': toggleNotfications,
      'notificationMinutesBefore': notificationMinutesBefore,
      'classAssets': classAssets,
      'courseID': courseID,
      'isActive': isActive,
      'lastNotified': lastNotified,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  // Handle nested data for "slotData" field.
  addSlotInfoStructData(firestoreData, slotData, 'slotData');

  return firestoreData;
}

class CustomClassesRecordDocumentEquality
    implements Equality<CustomClassesRecord> {
  const CustomClassesRecordDocumentEquality();

  @override
  bool equals(CustomClassesRecord? e1, CustomClassesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.courseName == e2?.courseName &&
        e1?.courseDescription == e2?.courseDescription &&
        e1?.isCustomSlot == e2?.isCustomSlot &&
        e1?.slotData == e2?.slotData &&
        e1?.toggleNotfications == e2?.toggleNotfications &&
        e1?.notificationMinutesBefore == e2?.notificationMinutesBefore &&
        listEquality.equals(e1?.attendedClasses, e2?.attendedClasses) &&
        listEquality.equals(e1?.cancelledClasses, e2?.cancelledClasses) &&
        e1?.classAssets == e2?.classAssets &&
        e1?.courseID == e2?.courseID &&
        e1?.isActive == e2?.isActive &&
        e1?.lastNotified == e2?.lastNotified &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(CustomClassesRecord? e) => const ListEquality().hash([
        e?.courseName,
        e?.courseDescription,
        e?.isCustomSlot,
        e?.slotData,
        e?.toggleNotfications,
        e?.notificationMinutesBefore,
        e?.attendedClasses,
        e?.cancelledClasses,
        e?.classAssets,
        e?.courseID,
        e?.isActive,
        e?.lastNotified,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is CustomClassesRecord;
}
