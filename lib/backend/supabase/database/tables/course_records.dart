import '../database.dart';

class CourseRecordsTable extends SupabaseTable<CourseRecordsRow> {
  @override
  String get tableName => 'courseRecords';

  @override
  CourseRecordsRow createRow(Map<String, dynamic> data) =>
      CourseRecordsRow(data);
}

class CourseRecordsRow extends SupabaseDataRow {
  CourseRecordsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CourseRecordsTable();

  String get courseID => getField<String>('courseID')!;
  set courseID(String value) => setField<String>('courseID', value);

  int get semesterID => getField<int>('semesterID')!;
  set semesterID(int value) => setField<int>('semesterID', value);

  String? get courseName => getField<String>('courseName');
  set courseName(String? value) => setField<String>('courseName', value);

  int? get credits => getField<int>('credits');
  set credits(int? value) => setField<int>('credits', value);

  String? get syllabusAssets => getField<String>('syllabusAssets');
  set syllabusAssets(String? value) =>
      setField<String>('syllabusAssets', value);

  dynamic get courseType => getField<dynamic>('courseType');
  set courseType(dynamic value) => setField<dynamic>('courseType', value);

  bool get isElective => getField<bool>('isElective')!;
  set isElective(bool value) => setField<bool>('isElective', value);

  List<String> get electiveScope => getListField<String>('electiveScope');
  set electiveScope(List<String>? value) =>
      setListField<String>('electiveScope', value);

  int get enrolledStudents => getField<int>('enrolledStudents')!;
  set enrolledStudents(int value) => setField<int>('enrolledStudents', value);

  String? get departmentId => getField<String>('department_id');
  set departmentId(String? value) => setField<String>('department_id', value);
}
