import '/auth/firebase_auth/auth_util.dart';
import '/components/class_notification_config_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'customize_notifications_model.dart';
export 'customize_notifications_model.dart';

class CustomizeNotificationsWidget extends StatefulWidget {
  const CustomizeNotificationsWidget({super.key});

  static String routeName = 'customizeNotifications';
  static String routePath = 'customizeNotifications';

  @override
  State<CustomizeNotificationsWidget> createState() =>
      _CustomizeNotificationsWidgetState();
}

class _CustomizeNotificationsWidgetState
    extends State<CustomizeNotificationsWidget> {
  late CustomizeNotificationsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomizeNotificationsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'customizeNotifications'});
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
        title: 'customizeNotifications',
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
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
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
                                    'CUSTOMIZE_NOTIFICATIONS_Icon_j1e353he_ON');
                                logFirebaseEvent('Icon_navigate_back');
                                context.safePop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 32.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Customise Notifications',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineSmallIsCustom,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => Builder(
                          builder: (context) {
                            final coursesEnrolledList = (currentUserDocument
                                        ?.coursesEnrolled
                                        .toList() ??
                                    [])
                                .map((e) => e)
                                .toList()
                                .take(10)
                                .toList();

                            return ListView.separated(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                20.0,
                                0,
                                0,
                              ),
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: coursesEnrolledList.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 4.0),
                              itemBuilder: (context, coursesEnrolledListIndex) {
                                final coursesEnrolledListItem =
                                    coursesEnrolledList[
                                        coursesEnrolledListIndex];
                                return wrapWithModel(
                                  model: _model.classNotificationConfigModels
                                      .getModel(
                                    coursesEnrolledListItem.courseID,
                                    coursesEnrolledListIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: ClassNotificationConfigWidget(
                                    key: Key(
                                      'Keyhu5_${coursesEnrolledListItem.courseID}',
                                    ),
                                    className:
                                        coursesEnrolledListItem.courseName,
                                    courseID: coursesEnrolledListItem.courseID,
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
          ),
        ));
  }
}
