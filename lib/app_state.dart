import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  final _attendanceRecordCountManager = FutureRequestManager<int>();
  Future<int> attendanceRecordCount({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
  }) =>
      _attendanceRecordCountManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAttendanceRecordCountCache() =>
      _attendanceRecordCountManager.clear();
  void clearAttendanceRecordCountCacheKey(String? uniqueKey) =>
      _attendanceRecordCountManager.clearRequest(uniqueKey);

  final _totalClassCountManager = FutureRequestManager<int>();
  Future<int> totalClassCount({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
  }) =>
      _totalClassCountManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTotalClassCountCache() => _totalClassCountManager.clear();
  void clearTotalClassCountCacheKey(String? uniqueKey) =>
      _totalClassCountManager.clearRequest(uniqueKey);

  final _attendanceRecordsManager =
      FutureRequestManager<List<TimetableRecord>>();
  Future<List<TimetableRecord>> attendanceRecords({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TimetableRecord>> Function() requestFn,
  }) =>
      _attendanceRecordsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAttendanceRecordsCache() => _attendanceRecordsManager.clear();
  void clearAttendanceRecordsCacheKey(String? uniqueKey) =>
      _attendanceRecordsManager.clearRequest(uniqueKey);

  final _attendedClassesLogManager =
      StreamRequestManager<List<AttendanceRecordRecord>>();
  Stream<List<AttendanceRecordRecord>> attendedClassesLog({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<AttendanceRecordRecord>> Function() requestFn,
  }) =>
      _attendedClassesLogManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAttendedClassesLogCache() => _attendedClassesLogManager.clear();
  void clearAttendedClassesLogCacheKey(String? uniqueKey) =>
      _attendedClassesLogManager.clearRequest(uniqueKey);
}
