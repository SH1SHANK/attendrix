import '../database.dart';

class TimetableSubscriptionsTable
    extends SupabaseTable<TimetableSubscriptionsRow> {
  @override
  String get tableName => 'timetable_subscriptions';

  @override
  TimetableSubscriptionsRow createRow(Map<String, dynamic> data) =>
      TimetableSubscriptionsRow(data);
}

class TimetableSubscriptionsRow extends SupabaseDataRow {
  TimetableSubscriptionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TimetableSubscriptionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get userRef => getField<String>('user_ref')!;
  set userRef(String value) => setField<String>('user_ref', value);

  String get courseId => getField<String>('course_id')!;
  set courseId(String value) => setField<String>('course_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  int? get minutesbeforeclass => getField<int>('minutesbeforeclass');
  set minutesbeforeclass(int? value) =>
      setField<int>('minutesbeforeclass', value);
}
