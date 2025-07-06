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
    await _safeInitAsync(() async {
      _missedClasses = (await secureStorage.getStringList('ff_missedClasses'))
              ?.map((x) {
                try {
                  return ClassRowStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _missedClasses;
    });
    await _safeInitAsync(() async {
      _customClassesCurrentDay =
          (await secureStorage.getStringList('ff_customClassesCurrentDay'))
                  ?.map((x) {
                    try {
                      return ClassRowStruct.fromSerializableMap(jsonDecode(x));
                    } catch (e) {
                      print("Can't decode persisted data type. Error: $e.");
                      return null;
                    }
                  })
                  .withoutNulls
                  .toList() ??
              _customClassesCurrentDay;
    });
    await _safeInitAsync(() async {
      _customClassesAlldays =
          (await secureStorage.getStringList('ff_customClassesAlldays'))
                  ?.map((x) {
                    try {
                      return ClassRowStruct.fromSerializableMap(jsonDecode(x));
                    } catch (e) {
                      print("Can't decode persisted data type. Error: $e.");
                      return null;
                    }
                  })
                  .withoutNulls
                  .toList() ??
              _customClassesAlldays;
    });
    await _safeInitAsync(() async {
      _customClassesLastUpdatedAt = await secureStorage.read(
                  key: 'ff_customClassesLastUpdatedAt') !=
              null
          ? DateTime.fromMillisecondsSinceEpoch(
              (await secureStorage.getInt('ff_customClassesLastUpdatedAt'))!)
          : _customClassesLastUpdatedAt;
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

  String _GOOGLEDRIVEAPIKEY = 'AIzaSyC_5H7NooWPBIZOe8XOwkwxieUF6yXNOT0';
  String get GOOGLEDRIVEAPIKEY => _GOOGLEDRIVEAPIKEY;
  set GOOGLEDRIVEAPIKEY(String value) {
    _GOOGLEDRIVEAPIKEY = value;
    secureStorage.setString('ff_GOOGLEDRIVEAPIKEY', value);
  }

  void deleteGOOGLEDRIVEAPIKEY() {
    secureStorage.delete(key: 'ff_GOOGLEDRIVEAPIKEY');
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

  List<ClassRowStruct> _missedClasses = [];
  List<ClassRowStruct> get missedClasses => _missedClasses;
  set missedClasses(List<ClassRowStruct> value) {
    _missedClasses = value;
    secureStorage.setStringList(
        'ff_missedClasses', value.map((x) => x.serialize()).toList());
  }

  void deleteMissedClasses() {
    secureStorage.delete(key: 'ff_missedClasses');
  }

  void addToMissedClasses(ClassRowStruct value) {
    missedClasses.add(value);
    secureStorage.setStringList(
        'ff_missedClasses', _missedClasses.map((x) => x.serialize()).toList());
  }

  void removeFromMissedClasses(ClassRowStruct value) {
    missedClasses.remove(value);
    secureStorage.setStringList(
        'ff_missedClasses', _missedClasses.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMissedClasses(int index) {
    missedClasses.removeAt(index);
    secureStorage.setStringList(
        'ff_missedClasses', _missedClasses.map((x) => x.serialize()).toList());
  }

  void updateMissedClassesAtIndex(
    int index,
    ClassRowStruct Function(ClassRowStruct) updateFn,
  ) {
    missedClasses[index] = updateFn(_missedClasses[index]);
    secureStorage.setStringList(
        'ff_missedClasses', _missedClasses.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMissedClasses(int index, ClassRowStruct value) {
    missedClasses.insert(index, value);
    secureStorage.setStringList(
        'ff_missedClasses', _missedClasses.map((x) => x.serialize()).toList());
  }

  List<ClassRowStruct> _customClassesCurrentDay = [];
  List<ClassRowStruct> get customClassesCurrentDay => _customClassesCurrentDay;
  set customClassesCurrentDay(List<ClassRowStruct> value) {
    _customClassesCurrentDay = value;
    secureStorage.setStringList(
        'ff_customClassesCurrentDay', value.map((x) => x.serialize()).toList());
  }

  void deleteCustomClassesCurrentDay() {
    secureStorage.delete(key: 'ff_customClassesCurrentDay');
  }

  void addToCustomClassesCurrentDay(ClassRowStruct value) {
    customClassesCurrentDay.add(value);
    secureStorage.setStringList('ff_customClassesCurrentDay',
        _customClassesCurrentDay.map((x) => x.serialize()).toList());
  }

  void removeFromCustomClassesCurrentDay(ClassRowStruct value) {
    customClassesCurrentDay.remove(value);
    secureStorage.setStringList('ff_customClassesCurrentDay',
        _customClassesCurrentDay.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromCustomClassesCurrentDay(int index) {
    customClassesCurrentDay.removeAt(index);
    secureStorage.setStringList('ff_customClassesCurrentDay',
        _customClassesCurrentDay.map((x) => x.serialize()).toList());
  }

  void updateCustomClassesCurrentDayAtIndex(
    int index,
    ClassRowStruct Function(ClassRowStruct) updateFn,
  ) {
    customClassesCurrentDay[index] = updateFn(_customClassesCurrentDay[index]);
    secureStorage.setStringList('ff_customClassesCurrentDay',
        _customClassesCurrentDay.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInCustomClassesCurrentDay(int index, ClassRowStruct value) {
    customClassesCurrentDay.insert(index, value);
    secureStorage.setStringList('ff_customClassesCurrentDay',
        _customClassesCurrentDay.map((x) => x.serialize()).toList());
  }

  List<ClassRowStruct> _customClassesAlldays = [];
  List<ClassRowStruct> get customClassesAlldays => _customClassesAlldays;
  set customClassesAlldays(List<ClassRowStruct> value) {
    _customClassesAlldays = value;
    secureStorage.setStringList(
        'ff_customClassesAlldays', value.map((x) => x.serialize()).toList());
  }

  void deleteCustomClassesAlldays() {
    secureStorage.delete(key: 'ff_customClassesAlldays');
  }

  void addToCustomClassesAlldays(ClassRowStruct value) {
    customClassesAlldays.add(value);
    secureStorage.setStringList('ff_customClassesAlldays',
        _customClassesAlldays.map((x) => x.serialize()).toList());
  }

  void removeFromCustomClassesAlldays(ClassRowStruct value) {
    customClassesAlldays.remove(value);
    secureStorage.setStringList('ff_customClassesAlldays',
        _customClassesAlldays.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromCustomClassesAlldays(int index) {
    customClassesAlldays.removeAt(index);
    secureStorage.setStringList('ff_customClassesAlldays',
        _customClassesAlldays.map((x) => x.serialize()).toList());
  }

  void updateCustomClassesAlldaysAtIndex(
    int index,
    ClassRowStruct Function(ClassRowStruct) updateFn,
  ) {
    customClassesAlldays[index] = updateFn(_customClassesAlldays[index]);
    secureStorage.setStringList('ff_customClassesAlldays',
        _customClassesAlldays.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInCustomClassesAlldays(int index, ClassRowStruct value) {
    customClassesAlldays.insert(index, value);
    secureStorage.setStringList('ff_customClassesAlldays',
        _customClassesAlldays.map((x) => x.serialize()).toList());
  }

  DateTime? _customClassesLastUpdatedAt;
  DateTime? get customClassesLastUpdatedAt => _customClassesLastUpdatedAt;
  set customClassesLastUpdatedAt(DateTime? value) {
    _customClassesLastUpdatedAt = value;
    value != null
        ? secureStorage.setInt(
            'ff_customClassesLastUpdatedAt', value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_customClassesLastUpdatedAt');
  }

  void deleteCustomClassesLastUpdatedAt() {
    secureStorage.delete(key: 'ff_customClassesLastUpdatedAt');
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

  final _customClassesManager =
      StreamRequestManager<List<CustomClassesRecord>>();
  Stream<List<CustomClassesRecord>> customClasses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<CustomClassesRecord>> Function() requestFn,
  }) =>
      _customClassesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCustomClassesCache() => _customClassesManager.clear();
  void clearCustomClassesCacheKey(String? uniqueKey) =>
      _customClassesManager.clearRequest(uniqueKey);

  final _studyMaterialsManager =
      StreamRequestManager<List<StudyMaterialsRecord>>();
  Stream<List<StudyMaterialsRecord>> studyMaterials({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<StudyMaterialsRecord>> Function() requestFn,
  }) =>
      _studyMaterialsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearStudyMaterialsCache() => _studyMaterialsManager.clear();
  void clearStudyMaterialsCacheKey(String? uniqueKey) =>
      _studyMaterialsManager.clearRequest(uniqueKey);
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
