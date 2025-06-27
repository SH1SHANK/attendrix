import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/task_archive_block_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'task_archives_model.dart';
export 'task_archives_model.dart';

class TaskArchivesWidget extends StatefulWidget {
  const TaskArchivesWidget({super.key});

  static String routeName = 'taskArchives';
  static String routePath = 'taskArchives';

  @override
  State<TaskArchivesWidget> createState() => _TaskArchivesWidgetState();
}

class _TaskArchivesWidgetState extends State<TaskArchivesWidget> {
  late TaskArchivesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaskArchivesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'taskArchives'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'taskArchives',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'TASK_ARCHIVES_PAGE_Icon_xpddobq6_ON_TAP');
                            logFirebaseEvent('Icon_navigate_back');
                            context.safePop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 32.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Archives',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AuthUserStreamWidget(
                          builder: (context) => FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(
                              _model.dropDownValue ??= '',
                            ),
                            options: List<String>.from((currentUserDocument
                                        ?.coursesEnrolled
                                        .toList() ??
                                    [])
                                .map((e) => e.courseID)
                                .toList()),
                            optionLabels: (currentUserDocument?.coursesEnrolled
                                        .toList() ??
                                    [])
                                .map((e) => e.courseName)
                                .toList(),
                            onChanged: (val) async {
                              safeSetState(() => _model.dropDownValue = val);
                              logFirebaseEvent(
                                  'TASK_ARCHIVES_DropDown_ehsa9cr8_ON_FORM_');
                              logFirebaseEvent('DropDown_update_page_state');
                              _model.filter = _model.dropDownValue;
                              safeSetState(() {});
                            },
                            width: 200.0,
                            height: 28.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelSmallIsCustom,
                                ),
                            hintText: 'Filter by course',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            elevation: 2.0,
                            borderColor: Colors.transparent,
                            borderWidth: 0.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            hidesUnderline: true,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ),
                        if (_model.filter != null && _model.filter != '')
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'TASK_ARCHIVES_PAGE_Icon_tfej81x7_ON_TAP');
                                logFirebaseEvent('Icon_update_page_state');
                                _model.filter = null;
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.close_outlined,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => FutureBuilder<List<TaskRecordsRow>>(
                        future: FFAppState().tasksQuery(
                          requestFn: () => TaskRecordsTable().queryRows(
                            queryFn: (q) => q
                                .inFilterOrNull(
                                  'courseID',
                                  (currentUserDocument?.coursesEnrolled
                                              .toList() ??
                                          [])
                                      .map((e) => e.courseID)
                                      .toList(),
                                )
                                .eqOrNull(
                                  'courseID',
                                  _model.dropDownValue,
                                )
                                .order('taskStartTime'),
                            limit: 24,
                          ),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: SpinKitFadingCube(
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 25.0,
                                ),
                              ),
                            );
                          }
                          List<TaskRecordsRow> listViewTaskRecordsRowList =
                              snapshot.data!;

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewTaskRecordsRowList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewTaskRecordsRow =
                                  listViewTaskRecordsRowList[listViewIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.taskArchiveBlockModels.getModel(
                                    listViewTaskRecordsRow.id,
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: TaskArchiveBlockWidget(
                                    key: Key(
                                      'Keysmb_${listViewTaskRecordsRow.id}',
                                    ),
                                    taskID: listViewTaskRecordsRow.id,
                                    taskType: listViewTaskRecordsRow.taskType ==
                                            'exam'
                                        ? RecordType.exam
                                        : RecordType.assignment,
                                    taskRecord: listViewTaskRecordsRow,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
