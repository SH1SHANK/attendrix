import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import 'backend/supabase/supabase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _semesterStartDate =
          await secureStorage.read(key: 'ff_semesterStartDate') != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  (await secureStorage.getInt('ff_semesterStartDate'))!)
              : _semesterStartDate;
    });
    await _safeInitAsync(() async {
      _GOOGLEDRIVEAPIKEY =
          await secureStorage.getString('ff_GOOGLEDRIVEAPIKEY') ??
              _GOOGLEDRIVEAPIKEY;
    });
    await _safeInitAsync(() async {
      _weatherForecastForMessages =
          await secureStorage.getBool('ff_weatherForecastForMessages') ??
              _weatherForecastForMessages;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _greetingMessageForUser = '';
  String get greetingMessageForUser => _greetingMessageForUser;
  set greetingMessageForUser(String value) {
    _greetingMessageForUser = value;
  }

  String _shortGreetingMessageForUser = '';
  String get shortGreetingMessageForUser => _shortGreetingMessageForUser;
  set shortGreetingMessageForUser(String value) {
    _shortGreetingMessageForUser = value;
  }

  DateTime? _semesterStartDate =
      DateTime.fromMillisecondsSinceEpoch(1746037800000);
  DateTime? get semesterStartDate => _semesterStartDate;
  set semesterStartDate(DateTime? value) {
    _semesterStartDate = value;
    value != null
        ? secureStorage.setInt(
            'ff_semesterStartDate', value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_semesterStartDate');
  }

  void deleteSemesterStartDate() {
    secureStorage.delete(key: 'ff_semesterStartDate');
  }

  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;
  set isDownloading(bool value) {
    _isDownloading = value;
  }

  String _GOOGLEDRIVEAPIKEY = '';
  String get GOOGLEDRIVEAPIKEY => _GOOGLEDRIVEAPIKEY;
  set GOOGLEDRIVEAPIKEY(String value) {
    _GOOGLEDRIVEAPIKEY = value;
    secureStorage.setString('ff_GOOGLEDRIVEAPIKEY', value);
  }

  void deleteGOOGLEDRIVEAPIKEY() {
    secureStorage.delete(key: 'ff_GOOGLEDRIVEAPIKEY');
  }

  List<ClassRowStruct> _customClasses = [];
  List<ClassRowStruct> get customClasses => _customClasses;
  set customClasses(List<ClassRowStruct> value) {
    _customClasses = value;
  }

  void addToCustomClasses(ClassRowStruct value) {
    customClasses.add(value);
  }

  void removeFromCustomClasses(ClassRowStruct value) {
    customClasses.remove(value);
  }

  void removeAtIndexFromCustomClasses(int index) {
    customClasses.removeAt(index);
  }

  void updateCustomClassesAtIndex(
    int index,
    ClassRowStruct Function(ClassRowStruct) updateFn,
  ) {
    customClasses[index] = updateFn(_customClasses[index]);
  }

  void insertAtIndexInCustomClasses(int index, ClassRowStruct value) {
    customClasses.insert(index, value);
  }

  bool _weatherForecastForMessages = true;
  bool get weatherForecastForMessages => _weatherForecastForMessages;
  set weatherForecastForMessages(bool value) {
    _weatherForecastForMessages = value;
    secureStorage.setBool('ff_weatherForecastForMessages', value);
  }

  void deleteWeatherForecastForMessages() {
    secureStorage.delete(key: 'ff_weatherForecastForMessages');
  }

  List<String> _updateCacheFor = [];
  List<String> get updateCacheFor => _updateCacheFor;
  set updateCacheFor(List<String> value) {
    _updateCacheFor = value;
  }

  void addToUpdateCacheFor(String value) {
    updateCacheFor.add(value);
  }

  void removeFromUpdateCacheFor(String value) {
    updateCacheFor.remove(value);
  }

  void removeAtIndexFromUpdateCacheFor(int index) {
    updateCacheFor.removeAt(index);
  }

  void updateUpdateCacheForAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    updateCacheFor[index] = updateFn(_updateCacheFor[index]);
  }

  void insertAtIndexInUpdateCacheFor(int index, String value) {
    updateCacheFor.insert(index, value);
  }

  final _timetableRecordsQueryDayManager =
      FutureRequestManager<List<TimetableRecordsRow>>();
  Future<List<TimetableRecordsRow>> timetableRecordsQueryDay({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TimetableRecordsRow>> Function() requestFn,
  }) =>
      _timetableRecordsQueryDayManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTimetableRecordsQueryDayCache() =>
      _timetableRecordsQueryDayManager.clear();
  void clearTimetableRecordsQueryDayCacheKey(String? uniqueKey) =>
      _timetableRecordsQueryDayManager.clearRequest(uniqueKey);

  final _userPersonalFilesManager =
      FutureRequestManager<List<UserPersonalVaultRecord>>();
  Future<List<UserPersonalVaultRecord>> userPersonalFiles({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UserPersonalVaultRecord>> Function() requestFn,
  }) =>
      _userPersonalFilesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserPersonalFilesCache() => _userPersonalFilesManager.clear();
  void clearUserPersonalFilesCacheKey(String? uniqueKey) =>
      _userPersonalFilesManager.clearRequest(uniqueKey);

  final _individualCustomClassViaCourseIDManager =
      StreamRequestManager<List<CustomClassesRecord>>();
  Stream<List<CustomClassesRecord>> individualCustomClassViaCourseID({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<CustomClassesRecord>> Function() requestFn,
  }) =>
      _individualCustomClassViaCourseIDManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIndividualCustomClassViaCourseIDCache() =>
      _individualCustomClassViaCourseIDManager.clear();
  void clearIndividualCustomClassViaCourseIDCacheKey(String? uniqueKey) =>
      _individualCustomClassViaCourseIDManager.clearRequest(uniqueKey);

  final _tasksQueryManager = StreamRequestManager<List<TaskRecordsRow>>();
  Stream<List<TaskRecordsRow>> tasksQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TaskRecordsRow>> Function() requestFn,
  }) =>
      _tasksQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTasksQueryCache() => _tasksQueryManager.clear();
  void clearTasksQueryCacheKey(String? uniqueKey) =>
      _tasksQueryManager.clearRequest(uniqueKey);

  final _individualAttendanceRecordManager =
      FutureRequestManager<List<AttendanceRecordsRow>>();
  Future<List<AttendanceRecordsRow>> individualAttendanceRecord({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<AttendanceRecordsRow>> Function() requestFn,
  }) =>
      _individualAttendanceRecordManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIndividualAttendanceRecordCache() =>
      _individualAttendanceRecordManager.clear();
  void clearIndividualAttendanceRecordCacheKey(String? uniqueKey) =>
      _individualAttendanceRecordManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
