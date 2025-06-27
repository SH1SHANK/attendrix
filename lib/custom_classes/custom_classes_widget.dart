import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/class_info_block_custom_widget.dart';
import '/components/custom_class_widget.dart';
import '/empty_list_comp/empty_class/empty_class_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'custom_classes_model.dart';
export 'custom_classes_model.dart';

class CustomClassesWidget extends StatefulWidget {
  const CustomClassesWidget({super.key});

  static String routeName = 'customClasses';
  static String routePath = 'customClasses';

  @override
  State<CustomClassesWidget> createState() => _CustomClassesWidgetState();
}

class _CustomClassesWidgetState extends State<CustomClassesWidget> {
  late CustomClassesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomClassesModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'customClasses'});
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
        title: 'customClasses',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton.extended(
                onPressed: () async {
                  logFirebaseEvent('CUSTOM_CLASSES_FloatingActionButton_rrxz');
                  logFirebaseEvent('FloatingActionButton_alert_dialog');
                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(dialogContext).unfocus();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: CustomClassWidget(),
                        ),
                      );
                    },
                  );
                },
                backgroundColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(
                  FFIcons.kplus,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                elevation: 8.0,
                label: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Add Class',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelLargeFamily,
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .labelLargeIsCustom,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'CUSTOM_CLASSES_PAGE_Icon_ra1clupu_ON_TAP');
                            logFirebaseEvent('Icon_navigate_to');

                            context.pushNamed(DashboardWidget.routeName);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 32.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              6.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Manage Custom Classes',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: StreamBuilder<List<CustomClassesRecord>>(
                        stream: queryCustomClassesRecord(
                          parent: currentUserReference,
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
                          List<CustomClassesRecord>
                              listViewCustomClassesRecordList = snapshot.data!;
                          if (listViewCustomClassesRecordList.isEmpty) {
                            return Center(
                              child: EmptyClassWidget(
                                imageUrl:
                                    'https://cdn-icons-gif.flaticon.com/11324/11324089.gif',
                                title: 'No Custom Classes Yet',
                                description:
                                    'Start by creating a custom class to see it listed here.',
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewCustomClassesRecordList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 4.0),
                            itemBuilder: (context, listViewIndex) {
                              final listViewCustomClassesRecord =
                                  listViewCustomClassesRecordList[
                                      listViewIndex];
                              return wrapWithModel(
                                model:
                                    _model.classInfoBlockCustomModels.getModel(
                                  listViewCustomClassesRecord.reference.id,
                                  listViewIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: ClassInfoBlockCustomWidget(
                                  key: Key(
                                    'Keywpe_${listViewCustomClassesRecord.reference.id}',
                                  ),
                                  classRecord: listViewCustomClassesRecord,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ].addToStart(SizedBox(height: 30.0)),
                ),
              ),
            ),
          ),
        ));
  }
}
