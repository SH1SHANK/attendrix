import '../database.dart';

class AmplixLogsTable extends SupabaseTable<AmplixLogsRow> {
  @override
  String get tableName => 'amplixLogs';

  @override
  AmplixLogsRow createRow(Map<String, dynamic> data) => AmplixLogsRow(data);
}

class AmplixLogsRow extends SupabaseDataRow {
  AmplixLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AmplixLogsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get lastUpdatedAt => getField<DateTime>('lastUpdatedAt')!;
  set lastUpdatedAt(DateTime value) =>
      setField<DateTime>('lastUpdatedAt', value);

  String? get userID => getField<String>('userID');
  set userID(String? value) => setField<String>('userID', value);

  String? get classID => getField<String>('classID');
  set classID(String? value) => setField<String>('classID', value);

  String? get classDate => getField<String>('classDate');
  set classDate(String? value) => setField<String>('classDate', value);

  int? get amplixObtained => getField<int>('amplixObtained');
  set amplixObtained(int? value) => setField<int>('amplixObtained', value);

  String? get source => getField<String>('source');
  set source(String? value) => setField<String>('source', value);

  bool? get fullDayAttendance => getField<bool>('full_day_attendance');
  set fullDayAttendance(bool? value) =>
      setField<bool>('full_day_attendance', value);

  int get currentAmplixScore => getField<int>('currentAmplixScore')!;
  set currentAmplixScore(int value) =>
      setField<int>('currentAmplixScore', value);
}
