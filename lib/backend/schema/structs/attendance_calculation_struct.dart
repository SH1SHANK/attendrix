// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class AttendanceCalculationStruct extends FFFirebaseStruct {
  AttendanceCalculationStruct({
    int? attendedClasses,
    int? totalClasses,
    double? attendancePercent,
    String? attendanceRemark,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _attendedClasses = attendedClasses,
        _totalClasses = totalClasses,
        _attendancePercent = attendancePercent,
        _attendanceRemark = attendanceRemark,
        super(firestoreUtilData);

  // "attendedClasses" field.
  int? _attendedClasses;
  int get attendedClasses => _attendedClasses ?? 0;
  set attendedClasses(int? val) => _attendedClasses = val;

  void incrementAttendedClasses(int amount) =>
      attendedClasses = attendedClasses + amount;

  bool hasAttendedClasses() => _attendedClasses != null;

  // "totalClasses" field.
  int? _totalClasses;
  int get totalClasses => _totalClasses ?? 0;
  set totalClasses(int? val) => _totalClasses = val;

  void incrementTotalClasses(int amount) =>
      totalClasses = totalClasses + amount;

  bool hasTotalClasses() => _totalClasses != null;

  // "attendancePercent" field.
  double? _attendancePercent;
  double get attendancePercent => _attendancePercent ?? 0.0;
  set attendancePercent(double? val) => _attendancePercent = val;

  void incrementAttendancePercent(double amount) =>
      attendancePercent = attendancePercent + amount;

  bool hasAttendancePercent() => _attendancePercent != null;

  // "attendanceRemark" field.
  String? _attendanceRemark;
  String get attendanceRemark => _attendanceRemark ?? '';
  set attendanceRemark(String? val) => _attendanceRemark = val;

  bool hasAttendanceRemark() => _attendanceRemark != null;

  static AttendanceCalculationStruct fromMap(Map<String, dynamic> data) =>
      AttendanceCalculationStruct(
        attendedClasses: castToType<int>(data['attendedClasses']),
        totalClasses: castToType<int>(data['totalClasses']),
        attendancePercent: castToType<double>(data['attendancePercent']),
        attendanceRemark: data['attendanceRemark'] as String?,
      );

  static AttendanceCalculationStruct? maybeFromMap(dynamic data) => data is Map
      ? AttendanceCalculationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'attendedClasses': _attendedClasses,
        'totalClasses': _totalClasses,
        'attendancePercent': _attendancePercent,
        'attendanceRemark': _attendanceRemark,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'attendedClasses': serializeParam(
          _attendedClasses,
          ParamType.int,
        ),
        'totalClasses': serializeParam(
          _totalClasses,
          ParamType.int,
        ),
        'attendancePercent': serializeParam(
          _attendancePercent,
          ParamType.double,
        ),
        'attendanceRemark': serializeParam(
          _attendanceRemark,
          ParamType.String,
        ),
      }.withoutNulls;

  static AttendanceCalculationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      AttendanceCalculationStruct(
        attendedClasses: deserializeParam(
          data['attendedClasses'],
          ParamType.int,
          false,
        ),
        totalClasses: deserializeParam(
          data['totalClasses'],
          ParamType.int,
          false,
        ),
        attendancePercent: deserializeParam(
          data['attendancePercent'],
          ParamType.double,
          false,
        ),
        attendanceRemark: deserializeParam(
          data['attendanceRemark'],
          ParamType.String,
          false,
        ),
      );

  static AttendanceCalculationStruct fromAlgoliaData(
          Map<String, dynamic> data) =>
      AttendanceCalculationStruct(
        attendedClasses: convertAlgoliaParam(
          data['attendedClasses'],
          ParamType.int,
          false,
        ),
        totalClasses: convertAlgoliaParam(
          data['totalClasses'],
          ParamType.int,
          false,
        ),
        attendancePercent: convertAlgoliaParam(
          data['attendancePercent'],
          ParamType.double,
          false,
        ),
        attendanceRemark: convertAlgoliaParam(
          data['attendanceRemark'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'AttendanceCalculationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AttendanceCalculationStruct &&
        attendedClasses == other.attendedClasses &&
        totalClasses == other.totalClasses &&
        attendancePercent == other.attendancePercent &&
        attendanceRemark == other.attendanceRemark;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [attendedClasses, totalClasses, attendancePercent, attendanceRemark]);
}

AttendanceCalculationStruct createAttendanceCalculationStruct({
  int? attendedClasses,
  int? totalClasses,
  double? attendancePercent,
  String? attendanceRemark,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AttendanceCalculationStruct(
      attendedClasses: attendedClasses,
      totalClasses: totalClasses,
      attendancePercent: attendancePercent,
      attendanceRemark: attendanceRemark,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AttendanceCalculationStruct? updateAttendanceCalculationStruct(
  AttendanceCalculationStruct? attendanceCalculation, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    attendanceCalculation
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAttendanceCalculationStructData(
  Map<String, dynamic> firestoreData,
  AttendanceCalculationStruct? attendanceCalculation,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (attendanceCalculation == null) {
    return;
  }
  if (attendanceCalculation.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      attendanceCalculation.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final attendanceCalculationData = getAttendanceCalculationFirestoreData(
      attendanceCalculation, forFieldValue);
  final nestedData =
      attendanceCalculationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      attendanceCalculation.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAttendanceCalculationFirestoreData(
  AttendanceCalculationStruct? attendanceCalculation, [
  bool forFieldValue = false,
]) {
  if (attendanceCalculation == null) {
    return {};
  }
  final firestoreData = mapToFirestore(attendanceCalculation.toMap());

  // Add any Firestore field values
  attendanceCalculation.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAttendanceCalculationListFirestoreData(
  List<AttendanceCalculationStruct>? attendanceCalculations,
) =>
    attendanceCalculations
        ?.map((e) => getAttendanceCalculationFirestoreData(e, true))
        .toList() ??
    [];
