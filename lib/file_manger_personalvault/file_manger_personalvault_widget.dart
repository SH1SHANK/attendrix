import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/add_study_materials_widget.dart';
import '/components/task_manager_user_personal_vault_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'file_manger_personalvault_model.dart';
export 'file_manger_personalvault_model.dart';

class FileMangerPersonalvaultWidget extends StatefulWidget {
  const FileMangerPersonalvaultWidget({
    super.key,
    String? parentPath,
  }) : this.parentPath = parentPath ?? 'root/';

  final String parentPath;

  static String routeName = 'fileMangerPersonalvault';
  static String routePath = 'fileMangerPersonalvault';

  @override
  State<FileMangerPersonalvaultWidget> createState() =>
      _FileMangerPersonalvaultWidgetState();
}

class _FileMangerPersonalvaultWidgetState
    extends State<FileMangerPersonalvaultWidget> {
  late FileMangerPersonalvaultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FileMangerPersonalvaultModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'fileMangerPersonalvault'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('FILE_MANGER_PERSONALVAULT_fileMangerPers');
      logFirebaseEvent('fileMangerPersonalvault_update_page_stat');
      _model.parentPath = valueOrDefault<String>(
        widget.parentPath,
        'root/',
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
        title: 'fileMangerPersonalvault',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                logFirebaseEvent('FILE_MANGER_PERSONALVAULT_FloatingAction');
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
                                        'FILE_MANGER_PERSONALVAULT_Icon_b0jrwsr6_');
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
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'FILE_MANGER_PERSONALVAULT_Icon_hi7gv2mf_');
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
                                              _model.parentPath!, false, true)
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
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'FILE_MANGER_PERSONALVAULT_Container_1zib');
                                          logFirebaseEvent(
                                              'Container_update_page_state');
                                          _model.parentPath =
                                              valueOrDefault<String>(
                                            functions.breadcrumbParser(
                                                functions
                                                    .breadcrumbGenerator(
                                                        _model.parentPath!,
                                                        false,
                                                        false)
                                                    ?.toList(),
                                                breadcrumbsIndex.toString()),
                                            'root/',
                                          );
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
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 16.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FlutterFlowChoiceChips(
                                options: [
                                  ChipData('All'),
                                  ChipData('PDF'),
                                  ChipData('PPT'),
                                  ChipData('TXT'),
                                  ChipData('Folders')
                                ],
                                onChanged: (val) async {
                                  safeSetState(() => _model.choiceChipsValue =
                                      val?.firstOrNull);
                                  logFirebaseEvent(
                                      'FILE_MANGER_PERSONALVAULT_ChoiceChips_xp');
                                  logFirebaseEvent(
                                      'ChoiceChips_update_page_state');
                                  _model.fileType = () {
                                    if (_model.choiceChipsValue == 'All') {
                                      return '';
                                    } else if (_model.choiceChipsValue ==
                                        'PDF') {
                                      return 'application/pdf';
                                    } else if (_model.choiceChipsValue ==
                                        'PPT') {
                                      return 'application/vnd.ms-powerpoint';
                                    } else if (_model.choiceChipsValue ==
                                        'TXT') {
                                      return '\ttext/plain';
                                    } else if (_model.choiceChipsValue ==
                                        'Folders') {
                                      return 'folder';
                                    } else {
                                      return '';
                                    }
                                  }();
                                  safeSetState(() {});
                                },
                                selectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).velvetSky,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                  iconColor:
                                      FlutterFlowTheme.of(context).mintGreen,
                                  iconSize: 12.0,
                                  labelPadding: EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 6.0, 0.0),
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .labelSmallIsCustom,
                                      ),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  iconSize: 12.0,
                                  labelPadding: EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 6.0, 0.0),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                chipSpacing: 8.0,
                                rowSpacing: 8.0,
                                multiselect: false,
                                initialized: _model.choiceChipsValue != null,
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.choiceChipsValueController ??=
                                        FormFieldController<List<String>>(
                                  ['All'],
                                ),
                                wrapped: true,
                              ),
                            ),
                            Icon(
                              FFIcons.ksortAscending,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<List<UserPersonalVaultRecord>>(
                    stream: queryUserPersonalVaultRecord(
                      parent: currentUserReference,
                      queryBuilder: (userPersonalVaultRecord) =>
                          userPersonalVaultRecord
                              .where(
                                'parentPath',
                                isEqualTo: valueOrDefault<String>(
                                          _model.parentPath,
                                          'root/',
                                        ) !=
                                        ''
                                    ? valueOrDefault<String>(
                                        _model.parentPath,
                                        'root/',
                                      )
                                    : null,
                              )
                              .where(
                                'mimeType',
                                isEqualTo: _model.fileType != ''
                                    ? _model.fileType
                                    : null,
                              )
                              .orderBy('last_opened', descending: true),
                      limit: 15,
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
                      List<UserPersonalVaultRecord>
                          listViewUserPersonalVaultRecordList = snapshot.data!;

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewUserPersonalVaultRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewUserPersonalVaultRecord =
                              listViewUserPersonalVaultRecordList[
                                  listViewIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 3.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'FILE_MANGER_PERSONALVAULT_Container_yjr2');
                                if (listViewUserPersonalVaultRecord.type ==
                                    StudyMaterialType.folder) {
                                  logFirebaseEvent(
                                      'taskManager_userPersonalVault_update_pag');
                                  _model.parentPath =
                                      '${_model.parentPath}${listViewUserPersonalVaultRecord.name}/';
                                  safeSetState(() {});
                                } else {
                                  logFirebaseEvent(
                                      'taskManager_userPersonalVault_custom_act');
                                  _model.fileStatus = await actions.fileViewer(
                                    listViewUserPersonalVaultRecord.filePath,
                                  );
                                }

                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.taskManagerUserPersonalVaultModels
                                    .getModel(
                                  listViewUserPersonalVaultRecord.reference.id,
                                  listViewIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: TaskManagerUserPersonalVaultWidget(
                                  key: Key(
                                    'Keyyjr_${listViewUserPersonalVaultRecord.reference.id}',
                                  ),
                                  fileRecord: listViewUserPersonalVaultRecord,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ].addToStart(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ));
  }
}
