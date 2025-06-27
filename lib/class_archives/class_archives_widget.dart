import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/class_archive_block_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'class_archives_model.dart';
export 'class_archives_model.dart';

class ClassArchivesWidget extends StatefulWidget {
  const ClassArchivesWidget({super.key});

  static String routeName = 'classArchives';
  static String routePath = 'classArchives';

  @override
  State<ClassArchivesWidget> createState() => _ClassArchivesWidgetState();
}

class _ClassArchivesWidgetState extends State<ClassArchivesWidget> {
  late ClassArchivesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassArchivesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'classArchives'});
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
        title: 'classArchives',
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
                                'CLASS_ARCHIVES_PAGE_Icon_f9xdwscc_ON_TAP');
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
                            'Class Archives',
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
                                  'CLASS_ARCHIVES_DropDown_3g4v0rst_ON_FORM');
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
                                    'CLASS_ARCHIVES_PAGE_Icon_fpxq9281_ON_TAP');
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: FutureBuilder<List<PersonalRecordsRecord>>(
                      future: queryPersonalRecordsRecordOnce(
                        parent: currentUserReference,
                        queryBuilder: (personalRecordsRecord) =>
                            personalRecordsRecord
                                .where(
                                  'entity_type',
                                  isEqualTo:
                                      RecordType.timetableRecord.serialize(),
                                )
                                .where(
                                  'courseID',
                                  isEqualTo: _model.filter != ''
                                      ? _model.filter
                                      : null,
                                )
                                .orderBy('created_at', descending: true),
                        limit: 12,
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
                        List<PersonalRecordsRecord>
                            listViewPersonalRecordsRecordList = snapshot.data!;

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewPersonalRecordsRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 3.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewPersonalRecordsRecord =
                                listViewPersonalRecordsRecordList[
                                    listViewIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: wrapWithModel(
                                model: _model.classArchiveBlockModels.getModel(
                                  listViewPersonalRecordsRecord.reference.id,
                                  listViewIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: ClassArchiveBlockWidget(
                                  key: Key(
                                    'Key6sy_${listViewPersonalRecordsRecord.reference.id}',
                                  ),
                                  classRecord: listViewPersonalRecordsRecord,
                                  indexInList: listViewIndex,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
