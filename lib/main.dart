import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final environmentValues = FFDevEnvironmentValues();
  await environmentValues.initialize();

  await initFirebase();

  // Start initial custom actions code
  await actions.initializeOneSignal();
  await actions.initializeHiveSystem();
  // End initial custom actions code

  await SupaFlow.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = attendrixFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Attendrix',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          interactive: false,
          thickness: WidgetStateProperty.all(2.0),
          radius: Radius.circular(12.0),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.dragged)) {
              return Color(4293823328);
            }
            if (states.contains(WidgetState.hovered)) {
              return Color(4293823328);
            }
            return Color(4293823328);
          }),
          minThumbLength: 10.0,
        ),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'dashboard';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'dashboard': DashboardWidget(),
      'attendance': AttendanceWidget(),
      'calender': CalenderWidget(),
      'classes': ClassesWidget(),
      'tasks': TasksWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        color: FlutterFlowTheme.of(context).secondaryText,
        activeColor: FlutterFlowTheme.of(context).info,
        tabBackgroundColor: FlutterFlowTheme.of(context).primary,
        tabBorderRadius: 48.0,
        tabMargin: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
        padding: EdgeInsetsDirectional.fromSTEB(6.0, 4.0, 6.0, 4.0),
        gap: 5.0,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        duration: Duration(milliseconds: 500),
        haptic: false,
        tabs: [
          GButton(
            icon: currentIndex == 0 ? FFIcons.khome : FFIcons.khomeHouse5,
            text: 'Dashboard',
            textStyle: GoogleFonts.outfit(
              color: FlutterFlowTheme.of(context).info,
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
            ),
            iconSize: 16.0,
          ),
          GButton(
            icon: currentIndex == 1 ? FFIcons.kchartDots : FFIcons.kchartDots,
            text: 'Attendance',
            textStyle: GoogleFonts.outfit(
              color: FlutterFlowTheme.of(context).info,
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
            ),
            iconSize: 16.0,
          ),
          GButton(
            icon: currentIndex == 2
                ? FFIcons.kbxsCalendar
                : FFIcons.kcalendarDays,
            text: 'Calender',
            textStyle: GoogleFonts.outfit(
              color: FlutterFlowTheme.of(context).info,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
            iconSize: 18.0,
          ),
          GButton(
            icon:
                currentIndex == 3 ? FFIcons.kbxsNotepad : FFIcons.knotepadBold,
            text: 'Classes',
            textStyle: GoogleFonts.outfit(
              color: FlutterFlowTheme.of(context).info,
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
            ),
            iconSize: 16.0,
          ),
          GButton(
            icon: currentIndex == 4 ? FFIcons.ktask01 : FFIcons.knotebook,
            text: 'Tasks',
            textStyle: GoogleFonts.outfit(
              color: FlutterFlowTheme.of(context).info,
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
            ),
            iconSize: 16.0,
          )
        ],
      ),
    );
  }
}
