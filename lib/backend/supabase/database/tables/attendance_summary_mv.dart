import '../database.dart';

class AttendanceSummaryMvTable extends SupabaseTable<AttendanceSummaryMvRow> {
  @override
  String get tableName => 'attendance_summary_mv';

  @override
  AttendanceSummaryMvRow createRow(Map<String, dynamic> data) =>
      AttendanceSummaryMvRow(data);
}

class AttendanceSummaryMvRow extends SupabaseDataRow {
  AttendanceSummaryMvRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AttendanceSummaryMvTable();

  String? get userID => getField<String>('userID');
  set userID(String? value) => setField<String>('userID', value);

  String? get courseID => getField<String>('courseID');
  set courseID(String? value) => setField<String>('courseID', value);

  String? get courseName => getField<String>('course_name');
  set courseName(String? value) => setField<String>('course_name', value);

  DateTime? get classDate => getField<DateTime>('class_date');
  set classDate(DateTime? value) => setField<DateTime>('class_date', value);

  int? get dailyTotalClasses => getField<int>('daily_total_classes');
  set dailyTotalClasses(int? value) =>
      setField<int>('daily_total_classes', value);

  int? get dailyAttendedClasses => getField<int>('daily_attended_classes');
  set dailyAttendedClasses(int? value) =>
      setField<int>('daily_attended_classes', value);

  dynamic get dailyCheckinInfo => getField<dynamic>('daily_checkin_info');
  set dailyCheckinInfo(dynamic value) =>
      setField<dynamic>('daily_checkin_info', value);

  String? get dailyStatus => getField<String>('daily_status');
  set dailyStatus(String? value) => setField<String>('daily_status', value);

  int? get runningTotalClasses => getField<int>('running_total_classes');
  set runningTotalClasses(int? value) =>
      setField<int>('running_total_classes', value);

  int? get runningAttendedClasses => getField<int>('running_attended_classes');
  set runningAttendedClasses(int? value) =>
      setField<int>('running_attended_classes', value);

  double? get runningPercentage => getField<double>('running_percentage');
  set runningPercentage(double? value) =>
      setField<double>('running_percentage', value);

  bool? get in7d => getField<bool>('in_7d');
  set in7d(bool? value) => setField<bool>('in_7d', value);

  bool? get in14d => getField<bool>('in_14d');
  set in14d(bool? value) => setField<bool>('in_14d', value);

  bool? get in30d => getField<bool>('in_30d');
  set in30d(bool? value) => setField<bool>('in_30d', value);

  bool? get in90d => getField<bool>('in_90d');
  set in90d(bool? value) => setField<bool>('in_90d', value);
}
