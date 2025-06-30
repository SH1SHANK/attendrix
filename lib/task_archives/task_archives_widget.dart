import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/task_archive_block_widget.dart';
import '/empty_list_comp/empty_class/empty_class_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => StreamBuilder<List<TaskRecordsRow>>(
                        stream: FFAppState().tasksQuery(
                          requestFn: () => _model.listViewSupabaseStream ??=
                              SupaFlow.client
                                  .from("taskRecords")
                                  .stream(primaryKey: ['id'])
                                  .inFilterOrNull(
                                    'courseID',
                                    (currentUserDocument?.coursesEnrolled
                                                .toList() ??
                                            [])
                                        .map((e) => e.courseID)
                                        .toList(),
                                  )
                                  .order('taskStartTime')
                                  .limit(24)
                                  .map((list) => list
                                      .map((item) => TaskRecordsRow(item))
                                      .toList()),
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

                          if (listViewTaskRecordsRowList.isEmpty) {
                            return Center(
                              child: EmptyClassWidget(
                                imageUrl: '',
                                title: 'No Tasks Yet!',
                                description:
                                    'Looks Like You Don\'t Have Any Tasks Yet! Check Back Later.',
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewTaskRecordsRowList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 4.0),
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
