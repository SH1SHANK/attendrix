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

  final _checkInDetailsManager =
      StreamRequestManager<List<AttendanceRecordRecord>>();
  Stream<List<AttendanceRecordRecord>> checkInDetails({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<AttendanceRecordRecord>> Function() requestFn,
  }) =>
      _checkInDetailsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCheckInDetailsCache() => _checkInDetailsManager.clear();
  void clearCheckInDetailsCacheKey(String? uniqueKey) =>
      _checkInDetailsManager.clearRequest(uniqueKey);

  final _upcomingClassDetailsManager =
      StreamRequestManager<List<TimetableRecord>>();
  Stream<List<TimetableRecord>> upcomingClassDetails({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TimetableRecord>> Function() requestFn,
  }) =>
      _upcomingClassDetailsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUpcomingClassDetailsCache() => _upcomingClassDetailsManager.clear();
  void clearUpcomingClassDetailsCacheKey(String? uniqueKey) =>
      _upcomingClassDetailsManager.clearRequest(uniqueKey);

  final _attendanceOverviewManager =
      StreamRequestManager<List<ClassDetailsRecord>>();
  Stream<List<ClassDetailsRecord>> attendanceOverview({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ClassDetailsRecord>> Function() requestFn,
  }) =>
      _attendanceOverviewManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAttendanceOverviewCache() => _attendanceOverviewManager.clear();
  void clearAttendanceOverviewCacheKey(String? uniqueKey) =>
      _attendanceOverviewManager.clearRequest(uniqueKey);

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
}
