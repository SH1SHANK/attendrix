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

  final _taskArchivesManager =
      StreamRequestManager<List<PersonalRecordsRecord>>();
  Stream<List<PersonalRecordsRecord>> taskArchives({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<PersonalRecordsRecord>> Function() requestFn,
  }) =>
      _taskArchivesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTaskArchivesCache() => _taskArchivesManager.clear();
  void clearTaskArchivesCacheKey(String? uniqueKey) =>
      _taskArchivesManager.clearRequest(uniqueKey);

  final _timetableQueryIndividualManager =
      FutureRequestManager<List<TimetableRecordsRow>>();
  Future<List<TimetableRecordsRow>> timetableQueryIndividual({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TimetableRecordsRow>> Function() requestFn,
  }) =>
      _timetableQueryIndividualManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTimetableQueryIndividualCache() =>
      _timetableQueryIndividualManager.clear();
  void clearTimetableQueryIndividualCacheKey(String? uniqueKey) =>
      _timetableQueryIndividualManager.clearRequest(uniqueKey);

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

  final _tasksQueryManager = FutureRequestManager<List<TaskRecordsRow>>();
  Future<List<TaskRecordsRow>> tasksQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TaskRecordsRow>> Function() requestFn,
  }) =>
      _tasksQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTasksQueryCache() => _tasksQueryManager.clear();
  void clearTasksQueryCacheKey(String? uniqueKey) =>
      _tasksQueryManager.clearRequest(uniqueKey);
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
