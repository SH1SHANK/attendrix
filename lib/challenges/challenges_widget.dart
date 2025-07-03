import '/auth/firebase_auth/auth_util.dart';
import '/components/challenge_block_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'challenges_model.dart';
export 'challenges_model.dart';

class ChallengesWidget extends StatefulWidget {
  const ChallengesWidget({super.key});

  static String routeName = 'challenges';
  static String routePath = 'challenges';

  @override
  State<ChallengesWidget> createState() => _ChallengesWidgetState();
}

class _ChallengesWidgetState extends State<ChallengesWidget>
    with TickerProviderStateMixin {
  late ChallengesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChallengesModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'challenges'});
    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
        title: 'challenges',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/Red_Moon_Skyline_(1).jpeg',
                  ).image,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'CHALLENGES_PAGE_Icon_o6zgcx9a_ON_TAP');
                              logFirebaseEvent('Icon_navigate_back');
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: FlutterFlowTheme.of(context).info,
                              size: 36.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Icon(
                            Icons.settings_sharp,
                            color: FlutterFlowTheme.of(context).info,
                            size: 28.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 60.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.95,
                        height: MediaQuery.sizeOf(context).height * 0.65,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 0.0, 0.0),
                                    child: Text(
                                      'Goal Board',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily,
                                            fontSize: 22.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelLargeIsCustom,
                                          ),
                                    ),
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    if (_model.tabBarCurrentIndex == 0) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 12.0, 0.0),
                                        child: Container(
                                          width: 120.0,
                                          height: 30.0,
                                          child: custom_widgets
                                              .CountdownTimerWidget(
                                            width: 120.0,
                                            height: 30.0,
                                            isWeekly: true,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            includeDays: true,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 40.0, 0.0),
                                        child: Container(
                                          width: 120.0,
                                          height: 30.0,
                                          child: custom_widgets
                                              .CountdownTimerWidget(
                                            width: 120.0,
                                            height: 30.0,
                                            isWeekly: false,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            includeDays: true,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0.0, 0),
                                    child: TabBar(
                                      labelColor:
                                          FlutterFlowTheme.of(context).primary,
                                      unselectedLabelColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelLargeIsCustom,
                                          ),
                                      unselectedLabelStyle: FlutterFlowTheme.of(
                                              context)
                                          .labelLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelLargeFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .labelLargeIsCustom,
                                          ),
                                      indicatorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      tabs: [
                                        Tab(
                                          text: 'This Week',
                                        ),
                                        Tab(
                                          text: 'This Month',
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        KeepAliveWidgetWrapper(
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            primary: false,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 6.0, 4.0, 0.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        Builder(
                                                      builder: (context) {
                                                        final weeklyChallenges =
                                                            (currentUserDocument
                                                                        ?.challengesAllotted
                                                                        .toList() ??
                                                                    [])
                                                                .toList()
                                                                .take(4)
                                                                .toList();

                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              weeklyChallenges
                                                                  .length,
                                                          itemBuilder: (context,
                                                              weeklyChallengesIndex) {
                                                            final weeklyChallengesItem =
                                                                weeklyChallenges[
                                                                    weeklyChallengesIndex];
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          2.0),
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .challengeBlockModels1
                                                                    .getModel(
                                                                  weeklyChallengesItem
                                                                      .challengeID,
                                                                  weeklyChallengesIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                updateOnChange:
                                                                    true,
                                                                child:
                                                                    ChallengeBlockWidget(
                                                                  key: Key(
                                                                    'Keyape_${weeklyChallengesItem.challengeID}',
                                                                  ),
                                                                  challengeRecord:
                                                                      weeklyChallengesItem,
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
                                        KeepAliveWidgetWrapper(
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            primary: false,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 6.0, 4.0, 0.0),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        Builder(
                                                      builder: (context) {
                                                        final monthlyChallenges =
                                                            (currentUserDocument
                                                                        ?.challengesAllotted
                                                                        .toList() ??
                                                                    [])
                                                                .where((e) =>
                                                                    (String
                                                                        var1) {
                                                                      return var1
                                                                          .toLowerCase()
                                                                          .startsWith(
                                                                              'm');
                                                                    }(e.challengeID))
                                                                .toList()
                                                                .take(4)
                                                                .toList();

                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              monthlyChallenges
                                                                  .length,
                                                          itemBuilder: (context,
                                                              monthlyChallengesIndex) {
                                                            final monthlyChallengesItem =
                                                                monthlyChallenges[
                                                                    monthlyChallengesIndex];
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          2.0),
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .challengeBlockModels2
                                                                    .getModel(
                                                                  monthlyChallengesItem
                                                                      .challengeID,
                                                                  monthlyChallengesIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                updateOnChange:
                                                                    true,
                                                                child:
                                                                    ChallengeBlockWidget(
                                                                  key: Key(
                                                                    'Keypg9_${monthlyChallengesItem.challengeID}',
                                                                  ),
                                                                  challengeRecord:
                                                                      monthlyChallengesItem,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
