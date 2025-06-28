import '../database.dart';

class AdminusersTable extends SupabaseTable<AdminusersRow> {
  @override
  String get tableName => 'adminusers';

  @override
  AdminusersRow createRow(Map<String, dynamic> data) => AdminusersRow(data);
}

class AdminusersRow extends SupabaseDataRow {
  AdminusersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AdminusersTable();

  String get userid => getField<String>('userid')!;
  set userid(String value) => setField<String>('userid', value);

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);

  String get admincode => getField<String>('admincode')!;
  set admincode(String value) => setField<String>('admincode', value);

  DateTime? get createdat => getField<DateTime>('createdat');
  set createdat(DateTime? value) => setField<DateTime>('createdat', value);
}
