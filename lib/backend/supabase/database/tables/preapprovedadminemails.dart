import '../database.dart';

class PreapprovedadminemailsTable
    extends SupabaseTable<PreapprovedadminemailsRow> {
  @override
  String get tableName => 'preapprovedadminemails';

  @override
  PreapprovedadminemailsRow createRow(Map<String, dynamic> data) =>
      PreapprovedadminemailsRow(data);
}

class PreapprovedadminemailsRow extends SupabaseDataRow {
  PreapprovedadminemailsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PreapprovedadminemailsTable();

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);
}
