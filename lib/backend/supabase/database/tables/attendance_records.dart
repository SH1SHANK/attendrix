import '../database.dart';

class AttendanceRecordsTable extends SupabaseTable<AttendanceRecordsRow> {
  @override
  String get tableName => 'attendanceRecords';

  @override
  AttendanceRecordsRow createRow(Map<String, dynamic> data) =>
      AttendanceRecordsRow(data);
}

class AttendanceRecordsRow extends SupabaseDataRow {
  AttendanceRecordsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AttendanceRecordsTable();

  String get classID => getField<String>('classID')!;
  set classID(String value) => setField<String>('classID', value);

  DateTime get checkinTime => getField<DateTime>('checkinTime')!;
  set checkinTime(DateTime value) => setField<DateTime>('checkinTime', value);

  String? get courseID => getField<String>('courseID');
  set courseID(String? value) => setField<String>('courseID', value);

  String get userID => getField<String>('userID')!;
  set userID(String value) => setField<String>('userID', value);

  DateTime? get classTime => getField<DateTime>('classTime');
  set classTime(DateTime? value) => setField<DateTime>('classTime', value);

  String get rowID => getField<String>('rowID')!;
  set rowID(String value) => setField<String>('rowID', value);
}
