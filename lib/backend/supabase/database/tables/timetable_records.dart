import '../database.dart';

class TimetableRecordsTable extends SupabaseTable<TimetableRecordsRow> {
  @override
  String get tableName => 'timetableRecords';

  @override
  TimetableRecordsRow createRow(Map<String, dynamic> data) =>
      TimetableRecordsRow(data);
}

class TimetableRecordsRow extends SupabaseDataRow {
  TimetableRecordsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TimetableRecordsTable();

  String get classID => getField<String>('classID')!;
  set classID(String value) => setField<String>('classID', value);

  String get courseID => getField<String>('courseID')!;
  set courseID(String value) => setField<String>('courseID', value);

  String? get batchID => getField<String>('batchID');
  set batchID(String? value) => setField<String>('batchID', value);

  DateTime? get createdTime => getField<DateTime>('createdTime');
  set createdTime(DateTime? value) => setField<DateTime>('createdTime', value);

  String? get courseName => getField<String>('courseName');
  set courseName(String? value) => setField<String>('courseName', value);

  DateTime? get classStartTime => getField<DateTime>('classStartTime');
  set classStartTime(DateTime? value) =>
      setField<DateTime>('classStartTime', value);

  DateTime? get classEndTime => getField<DateTime>('classEndTime');
  set classEndTime(DateTime? value) =>
      setField<DateTime>('classEndTime', value);

  bool? get isPlusSlot => getField<bool>('isPlusSlot');
  set isPlusSlot(bool? value) => setField<bool>('isPlusSlot', value);

  dynamic get courseType => getField<dynamic>('courseType');
  set courseType(dynamic value) => setField<dynamic>('courseType', value);

  dynamic get classStatus => getField<dynamic>('classStatus');
  set classStatus(dynamic value) => setField<dynamic>('classStatus', value);

  String? get classVenue => getField<String>('classVenue');
  set classVenue(String? value) => setField<String>('classVenue', value);

  String? get classDate => getField<String>('classDate');
  set classDate(String? value) => setField<String>('classDate', value);
}
