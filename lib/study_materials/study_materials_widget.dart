import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/add_files_alert_dialog_widget.dart';
import '/components/add_folder_bottom_sheet_widget.dart';
import '/components/folder_block_user_vault_widget.dart';
import '/components/folder_block_widget.dart';
import '/components/task_manager_block_widget.dart';
import '/empty_list_comp/empty_state_dynamic/empty_state_dynamic_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'study_materials_model.dart';
export 'study_materials_model.dart';

class StudyMaterialsWidget extends StatefulWidget {
  const StudyMaterialsWidget({super.key});

  static String routeName = 'studyMaterials';
  static String routePath = 'studyMaterials';

  @override
  State<StudyMaterialsWidget> createState() => _StudyMaterialsWidgetState();
}

class _StudyMaterialsWidgetState extends State<StudyMaterialsWidget>
    with TickerProviderStateMixin {
  late StudyMaterialsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudyMaterialsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'studyMaterials'});
    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserPersonalVaultRecord>>(
      future: FFAppState().userPersonalFiles(
        uniqueQueryKey: '${currentUserUid}_${dateTimeFormat(
          "d/M/y",
          getCurrentTimestamp,
          locale: FFLocalizations.of(context).languageCode,
        )}',
        requestFn: () => queryUserPersonalVaultRecordOnce(
          parent: currentUserReference,
          queryBuilder: (userPersonalVaultRecord) => userPersonalVaultRecord
              .where(
                'isDeleted',
                isEqualTo: false,
              )
              .orderBy('open_count', descending: true),
          limit: 10,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: SpinKitFadingCube(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 25.0,
                ),
              ),
            ),
          );
        }
        List<UserPersonalVaultRecord>
            studyMaterialsUserPersonalVaultRecordList = snapshot.data!;

        return Title(
            title: 'studyMaterials',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                floatingActionButton: Visibility(
                  visible: _model.tabBarCurrentIndex == 0,
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      logFirebaseEvent(
                          'STUDY_MATERIALS_FloatingActionButton_aqm');
                      logFirebaseEvent('FloatingActionButton_navigate_to');

                      context.pushNamed(
                          AddResoursesToGlobalRepositoryWidget.routeName);
                    },
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    icon: Icon(
                      Icons.add_rounded,
                      color: FlutterFlowTheme.of(context).info,
                      size: 24.0,
                    ),
                    elevation: 8.0,
                    label: AutoSizeText(
                      'Add Resourses',
                      minFontSize: 10.0,
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: FlutterFlowTheme.of(context).info,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelSmallIsCustom,
                          ),
                    ),
                  ),
                ),
                appBar: AppBar(
                  backgroundColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  automaticallyImplyLeading: false,
                  leading: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      FFIcons.karrowLeft,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      logFirebaseEvent('STUDY_MATERIALS_arrowLeft_ICN_ON_TAP');
                      logFirebaseEvent('IconButton_navigate_back');
                      context.pop();
                    },
                  ),
                  title: Text(
                    'Academic Resources',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineMediumIsCustom,
                        ),
                  ),
                  actions: [],
                  centerTitle: false,
                  elevation: 0.0,
                ),
                body: SafeArea(
                  top: true,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: FlutterFlowButtonTabBar(
                          useToggleButtonStyle: true,
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                          unselectedLabelStyle: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelLargeFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelLargeIsCustom,
                              ),
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).primaryText,
                          backgroundColor: FlutterFlowTheme.of(context).accent1,
                          unselectedBackgroundColor:
                              FlutterFlowTheme.of(context).accent4,
                          unselectedBorderColor:
                              FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          elevation: 0.0,
                          buttonMargin: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          tabs: [
                            Tab(
                              text: 'Study Repository',
                            ),
                            Tab(
                              text: 'Personal Repository',
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 4.0, 0.0),
                                            child: Container(
                                              width: 330.0,
                                              child: TextFormField(
                                                controller:
                                                    _model.textController,
                                                focusNode:
                                                    _model.textFieldFocusNode,
                                                onFieldSubmitted: (_) async {
                                                  logFirebaseEvent(
                                                      'STUDY_MATERIALS_TextField_8z0xb4dy_ON_TE');
                                                  if (_model.textController
                                                              .text !=
                                                          '') {
                                                    logFirebaseEvent(
                                                        'TextField_update_page_state');
                                                    _model.searchQuery = _model
                                                        .textController.text;
                                                    _model.searchActiveGlobal =
                                                        true;
                                                    safeSetState(() {});
                                                  } else {
                                                    logFirebaseEvent(
                                                        'TextField_show_snack_bar');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'No query entered! Type keywords to find lecture notes, assignments, or slides.',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmallFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmallIsCustom,
                                                              ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                      ),
                                                    );
                                                  }
                                                },
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Search through materials',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLargeIsCustom,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  prefixIcon: Icon(
                                                    Icons.search,
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLargeIsCustom,
                                                        ),
                                                validator: _model
                                                    .textControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (_model.searchActiveGlobal)
                                          Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 4.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'STUDY_MATERIALS_Icon_iahx504o_ON_TAP');
                                                  logFirebaseEvent(
                                                      'Icon_update_page_state');
                                                  _model.searchActiveGlobal =
                                                      false;
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 46.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.searchActiveGlobal)
                                          Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 4.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'STUDY_MATERIALS_Icon_dvtomllq_ON_TAP');
                                                  if (_model.textController
                                                              .text !=
                                                          '') {
                                                    logFirebaseEvent(
                                                        'Icon_update_page_state');
                                                    _model.searchQuery = _model
                                                        .textController.text;
                                                    _model.searchActiveGlobal =
                                                        true;
                                                    safeSetState(() {});
                                                  } else {
                                                    logFirebaseEvent(
                                                        'Icon_show_snack_bar');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'No query entered! Type keywords to find lecture notes, assignments, or slides.',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmallFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmallIsCustom,
                                                              ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  FFIcons.ksearch,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 38.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (!_model.searchActiveGlobal)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 8.0, 0.0, 0.0),
                                      child: Text(
                                        'Global Resourses',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLargeFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelLargeIsCustom,
                                            ),
                                      ),
                                    ),
                                  if (!_model.searchActiveGlobal)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 4.0, 12.0, 0.0),
                                      child: FutureBuilder<
                                          List<StudyMaterialsRecord>>(
                                        future: (_model
                                                    .firestoreRequestCompleter ??=
                                                Completer<
                                                    List<
                                                        StudyMaterialsRecord>>()
                                                  ..complete(
                                                      queryStudyMaterialsRecordOnce(
                                                    queryBuilder:
                                                        (studyMaterialsRecord) =>
                                                            studyMaterialsRecord
                                                                .where(
                                                                  'material_type',
                                                                  isEqualTo:
                                                                      StudyMaterialType
                                                                          .folder
                                                                          .serialize(),
                                                                )
                                                                .where(
                                                                  'isDeleted',
                                                                  isEqualTo:
                                                                      false,
                                                                )
                                                                .where(
                                                                  'parentPath',
                                                                  isEqualTo:
                                                                      'home/',
                                                                )
                                                                .orderBy(
                                                                    'fileName'),
                                                    limit: 6,
                                                  )))
                                            .future,
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 25.0,
                                                height: 25.0,
                                                child: SpinKitFadingCube(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 25.0,
                                                ),
                                              ),
                                            );
                                          }
                                          List<StudyMaterialsRecord>
                                              globalFoldersStudyMaterialsRecordList =
                                              snapshot.data!;
                                          if (globalFoldersStudyMaterialsRecordList
                                              .isEmpty) {
                                            return EmptyStateDynamicWidget(
                                              icon: Icon(
                                                FFIcons.kfilesOff,
                                              ),
                                              title:
                                                  'The Repository is currently Empty!',
                                              body:
                                                  'It seems like we haven\'t added any resoureses yet! stay tuned for more resoures will be added soon!',
                                              buttonText: 'Refresh',
                                              buttonAction: () async {},
                                            );
                                          }

                                          return RefreshIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .velvetSky,
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .accent4,
                                            strokeWidth: 3.5,
                                            onRefresh: () async {
                                              logFirebaseEvent(
                                                  'STUDY_MATERIALS_globalFolders_ON_PULL_TO');
                                              logFirebaseEvent(
                                                  'globalFolders_refresh_database_request');
                                              safeSetState(() => _model
                                                      .firestoreRequestCompleter =
                                                  null);
                                              await _model
                                                  .waitForFirestoreRequestCompleted();
                                            },
                                            child: GridView.builder(
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 5.0,
                                                mainAxisSpacing: 5.0,
                                                childAspectRatio: 1.0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  globalFoldersStudyMaterialsRecordList
                                                      .length,
                                              itemBuilder: (context,
                                                  globalFoldersIndex) {
                                                final globalFoldersStudyMaterialsRecord =
                                                    globalFoldersStudyMaterialsRecordList[
                                                        globalFoldersIndex];
                                                return wrapWithModel(
                                                  model: _model
                                                      .folderBlockModels
                                                      .getModel(
                                                    globalFoldersStudyMaterialsRecord
                                                        .reference.id,
                                                    globalFoldersIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: FolderBlockWidget(
                                                    key: Key(
                                                      'Keymkt_${globalFoldersStudyMaterialsRecord.reference.id}',
                                                    ),
                                                    folderRef:
                                                        globalFoldersStudyMaterialsRecord,
                                                    onTap: (parentPath) async {
                                                      logFirebaseEvent(
                                                          'STUDY_MATERIALS_Container_mktcrw9p_CALLB');
                                                      logFirebaseEvent(
                                                          'folderBlock_navigate_to');

                                                      context.goNamed(
                                                        FileManagerWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'parentPath':
                                                              serializeParam(
                                                            globalFoldersStudyMaterialsRecord
                                                                .parentPath,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  if (_model.searchActiveGlobal)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: FutureBuilder<
                                          List<StudyMaterialsRecord>>(
                                        future: (_model
                                                    .algoliaRequestCompleter ??=
                                                Completer<
                                                    List<
                                                        StudyMaterialsRecord>>()
                                                  ..complete(
                                                      StudyMaterialsRecord
                                                          .search(
                                                    term: _model.searchQuery,
                                                    maxResults: 20,
                                                  )))
                                            .future,
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 25.0,
                                                height: 25.0,
                                                child: SpinKitFadingCube(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 25.0,
                                                ),
                                              ),
                                            );
                                          }
                                          List<StudyMaterialsRecord>
                                              listViewStudyMaterialsRecordList =
                                              snapshot.data!;
                                          // Customize what your widget looks like with no search results.
                                          if (snapshot.data!.isEmpty) {
                                            return Container(
                                              height: 100,
                                              child: Center(
                                                child: Text('No results.'),
                                              ),
                                            );
                                          }
                                          return RefreshIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .velvetSky,
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .accent4,
                                            strokeWidth: 3.5,
                                            onRefresh: () async {
                                              logFirebaseEvent(
                                                  'STUDY_MATERIALS_ListView_jx77xpco_ON_PUL');
                                              logFirebaseEvent(
                                                  'ListView_refresh_database_request');
                                              safeSetState(() => _model
                                                      .algoliaRequestCompleter =
                                                  null);
                                              await _model
                                                  .waitForAlgoliaRequestCompleted();
                                            },
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewStudyMaterialsRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewStudyMaterialsRecord =
                                                    listViewStudyMaterialsRecordList[
                                                        listViewIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          6.0, 0.0, 6.0, 4.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      logFirebaseEvent(
                                                          'STUDY_MATERIALS_Container_e7dc1aoj_ON_TA');
                                                      if (listViewStudyMaterialsRecord
                                                              .materialType ==
                                                          StudyMaterialType
                                                              .folder) {
                                                        logFirebaseEvent(
                                                            'taskManager_block_navigate_to');

                                                        context.pushNamed(
                                                          FileManagerWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'parentPath':
                                                                serializeParam(
                                                              '${listViewStudyMaterialsRecord.parentPath}${listViewStudyMaterialsRecord.fileName}/',
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      } else {
                                                        logFirebaseEvent(
                                                            'taskManager_block_custom_action');
                                                        _model.fileStatus =
                                                            await actions
                                                                .fileViewer(
                                                          listViewStudyMaterialsRecord
                                                              .filePath,
                                                        );
                                                      }

                                                      safeSetState(() {});
                                                    },
                                                    child: wrapWithModel(
                                                      model: _model
                                                          .taskManagerBlockModels
                                                          .getModel(
                                                        listViewStudyMaterialsRecord
                                                            .reference.id,
                                                        listViewIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          TaskManagerBlockWidget(
                                                        key: Key(
                                                          'Keye7d_${listViewStudyMaterialsRecord.reference.id}',
                                                        ),
                                                        materialReference:
                                                            listViewStudyMaterialsRecord,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 6.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'STUDY_MATERIALS_ADD_NEW_MATERIALS_BTN_ON');
                                            logFirebaseEvent(
                                                'Button_alert_dialog');
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                              dialogContext)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child:
                                                        AddFilesAlertDialogWidget(),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          text: 'Add New Materials',
                                          icon: Icon(
                                            FFIcons.kplus,
                                            size: 22.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.8,
                                            height: 45.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: FlutterFlowIconButton(
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          borderRadius: 8.0,
                                          borderWidth: 2.0,
                                          buttonSize: 45.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          icon: Icon(
                                            FFIcons.kfolderPlus,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'STUDY_MATERIALS_folderPlus_ICN_ON_TAP');
                                            logFirebaseEvent(
                                                'IconButton_bottom_sheet');
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        AddFolderBottomSheetWidget(),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'Your Resourses',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelLargeIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                                if (!_model.isFavoritteSelectedPersonalVault)
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 4.0, 12.0, 0.0),
                                      child: FutureBuilder<
                                          List<UserPersonalVaultRecord>>(
                                        future:
                                            queryUserPersonalVaultRecordOnce(
                                          parent: currentUserReference,
                                          queryBuilder:
                                              (userPersonalVaultRecord) =>
                                                  userPersonalVaultRecord
                                                      .where(
                                                        'parentPath',
                                                        isEqualTo: "root/",
                                                      )
                                                      .where(
                                                        'isDeleted',
                                                        isEqualTo: false,
                                                      )
                                                      .orderBy(
                                                          'last_opened',
                                                          descending: true)
                                                      .orderBy('is_favorite',
                                                          descending: true)
                                                      .orderBy('is_favorite',
                                                          descending: true),
                                          limit: 9,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 25.0,
                                                height: 25.0,
                                                child: SpinKitFadingCube(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 25.0,
                                                ),
                                              ),
                                            );
                                          }
                                          List<UserPersonalVaultRecord>
                                              personalFolderUserPersonalVaultRecordList =
                                              snapshot.data!;

                                          return GridView.builder(
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 5.0,
                                              mainAxisSpacing: 5.0,
                                              childAspectRatio: 1.0,
                                            ),
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                personalFolderUserPersonalVaultRecordList
                                                    .length,
                                            itemBuilder:
                                                (context, personalFolderIndex) {
                                              final personalFolderUserPersonalVaultRecord =
                                                  personalFolderUserPersonalVaultRecordList[
                                                      personalFolderIndex];
                                              return wrapWithModel(
                                                model: _model
                                                    .folderBlockUserVaultModels
                                                    .getModel(
                                                  personalFolderUserPersonalVaultRecord
                                                      .reference.id,
                                                  personalFolderIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child:
                                                    FolderBlockUserVaultWidget(
                                                  key: Key(
                                                    'Keyy79_${personalFolderUserPersonalVaultRecord.reference.id}',
                                                  ),
                                                  userFolderRecord:
                                                      personalFolderUserPersonalVaultRecord,
                                                  onTap: (pathPath) async {
                                                    logFirebaseEvent(
                                                        'STUDY_MATERIALS_Container_y79ww7xz_CALLB');
                                                    logFirebaseEvent(
                                                        'folderBlockUserVault_navigate_to');

                                                    context.pushNamed(
                                                      FileMangerPersonalvaultWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'parentPath':
                                                            serializeParam(
                                                          pathPath,
                                                          ParamType.String,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
