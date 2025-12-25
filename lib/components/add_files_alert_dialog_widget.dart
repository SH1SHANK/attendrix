import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/components/add_folder_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_files_alert_dialog_model.dart';
export 'add_files_alert_dialog_model.dart';

class AddFilesAlertDialogWidget extends StatefulWidget {
  const AddFilesAlertDialogWidget({
    super.key,
    String? parentPath,
  }) : this.parentPath = parentPath ?? 'home/';

  final String parentPath;

  @override
  State<AddFilesAlertDialogWidget> createState() =>
      _AddFilesAlertDialogWidgetState();
}

class _AddFilesAlertDialogWidgetState extends State<AddFilesAlertDialogWidget>
    with TickerProviderStateMixin {
  late AddFilesAlertDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddFilesAlertDialogModel());

    _model.fileNameTextFieldTextController ??= TextEditingController();
    _model.fileNameTextFieldFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StudyMaterialsRecord>>(
      stream: queryStudyMaterialsRecord(
        queryBuilder: (studyMaterialsRecord) => studyMaterialsRecord
            .where(
              'material_type',
              isEqualTo: StudyMaterialType.folder.serialize(),
            )
            .orderBy('fileName'),
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
        List<StudyMaterialsRecord> containerStudyMaterialsRecordList =
            snapshot.data!;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 24.0, 12.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                FFIcons.kfileText,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 28.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Add New Files',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    fontSize: 28.0,
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
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'ADD_FILES_ALERT_DIALOG_Icon_z31avn87_ON_');
                          logFirebaseEvent('Icon_dismiss_dialog');
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FFIcons.kcloseLG,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 32.0,
                        ),
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'File Name',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelMediumIsCustom,
                          ),
                    ),
                    Text(
                      '*',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            color: FlutterFlowTheme.of(context).error,
                            letterSpacing: 0.0,
                            useGoogleFonts:
                                !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                          ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.fileNameTextFieldTextController,
                    focusNode: _model.fileNameTextFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.fileNameTextFieldTextController',
                      Duration(milliseconds: 2000),
                      () => safeSetState(() {}),
                    ),
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'e.g. Quantum Physics Notes',
                      hintStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            font: GoogleFonts.outfit(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      suffixIcon: _model
                              .fileNameTextFieldTextController!.text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.fileNameTextFieldTextController?.clear();
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 22.0,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                    validator: _model.fileNameTextFieldTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload File',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelMediumIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
                Expanded(
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
                              FlutterFlowTheme.of(context).secondaryText,
                          backgroundColor: FlutterFlowTheme.of(context).accent1,
                          unselectedBackgroundColor:
                              FlutterFlowTheme.of(context).alternate,
                          unselectedBorderColor:
                              FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          elevation: 0.0,
                          buttonMargin: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          tabs: [
                            Tab(
                              text: 'Upload File',
                            ),
                            Tab(
                              text: 'Insert Link',
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
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (!_model.fileUploaded)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'ADD_FILES_ALERT_DIALOG_Container_zsuznn9');
                                            logFirebaseEvent(
                                                'Container_store_file_for_upload');
                                            final selectedFiles =
                                                await selectFiles(
                                              multiFile: false,
                                            );
                                            if (selectedFiles != null) {
                                              safeSetState(() => _model
                                                      .isDataUploading_uploadedFile1 =
                                                  true);
                                              var selectedUploadedFiles =
                                                  <FFUploadedFile>[];

                                              try {
                                                showUploadMessage(
                                                  context,
                                                  'Hang tight, we’re uploading your file...',
                                                  showLoading: true,
                                                );
                                                selectedUploadedFiles =
                                                    selectedFiles
                                                        .map((m) =>
                                                            FFUploadedFile(
                                                              name: m
                                                                  .storagePath
                                                                  .split('/')
                                                                  .last,
                                                              bytes: m.bytes,
                                                            ))
                                                        .toList();
                                              } finally {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                                _model.isDataUploading_uploadedFile1 =
                                                    false;
                                              }
                                              if (selectedUploadedFiles
                                                      .length ==
                                                  selectedFiles.length) {
                                                safeSetState(() {
                                                  _model.uploadedLocalFile_uploadedFile1 =
                                                      selectedUploadedFiles
                                                          .first;
                                                });
                                                showUploadMessage(
                                                  context,
                                                  'All set! Your file made it through.',
                                                );
                                              } else {
                                                safeSetState(() {});
                                                showUploadMessage(
                                                  context,
                                                  'Yikes, the upload flopped. Wanna try again?',
                                                );
                                                return;
                                              }
                                            }

                                            logFirebaseEvent(
                                                'Container_custom_action');
                                            _model.fileInfoExtracted =
                                                await actions.extractMetadata(
                                              _model
                                                  .uploadedLocalFile_uploadedFile1,
                                            );
                                            if (_model.fileInfoExtracted
                                                    ?.status ==
                                                'success') {
                                              logFirebaseEvent(
                                                  'Container_show_snack_bar');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    _model.fileInfoExtracted!
                                                        .message,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .info,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMediumIsCustom,
                                                        ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                ),
                                              );
                                              logFirebaseEvent(
                                                  'Container_update_component_state');
                                              _model.uploadedFile =
                                                  _model.fileInfoExtracted;
                                              _model.isUploadedLocally = true;
                                              _model.fileUploaded = true;
                                              safeSetState(() {});
                                              logFirebaseEvent(
                                                  'Container_set_form_field');
                                              safeSetState(() {
                                                _model.textController2?.text =
                                                    _model
                                                        .uploadedFile!.filePath;
                                              });
                                            } else {
                                              logFirebaseEvent(
                                                  'Container_action_block');
                                              await action_blocks
                                                  .universalErrorSnackbar(
                                                context,
                                                errorMessage: _model
                                                    .fileInfoExtracted?.message,
                                              );
                                              logFirebaseEvent(
                                                  'Container_update_component_state');
                                              _model.fileUploaded = false;
                                              safeSetState(() {});
                                            }

                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FFIcons.kcloudUpload,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 36.0,
                                                  ),
                                                  Text(
                                                    'Tap to select a file',
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (_model.fileUploaded)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 6.0, 0.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: AutoSizeText(
                                                  '${valueOrDefault<String>(
                                                    _model.uploadedFile?.name,
                                                    'file.pdf',
                                                  )} Uploaded Successfully.',
                                                  maxLines: 1,
                                                  minFontSize: 10.0,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font: GoogleFonts
                                                            .robotoMono(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                if (valueOrDefault<bool>(
                                  _model.fileUploaded,
                                  false,
                                ))
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 2.0, 0.0, 0.0),
                                      child: Text(
                                        'Uploaded File:',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .labelMediumIsCustom,
                                            ),
                                      ),
                                    ),
                                  ),
                                if (valueOrDefault<bool>(
                                  _model.fileUploaded,
                                  false,
                                ))
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 2.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 25.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                _model.uploadedFile?.name,
                                                'file.pdf',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMediumIsCustom,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                    child: Text(
                                      'Insert Link (Google Drive, Dropbox etc..):',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        width: 10.0,
                                        child: TextFormField(
                                          controller: _model.textController2,
                                          focusNode: _model.textFieldFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.textController2',
                                            Duration(milliseconds: 2000),
                                            () => safeSetState(() {}),
                                          ),
                                          autofocus: false,
                                          readOnly: _model.fileUploaded,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText:
                                                'https://drive.google.com/drive',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumIsCustom,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            suffixIcon: _model.textController2!
                                                    .text.isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model.textController2
                                                          ?.clear();
                                                      safeSetState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.clear,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 22.0,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumIsCustom,
                                              ),
                                          validator: _model
                                              .textController2Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    if (_model.fileUploaded)
                                      Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'ADD_FILES_ALERT_DIALOG_Icon_y131neop_ON_');
                                              logFirebaseEvent(
                                                  'Icon_update_component_state');
                                              _model.fileUploaded = false;
                                              _model.uploadedFile = null;
                                              safeSetState(() {});
                                            },
                                            child: Icon(
                                              Icons.close_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .absentRed,
                                              size: 32.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: (_model.fileUploaded ||
                                              (_model.textController2.text ==
                                                      ''))
                                          ? null
                                          : () async {
                                              logFirebaseEvent(
                                                  'ADD_FILES_ALERT_DIALOG_VERIFY_LINK_BTN_O');
                                              logFirebaseEvent(
                                                  'Button_custom_action');
                                              _model.fileMetadataCopy =
                                                  await actions.fetchFileInfo(
                                                _model.textController2.text,
                                              );
                                              if (_model.fileMetadataCopy
                                                      ?.status ==
                                                  'success') {
                                                logFirebaseEvent(
                                                    'Button_show_snack_bar');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      _model.fileMetadataCopy!
                                                          .message,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMediumIsCustom,
                                                              ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                                );
                                                logFirebaseEvent(
                                                    'Button_update_component_state');
                                                _model.fileUploaded = true;
                                                _model.uploadedFile =
                                                    _model.fileMetadataCopy;
                                                safeSetState(() {});
                                              } else {
                                                logFirebaseEvent(
                                                    'Button_action_block');
                                                await action_blocks
                                                    .universalErrorSnackbar(
                                                  context,
                                                  errorMessage: _model
                                                      .fileMetadataCopy
                                                      ?.message,
                                                );
                                                logFirebaseEvent(
                                                    'Button_update_component_state');
                                                _model.fileUploaded = false;
                                                safeSetState(() {});
                                              }

                                              safeSetState(() {});
                                            },
                                      text: 'Verify Link',
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .titleSmallIsCustom,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        disabledColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                        disabledTextColor: Colors.black,
                                      ),
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Folder',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                    ),
                  ].divide(SizedBox(height: 8.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                      child: FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController ??=
                            FormFieldController<String>(
                          _model.dropDownValue ??= widget.parentPath,
                        ),
                        options: List<String>.from(
                            containerStudyMaterialsRecordList
                                .map((e) => e.nestedPath)
                                .toList()),
                        optionLabels: containerStudyMaterialsRecordList
                            .map((e) => e.fileName)
                            .toList(),
                        onChanged: (val) async {
                          safeSetState(() => _model.dropDownValue = val);
                          logFirebaseEvent(
                              'ADD_FILES_ALERT_DIALOG_DropDown_mnddsqn8');
                          logFirebaseEvent('DropDown_update_component_state');
                          _model.nestedPath = _model.dropDownValue!;
                        },
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: 50.0,
                        searchHintTextStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .labelMediumIsCustom,
                                ),
                        searchTextStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        textStyle: FlutterFlowTheme.of(context)
                            .labelLarge
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .labelLargeIsCustom,
                            ),
                        hintText: 'Select The Folder..',
                        searchHintText: 'Search...',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor: FlutterFlowTheme.of(context).alternate,
                        borderWidth: 2.0,
                        borderRadius: 12.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: true,
                        isMultiSelect: false,
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 45.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        FFIcons.kfolderPlus,
                        color: FlutterFlowTheme.of(context).info,
                        size: 26.0,
                      ),
                      onPressed: () async {
                        logFirebaseEvent(
                            'ADD_FILES_ALERT_DIALOG_folderPlus_ICN_ON');
                        logFirebaseEvent('IconButton_bottom_sheet');
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: AddFolderBottomSheetWidget(),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: FFButtonWidget(
                    onPressed: !_model.fileUploaded
                        ? null
                        : () async {
                            logFirebaseEvent(
                                'ADD_FILES_ALERT_DIALOG_ADD_FILE_BTN_ON_T');
                            if ((_model.uploadedFile?.status == 'success') ||
                                (_model.fileUploaded == true)) {
                              logFirebaseEvent('Button_backend_call');

                              var studyMaterialsRecordReference1 =
                                  StudyMaterialsRecord.collection.doc();
                              await studyMaterialsRecordReference1
                                  .set(createStudyMaterialsRecordData(
                                parentPath: _model.nestedPath,
                                filePath: _model.uploadedFile?.filePath,
                                mimeType: _model.uploadedFile?.mimeType,
                                createdAt: getCurrentTimestamp,
                                fileName:
                                    _model.fileNameTextFieldTextController.text,
                                materialType: StudyMaterialType.file,
                                fileSizeBytes: _model.uploadedFile?.sizeBytes,
                                nestedPath: _model.nestedPath,
                              ));
                              _model.userNewFile =
                                  StudyMaterialsRecord.getDocumentFromData(
                                      createStudyMaterialsRecordData(
                                        parentPath: _model.nestedPath,
                                        filePath: _model.uploadedFile?.filePath,
                                        mimeType: _model.uploadedFile?.mimeType,
                                        createdAt: getCurrentTimestamp,
                                        fileName: _model
                                            .fileNameTextFieldTextController
                                            .text,
                                        materialType: StudyMaterialType.file,
                                        fileSizeBytes:
                                            _model.uploadedFile?.sizeBytes,
                                        nestedPath: _model.nestedPath,
                                      ),
                                      studyMaterialsRecordReference1);
                              if (_model.userNewFile?.reference != null) {
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Your file has been added successfully to the resourses.',
                                      style: GoogleFonts.outfit(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: Color(0xFF37B737),
                                  ),
                                );
                              } else {
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'We were unable to upload the file. Please try again.',
                                      style: GoogleFonts.outfit(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              }
                            } else if ((_model.uploadedFile?.status ==
                                    'success') ||
                                (_model.fileUploaded == true) ||
                                _model.isUploadedLocally) {
                              logFirebaseEvent(
                                  'Button_upload_file_to_firebase');
                              {
                                safeSetState(() => _model
                                    .isDataUploading_uploadDataLpp = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];
                                var selectedFiles = <SelectedFile>[];
                                var downloadUrls = <String>[];
                                try {
                                  showUploadMessage(
                                    context,
                                    'Hang tight, we’re uploading your file...',
                                    showLoading: true,
                                  );
                                  selectedUploadedFiles = _model
                                          .uploadedLocalFile_uploadedFile1
                                          .bytes!
                                          .isNotEmpty
                                      ? [_model.uploadedLocalFile_uploadedFile1]
                                      : <FFUploadedFile>[];
                                  selectedFiles =
                                      selectedFilesFromUploadedFiles(
                                    selectedUploadedFiles,
                                  );
                                  downloadUrls = (await Future.wait(
                                    selectedFiles.map(
                                      (f) async => await uploadData(
                                          f.storagePath, f.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  _model.isDataUploading_uploadDataLpp = false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedFiles.length &&
                                    downloadUrls.length ==
                                        selectedFiles.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile_uploadDataLpp =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl_uploadDataLpp =
                                        downloadUrls.first;
                                  });
                                  showUploadMessage(
                                    context,
                                    'All set! Your file made it through.',
                                  );
                                } else {
                                  safeSetState(() {});
                                  showUploadMessage(
                                    context,
                                    'Yikes, the upload flopped. Wanna try again?',
                                  );
                                  return;
                                }
                              }

                              logFirebaseEvent('Button_backend_call');

                              var studyMaterialsRecordReference2 =
                                  StudyMaterialsRecord.collection.doc();
                              await studyMaterialsRecordReference2
                                  .set(createStudyMaterialsRecordData(
                                parentPath: _model.nestedPath,
                                filePath: _model.uploadedFile?.filePath,
                                mimeType: _model.uploadedFile?.mimeType,
                                createdAt: getCurrentTimestamp,
                                fileName:
                                    _model.fileNameTextFieldTextController.text,
                                materialType: StudyMaterialType.file,
                                fileSizeBytes: _model.uploadedFile?.sizeBytes,
                                nestedPath: _model.nestedPath,
                              ));
                              _model.userNewFile2 =
                                  StudyMaterialsRecord.getDocumentFromData(
                                      createStudyMaterialsRecordData(
                                        parentPath: _model.nestedPath,
                                        filePath: _model.uploadedFile?.filePath,
                                        mimeType: _model.uploadedFile?.mimeType,
                                        createdAt: getCurrentTimestamp,
                                        fileName: _model
                                            .fileNameTextFieldTextController
                                            .text,
                                        materialType: StudyMaterialType.file,
                                        fileSizeBytes:
                                            _model.uploadedFile?.sizeBytes,
                                        nestedPath: _model.nestedPath,
                                      ),
                                      studyMaterialsRecordReference2);
                              if (_model.userNewFile2?.reference != null) {
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Your file has been added successfully to the resourses.',
                                      style: GoogleFonts.outfit(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor: Color(0xFF37B737),
                                  ),
                                );
                              } else {
                                logFirebaseEvent('Button_show_snack_bar');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'We were unable to upload the file. Please try again.',
                                      style: GoogleFonts.outfit(
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              }
                            } else {
                              logFirebaseEvent('Button_action_block');
                              await action_blocks.universalErrorSnackbar(
                                context,
                                errorMessage: 'Select a Valid File To Continue',
                              );
                            }

                            logFirebaseEvent('Button_dismiss_dialog');
                            Navigator.pop(context);

                            safeSetState(() {});
                          },
                    text: 'Add File',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .labelLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(12.0),
                      disabledColor: FlutterFlowTheme.of(context).secondaryText,
                      disabledTextColor: Colors.black,
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 4.0)),
            ),
          ),
        );
      },
    );
  }
}
