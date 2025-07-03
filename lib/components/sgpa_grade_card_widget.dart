import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'sgpa_grade_card_model.dart';
export 'sgpa_grade_card_model.dart';

class SgpaGradeCardWidget extends StatefulWidget {
  const SgpaGradeCardWidget({
    super.key,
    required this.enrolledCourse,
    this.onSelected,
  });

  final CoursesEnrolledStruct? enrolledCourse;
  final Future Function(int gradeSelected, int credits, String courseID)?
      onSelected;

  @override
  State<SgpaGradeCardWidget> createState() => _SgpaGradeCardWidgetState();
}

class _SgpaGradeCardWidgetState extends State<SgpaGradeCardWidget> {
  late SgpaGradeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SgpaGradeCardModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SGPA_GRADE_CARD_sgpaGradeCard_ON_INIT_ST');
      logFirebaseEvent('sgpaGradeCard_backend_call');
      _model.courseRecord = await CourseRecordsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'courseID',
          widget.enrolledCourse?.courseID,
        ),
      );
      logFirebaseEvent('sgpaGradeCard_update_component_state');
      _model.credits = _model.courseRecord!.firstOrNull!.credits!;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              valueOrDefault<String>(
                widget.enrolledCourse?.courseName,
                'Mathematics III',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ),
          FlutterFlowDropDown<int>(
            controller: _model.dropDownValueController ??=
                FormFieldController<int>(null),
            options: List<int>.from([10, 9, 8, 7, 6, 5]),
            optionLabels: ['S', 'A', 'B', 'C', 'D', 'E'],
            onChanged: (val) async {
              safeSetState(() => _model.dropDownValue = val);
              logFirebaseEvent('SGPA_GRADE_CARD_DropDown_os13nxo1_ON_FOR');
              logFirebaseEvent('DropDown_execute_callback');
              await widget.onSelected?.call(
                _model.dropDownValue!,
                _model.credits,
                widget.enrolledCourse!.courseID,
              );
            },
            width: 90.0,
            height: 35.0,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
            hintText: 'Grade',
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            elevation: 2.0,
            borderColor: FlutterFlowTheme.of(context).alternate,
            borderWidth: 2.0,
            borderRadius: 8.0,
            margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
            hidesUnderline: true,
            isOverButton: false,
            isSearchable: false,
            isMultiSelect: false,
          ),
        ],
      ),
    );
  }
}
