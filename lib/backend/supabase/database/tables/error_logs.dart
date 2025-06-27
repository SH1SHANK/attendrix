import '../database.dart';

class ErrorLogsTable extends SupabaseTable<ErrorLogsRow> {
  @override
  String get tableName => 'error_logs';

  @override
  ErrorLogsRow createRow(Map<String, dynamic> data) => ErrorLogsRow(data);
}

class ErrorLogsRow extends SupabaseDataRow {
  ErrorLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ErrorLogsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get userID => getField<String>('userID');
  set userID(String? value) => setField<String>('userID', value);

  String get errorMessage => getField<String>('error_message')!;
  set errorMessage(String value) => setField<String>('error_message', value);

  DateTime? get timestamp => getField<DateTime>('timestamp');
  set timestamp(DateTime? value) => setField<DateTime>('timestamp', value);
}
