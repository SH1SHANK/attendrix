import '../database.dart';

class HolidayrecordsTable extends SupabaseTable<HolidayrecordsRow> {
  @override
  String get tableName => 'holidayrecords';

  @override
  HolidayrecordsRow createRow(Map<String, dynamic> data) =>
      HolidayrecordsRow(data);
}

class HolidayrecordsRow extends SupabaseDataRow {
  HolidayrecordsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => HolidayrecordsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int get date => getField<int>('date')!;
  set date(int value) => setField<int>('date', value);

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  bool get isfullday => getField<bool>('isfullday')!;
  set isfullday(bool value) => setField<bool>('isfullday', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get timestamp => getField<String>('timestamp');
  set timestamp(String? value) => setField<String>('timestamp', value);
}
