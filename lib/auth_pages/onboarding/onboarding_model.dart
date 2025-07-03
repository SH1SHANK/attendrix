import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/class_components/elective_selection_block/elective_selection_block_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'onboarding_widget.dart' show OnboardingWidget;
import 'package:flutter/material.dart';

class OnboardingModel extends FlutterFlowModel<OnboardingWidget> {
  ///  Local state fields for this page.

  bool? usernameAlreadyExists = false;

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

  List<CourseRecordsRow> coreCoursesSelected = [];
  void addToCoreCoursesSelected(CourseRecordsRow item) =>
      coreCoursesSelected.add(item);
  void removeFromCoreCoursesSelected(CourseRecordsRow item) =>
      coreCoursesSelected.remove(item);
  void removeAtIndexFromCoreCoursesSelected(int index) =>
      coreCoursesSelected.removeAt(index);
  void insertAtIndexInCoreCoursesSelected(int index, CourseRecordsRow item) =>
      coreCoursesSelected.insert(index, item);
  void updateCoreCoursesSelectedAtIndex(
          int index, Function(CourseRecordsRow) updateFn) =>
      coreCoursesSelected[index] = updateFn(coreCoursesSelected[index]);

  List<CourseRecordsRow> batchElectiveCourses = [];
  void addToBatchElectiveCourses(CourseRecordsRow item) =>
      batchElectiveCourses.add(item);
  void removeFromBatchElectiveCourses(CourseRecordsRow item) =>
      batchElectiveCourses.remove(item);
  void removeAtIndexFromBatchElectiveCourses(int index) =>
      batchElectiveCourses.removeAt(index);
  void insertAtIndexInBatchElectiveCourses(int index, CourseRecordsRow item) =>
      batchElectiveCourses.insert(index, item);
  void updateBatchElectiveCoursesAtIndex(
          int index, Function(CourseRecordsRow) updateFn) =>
      batchElectiveCourses[index] = updateFn(batchElectiveCourses[index]);

  int? loopParameter = 0;

  List<CoursesEnrolledStruct> coursesEnrolledStruct = [];
  void addToCoursesEnrolledStruct(CoursesEnrolledStruct item) =>
      coursesEnrolledStruct.add(item);
  void removeFromCoursesEnrolledStruct(CoursesEnrolledStruct item) =>
      coursesEnrolledStruct.remove(item);
  void removeAtIndexFromCoursesEnrolledStruct(int index) =>
      coursesEnrolledStruct.removeAt(index);
  void insertAtIndexInCoursesEnrolledStruct(
          int index, CoursesEnrolledStruct item) =>
      coursesEnrolledStruct.insert(index, item);
  void updateCoursesEnrolledStructAtIndex(
          int index, Function(CoursesEnrolledStruct) updateFn) =>
      coursesEnrolledStruct[index] = updateFn(coursesEnrolledStruct[index]);

  List<CourseRecordsRow> electiveCoursesSelected = [];
  void addToElectiveCoursesSelected(CourseRecordsRow item) =>
      electiveCoursesSelected.add(item);
  void removeFromElectiveCoursesSelected(CourseRecordsRow item) =>
      electiveCoursesSelected.remove(item);
  void removeAtIndexFromElectiveCoursesSelected(int index) =>
      electiveCoursesSelected.removeAt(index);
  void insertAtIndexInElectiveCoursesSelected(
          int index, CourseRecordsRow item) =>
      electiveCoursesSelected.insert(index, item);
  void updateElectiveCoursesSelectedAtIndex(
          int index, Function(CourseRecordsRow) updateFn) =>
      electiveCoursesSelected[index] = updateFn(electiveCoursesSelected[index]);

  String? courseEnrollmentFeedback;

  bool isAdmin = false;

  int verifyCount = 0;

  ///  State fields for stateful widgets in this page.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in onboarding widget.
  UsersRecord? userDoc;
  // Stores action output result for [Backend Call - Query Rows] action in onboarding widget.
  List<CourseRecordsRow>? coreCourses;
  // Stores action output result for [Backend Call - Query Rows] action in onboarding widget.
  List<CourseRecordsRow>? electiveCourses;
  // State field(s) for onboardingPages widget.
  PageController? onboardingPagesController;

  int get onboardingPagesCurrentIndex => onboardingPagesController != null &&
          onboardingPagesController!.hasClients &&
          onboardingPagesController!.page != null
      ? onboardingPagesController!.page!.round()
      : 0;
  // State field(s) for username widget.
  FocusNode? usernameFocusNode1;
  TextEditingController? usernameTextController1;
  String? Function(BuildContext, String?)? usernameTextController1Validator;
  String? _usernameTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name can’t be empty';
    }

    if (val.length < 4) {
      return 'Requires at least 4 characters.';
    }
    if (val.length > 18) {
      return 'Maximum 18 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for branch widget.
  String? branchValue;
  FormFieldController<String>? branchValueController;
  // State field(s) for batch widget.
  String? batchValue;
  FormFieldController<String>? batchValueController;
  // State field(s) for semester widget.
  int? semesterValue;
  FormFieldController<int>? semesterValueController;
  // State field(s) for userBio widget.
  FocusNode? userBioFocusNode;
  TextEditingController? userBioTextController;
  String? Function(BuildContext, String?)? userBioTextControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? academicProfileValidation;
  // State field(s) for username widget.
  FocusNode? usernameFocusNode2;
  TextEditingController? usernameTextController2;
  String? Function(BuildContext, String?)? usernameTextController2Validator;
  String? _usernameTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Username is required';
    }

    if (val.length < 4) {
      return 'username must be atleast 4 characters long.';
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'Must start with a letter and can only contain letters, digits and - or _.';
    }
    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in username widget.
  UsersRecord? usernameAvailability;
  // Stores action output result for [Custom Action - getUniqueUsername] action in IconButton widget.
  String? uniqueUsername;
  // Models for electiveSelectionBlock dynamic component.
  late FlutterFlowDynamicModels<ElectiveSelectionBlockModel>
      electiveSelectionBlockModels;

  @override
  void initState(BuildContext context) {
    usernameTextController1Validator = _usernameTextController1Validator;
    usernameTextController2Validator = _usernameTextController2Validator;
    electiveSelectionBlockModels =
        FlutterFlowDynamicModels(() => ElectiveSelectionBlockModel());
  }

  @override
  void dispose() {
    usernameFocusNode1?.dispose();
    usernameTextController1?.dispose();

    userBioFocusNode?.dispose();
    userBioTextController?.dispose();

    usernameFocusNode2?.dispose();
    usernameTextController2?.dispose();

    electiveSelectionBlockModels.dispose();
  }
}
