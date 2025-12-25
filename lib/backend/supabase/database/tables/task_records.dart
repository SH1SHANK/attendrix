import '../database.dart';

class TaskRecordsTable extends SupabaseTable<TaskRecordsRow> {
  @override
  String get tableName => 'taskRecords';

  @override
  TaskRecordsRow createRow(Map<String, dynamic> data) => TaskRecordsRow(data);
}

class TaskRecordsRow extends SupabaseDataRow {
  TaskRecordsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TaskRecordsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get courseID => getField<String>('courseID')!;
  set courseID(String value) => setField<String>('courseID', value);

  String get taskType => getField<String>('taskType')!;
  set taskType(String value) => setField<String>('taskType', value);

  String? get taskName => getField<String>('taskName');
  set taskName(String? value) => setField<String>('taskName', value);

  String? get taskDescription => getField<String>('taskDescription');
  set taskDescription(String? value) =>
      setField<String>('taskDescription', value);

  DateTime? get taskDueDate => getField<DateTime>('taskDueDate');
  set taskDueDate(DateTime? value) => setField<DateTime>('taskDueDate', value);

  DateTime? get taskStartTime => getField<DateTime>('taskStartTime');
  set taskStartTime(DateTime? value) =>
      setField<DateTime>('taskStartTime', value);

  DateTime? get taskEndTime => getField<DateTime>('taskEndTime');
  set taskEndTime(DateTime? value) => setField<DateTime>('taskEndTime', value);

  String? get taskAssets => getField<String>('taskAssets');
  set taskAssets(String? value) => setField<String>('taskAssets', value);

  int? get maxScore => getField<int>('maxScore');
  set maxScore(int? value) => setField<int>('maxScore', value);

  String? get taskVenue => getField<String>('taskVenue');
  set taskVenue(String? value) => setField<String>('taskVenue', value);

  String? get additionalInfo => getField<String>('additional_info');
  set additionalInfo(String? value) =>
      setField<String>('additional_info', value);
}
