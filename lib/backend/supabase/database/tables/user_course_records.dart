import '../database.dart';

class UserCourseRecordsTable extends SupabaseTable<UserCourseRecordsRow> {
  @override
  String get tableName => 'userCourseRecords';

  @override
  UserCourseRecordsRow createRow(Map<String, dynamic> data) =>
      UserCourseRecordsRow(data);
}

class UserCourseRecordsRow extends SupabaseDataRow {
  UserCourseRecordsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserCourseRecordsTable();

  String get userID => getField<String>('userID')!;
  set userID(String value) => setField<String>('userID', value);

  String get batchID => getField<String>('batchID')!;
  set batchID(String value) => setField<String>('batchID', value);

  int get semesterID => getField<int>('semesterID')!;
  set semesterID(int value) => setField<int>('semesterID', value);

  dynamic get enrolledCourses => getField<dynamic>('enrolledCourses')!;
  set enrolledCourses(dynamic value) =>
      setField<dynamic>('enrolledCourses', value);

  DateTime? get lastUpdated => getField<DateTime>('lastUpdated');
  set lastUpdated(DateTime? value) => setField<DateTime>('lastUpdated', value);
}
