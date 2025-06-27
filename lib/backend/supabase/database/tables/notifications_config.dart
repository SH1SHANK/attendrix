import '../database.dart';

class NotificationsConfigTable extends SupabaseTable<NotificationsConfigRow> {
  @override
  String get tableName => 'notifications_config';

  @override
  NotificationsConfigRow createRow(Map<String, dynamic> data) =>
      NotificationsConfigRow(data);
}

class NotificationsConfigRow extends SupabaseDataRow {
  NotificationsConfigRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => NotificationsConfigTable();

  String get courseId => getField<String>('course_id')!;
  set courseId(String value) => setField<String>('course_id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  dynamic get slotData => getField<dynamic>('slot_data')!;
  set slotData(dynamic value) => setField<dynamic>('slot_data', value);

  bool get toggleNotifications => getField<bool>('toggle_notifications')!;
  set toggleNotifications(bool value) =>
      setField<bool>('toggle_notifications', value);

  int get minutesBeforeClass => getField<int>('minutes_before_class')!;
  set minutesBeforeClass(int value) =>
      setField<int>('minutes_before_class', value);

  List<DateTime> get cancelledDates =>
      getListField<DateTime>('cancelled_dates');
  set cancelledDates(List<DateTime>? value) =>
      setListField<DateTime>('cancelled_dates', value);

  DateTime? get lastNotified => getField<DateTime>('last_notified');
  set lastNotified(DateTime? value) =>
      setField<DateTime>('last_notified', value);

  bool get isActive => getField<bool>('is_active')!;
  set isActive(bool value) => setField<bool>('is_active', value);

  String? get className => getField<String>('class_name');
  set className(String? value) => setField<String>('class_name', value);

  String get username => getField<String>('username')!;
  set username(String value) => setField<String>('username', value);
}
