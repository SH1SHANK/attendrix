import '../database.dart';

class ClassNotificationLogTable extends SupabaseTable<ClassNotificationLogRow> {
  @override
  String get tableName => 'class_notification_log';

  @override
  ClassNotificationLogRow createRow(Map<String, dynamic> data) =>
      ClassNotificationLogRow(data);
}

class ClassNotificationLogRow extends SupabaseDataRow {
  ClassNotificationLogRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ClassNotificationLogTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get classId => getField<String>('class_id')!;
  set classId(String value) => setField<String>('class_id', value);

  String get userRef => getField<String>('user_ref')!;
  set userRef(String value) => setField<String>('user_ref', value);

  DateTime? get sentAt => getField<DateTime>('sent_at');
  set sentAt(DateTime? value) => setField<DateTime>('sent_at', value);
}
