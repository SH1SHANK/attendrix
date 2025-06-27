import '../database.dart';

class BatchRecordsTable extends SupabaseTable<BatchRecordsRow> {
  @override
  String get tableName => 'batchRecords';

  @override
  BatchRecordsRow createRow(Map<String, dynamic> data) => BatchRecordsRow(data);
}

class BatchRecordsRow extends SupabaseDataRow {
  BatchRecordsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => BatchRecordsTable();

  String get batchID => getField<String>('batchID')!;
  set batchID(String value) => setField<String>('batchID', value);

  String get batchCode => getField<String>('batchCode')!;
  set batchCode(String value) => setField<String>('batchCode', value);

  int? get semester => getField<int>('semester');
  set semester(int? value) => setField<int>('semester', value);

  String? get slot => getField<String>('slot');
  set slot(String? value) => setField<String>('slot', value);

  List<String> get courseCatalog => getListField<String>('courseCatalog');
  set courseCatalog(List<String>? value) =>
      setListField<String>('courseCatalog', value);

  int? get enrolledStudents => getField<int>('enrolledStudents');
  set enrolledStudents(int? value) => setField<int>('enrolledStudents', value);

  dynamic get enrolledStudentsMetadata =>
      getField<dynamic>('enrolledStudentsMetadata');
  set enrolledStudentsMetadata(dynamic value) =>
      setField<dynamic>('enrolledStudentsMetadata', value);

  int? get enrollmentCapacity => getField<int>('enrollmentCapacity');
  set enrollmentCapacity(int? value) =>
      setField<int>('enrollmentCapacity', value);

  List<String> get electiveCatalog => getListField<String>('electiveCatalog');
  set electiveCatalog(List<String>? value) =>
      setListField<String>('electiveCatalog', value);
}
