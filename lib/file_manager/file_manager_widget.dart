import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/add_study_materials_widget.dart';
import '/components/task_manager_block_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'file_manager_model.dart';
export 'file_manager_model.dart';

class FileManagerWidget extends StatefulWidget {
  const FileManagerWidget({
    super.key,
    String? parentPath,
  }) : this.parentPath = parentPath ?? 'home/';

  final String parentPath;

  static String routeName = 'fileManager';
  static String routePath = 'fileManager';

  @override
  State<FileManagerWidget> createState() => _FileManagerWidgetState();
}

class _FileManagerWidgetState extends State<FileManagerWidget> {
  late FileManagerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FileManagerModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'fileManager'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('FILE_MANAGER_fileManager_ON_INIT_STATE');
      logFirebaseEvent('fileManager_update_page_state');
      _model.parentPath = valueOrDefault<String>(
        widget.parentPath,
        'home/',
      );
      safeSetState(() {});
    });

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
        title: 'fileManager',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            floatingActionButton: Visibility(
              visible:
                  valueOrDefault(currentUserDocument?.userRole, '') == 'admin',
              child: AuthUserStreamWidget(
                builder: (context) => FloatingActionButton(
                  onPressed: () async {
                    logFirebaseEvent(
                        'FILE_MANAGER_FloatingActionButton_1r5akr');
                    logFirebaseEvent('FloatingActionButton_bottom_sheet');
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: AddStudyMaterialsWidget(
                              parentPath: _model.parentPath!,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  elevation: 8.0,
                  child: Icon(
                    Icons.add_rounded,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'FILE_MANAGER_PAGE_Icon_m4ahey7d_ON_TAP');
                                    logFirebaseEvent('Icon_navigate_to');

                                    context.goNamed(
                                      StudyMaterialsWidget.routeName,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.leftToRight,
                                        ),
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 32.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    6.0, 0.0, 0.0, 4.0),
                                child: Text(
                                  'File Manager',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineSmallFamily,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineSmallIsCustom,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onDoubleTap: () async {
                                    logFirebaseEvent(
                                        'FILE_MANAGER_Icon_3elvuj2l_ON_DOUBLE_TAP');
                                    logFirebaseEvent('Icon_update_page_state');
                                    _model.parentPath = widget.parentPath;
                                    safeSetState(() {});
                                  },
                                  child: Icon(
                                    FFIcons.khomeHouse2,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  final breadcrumbs = functions
                                          .breadcrumbGenerator(
                                              valueOrDefault<String>(
                                                _model.parentPath,
                                                'home/',
                                              ),
                                              false,
                                              false)
                                          ?.toList() ??
                                      [];

                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(breadcrumbs.length,
                                        (breadcrumbsIndex) {
                                      final breadcrumbsItem =
                                          breadcrumbs[breadcrumbsIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onDoubleTap: () async {
                                          logFirebaseEvent(
                                              'FILE_MANAGER_Container_bvejgmr1_ON_DOUBL');
                                          logFirebaseEvent(
                                              'Container_update_page_state');
                                          _model.parentPath =
                                              functions.breadcrumbParser(
                                                  functions
                                                      .breadcrumbGenerator(
                                                          _model.parentPath!,
                                                          false,
                                                          false)
                                                      ?.toList(),
                                                  breadcrumbsIndex.toString());
                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.28,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        4.0, 0.0, 0.0, 0.0),
                                                child: Icon(
                                                  Icons.chevron_right_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 12.0,
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.23,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    (int var1, int var2) {
                                                      return (var2 != null)
                                                          ? var1 == (var2 + 1)
                                                          : false;
                                                    }(
                                                            breadcrumbsIndex,
                                                            functions
                                                                .breadcrumbGenerator(
                                                                    _model
                                                                        .parentPath!,
                                                                    true,
                                                                    false)!
                                                                .length)
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 4.0,
                                                                0.0, 4.0),
                                                    child: AutoSizeText(
                                                      valueOrDefault<String>(
                                                        breadcrumbsItem,
                                                        'FolderA',
                                                      ).maybeHandleOverflow(
                                                        maxChars: 18,
                                                        replacement: '…',
                                                      ),
                                                      minFontSize: 6.0,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                            fontSize: 8.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                        child: StreamBuilder<List<StudyMaterialsRecord>>(
                          stream: queryStudyMaterialsRecord(
                            queryBuilder: (studyMaterialsRecord) =>
                                studyMaterialsRecord
                                    .where(
                                      'parentPath',
                                      isEqualTo: _model.parentPath != ''
                                          ? _model.parentPath
                                          : null,
                                    )
                                    .where(
                                      'isDeleted',
                                      isEqualTo: false,
                                    ),
                            limit: 20,
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
                            List<StudyMaterialsRecord>
                                listViewStudyMaterialsRecordList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewStudyMaterialsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewStudyMaterialsRecord =
                                    listViewStudyMaterialsRecordList[
                                        listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 6.0, 4.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'FILE_MANAGER_Container_xm5z74jo_ON_TAP');
                                      if (listViewStudyMaterialsRecord
                                              .materialType ==
                                          StudyMaterialType.folder) {
                                        logFirebaseEvent(
                                            'taskManager_block_update_page_state');
                                        _model.parentPath =
                                            '${_model.parentPath}${listViewStudyMaterialsRecord.fileName}/';
                                        safeSetState(() {});
                                      } else {
                                        logFirebaseEvent(
                                            'taskManager_block_custom_action');
                                        _model.fileStatus =
                                            await actions.fileViewer(
                                          listViewStudyMaterialsRecord.filePath,
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    child: wrapWithModel(
                                      model: _model.taskManagerBlockModels
                                          .getModel(
                                        listViewStudyMaterialsRecord
                                            .reference.id,
                                        listViewIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: TaskManagerBlockWidget(
                                        key: Key(
                                          'Keyxm5_${listViewStudyMaterialsRecord.reference.id}',
                                        ),
                                        materialReference:
                                            listViewStudyMaterialsRecord,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                        child: Container(
                          width: double.infinity,
                          height: 30.0,
                          decoration: BoxDecoration(),
                        ),
                      ),
                    ],
                  ),
                ].addToStart(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ));
  }
}
