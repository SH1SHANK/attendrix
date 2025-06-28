import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'course_search_widget.dart' show CourseSearchWidget;
import 'package:flutter/material.dart';

class CourseSearchModel extends FlutterFlowModel<CourseSearchWidget> {
  ///  Local state fields for this component.

  List<CourseRecordsRow> searchResults = [];
  void addToSearchResults(CourseRecordsRow item) => searchResults.add(item);
  void removeFromSearchResults(CourseRecordsRow item) =>
      searchResults.remove(item);
  void removeAtIndexFromSearchResults(int index) =>
      searchResults.removeAt(index);
  void insertAtIndexInSearchResults(int index, CourseRecordsRow item) =>
      searchResults.insert(index, item);
  void updateSearchResultsAtIndex(
          int index, Function(CourseRecordsRow) updateFn) =>
      searchResults[index] = updateFn(searchResults[index]);

  bool isSearchActive = false;

  String electiveType = 'open Elective';

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<String> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
