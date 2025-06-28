import '../database.dart';

class PendingadminrequestsTable extends SupabaseTable<PendingadminrequestsRow> {
  @override
  String get tableName => 'pendingadminrequests';

  @override
  PendingadminrequestsRow createRow(Map<String, dynamic> data) =>
      PendingadminrequestsRow(data);
}

class PendingadminrequestsRow extends SupabaseDataRow {
  PendingadminrequestsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PendingadminrequestsTable();

  String get userid => getField<String>('userid')!;
  set userid(String value) => setField<String>('userid', value);

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);

  DateTime? get requestedat => getField<DateTime>('requestedat');
  set requestedat(DateTime? value) => setField<DateTime>('requestedat', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);
}
