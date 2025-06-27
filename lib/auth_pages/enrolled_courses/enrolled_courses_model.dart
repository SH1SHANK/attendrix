import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'enrolled_courses_widget.dart' show EnrolledCoursesWidget;
import 'package:flutter/material.dart';

class EnrolledCoursesModel extends FlutterFlowModel<EnrolledCoursesWidget> {
  ///  Local state fields for this page.

  List<CourseRecordsRow> coursesEnrolled = [];
  void addToCoursesEnrolled(CourseRecordsRow item) => coursesEnrolled.add(item);
  void removeFromCoursesEnrolled(CourseRecordsRow item) =>
      coursesEnrolled.remove(item);
  void removeAtIndexFromCoursesEnrolled(int index) =>
      coursesEnrolled.removeAt(index);
  void insertAtIndexInCoursesEnrolled(int index, CourseRecordsRow item) =>
      coursesEnrolled.insert(index, item);
  void updateCoursesEnrolledAtIndex(
          int index, Function(CourseRecordsRow) updateFn) =>
      coursesEnrolled[index] = updateFn(coursesEnrolled[index]);

  List<CoursesEnrolledStruct> coursesStruct = [];
  void addToCoursesStruct(CoursesEnrolledStruct item) =>
      coursesStruct.add(item);
  void removeFromCoursesStruct(CoursesEnrolledStruct item) =>
      coursesStruct.remove(item);
  void removeAtIndexFromCoursesStruct(int index) =>
      coursesStruct.removeAt(index);
  void insertAtIndexInCoursesStruct(int index, CoursesEnrolledStruct item) =>
      coursesStruct.insert(index, item);
  void updateCoursesStructAtIndex(
          int index, Function(CoursesEnrolledStruct) updateFn) =>
      coursesStruct[index] = updateFn(coursesStruct[index]);

  String? electiveCourseIDs;

  int loopParameter = 0;

  List<CourseRecordsRow> electiveCourserecords = [];
  void addToElectiveCourserecords(CourseRecordsRow item) =>
      electiveCourserecords.add(item);
  void removeFromElectiveCourserecords(CourseRecordsRow item) =>
      electiveCourserecords.remove(item);
  void removeAtIndexFromElectiveCourserecords(int index) =>
      electiveCourserecords.removeAt(index);
  void insertAtIndexInElectiveCourserecords(int index, CourseRecordsRow item) =>
      electiveCourserecords.insert(index, item);
  void updateElectiveCourserecordsAtIndex(
          int index, Function(CourseRecordsRow) updateFn) =>
      electiveCourserecords[index] = updateFn(electiveCourserecords[index]);

  /// Query cache managers for this widget.

  final _userElectiveCoursesManager =
      FutureRequestManager<List<CourseRecordsRow>>();
  Future<List<CourseRecordsRow>> userElectiveCourses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CourseRecordsRow>> Function() requestFn,
  }) =>
      _userElectiveCoursesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserElectiveCoursesCache() => _userElectiveCoursesManager.clear();
  void clearUserElectiveCoursesCacheKey(String? uniqueKey) =>
      _userElectiveCoursesManager.clearRequest(uniqueKey);

  final _userCoreCoursesManager =
      FutureRequestManager<List<CourseRecordsRow>>();
  Future<List<CourseRecordsRow>> userCoreCourses({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CourseRecordsRow>> Function() requestFn,
  }) =>
      _userCoreCoursesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserCoreCoursesCache() => _userCoreCoursesManager.clear();
  void clearUserCoreCoursesCacheKey(String? uniqueKey) =>
      _userCoreCoursesManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearUserElectiveCoursesCache();

    clearUserCoreCoursesCache();
  }
}
