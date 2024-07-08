import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utsmeconnect/src/features/home/view/screens/power_screen.dart';
import 'package:utsmeconnect/src/features/navigation_bar/view/screens/utsmeconnect_navigation_bar.dart';
import 'package:utsmeconnect/src/features/settings/view/screens/settings_screen.dart';
import 'package:utsmeconnect/src/features/splash/view/screens/splash_screen.dart';

enum UTSMEConnectRoutes {
  splash,
  power,
  settings,
}

class UTSMEConnectRouter {
  // ensure this class cannot be initialized
  UTSMEConnectRouter._();

  // private navigator key
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorPower = GlobalKey<NavigatorState>();
  static final _rootNavigatorSettings = GlobalKey<NavigatorState>();

  // static is very important to prevent
  // the splash screen from always replaying
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/${UTSMEConnectRoutes.splash.name}",
    routes: <RouteBase>[
      // Splash Branch
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: "/${UTSMEConnectRoutes.splash.name}",
        name: UTSMEConnectRoutes.splash.name,
        builder: (context, state) => SplashScreen(key: state.pageKey),
      ),

      // UTS:ME Connect - Navigation Bar Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            UTSMEConnectNavigationBar(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          // Home Branch
          StatefulShellBranch(
            navigatorKey: _rootNavigatorPower,
            routes: [
              GoRoute(
                path: "/${UTSMEConnectRoutes.power.name}",
                name: UTSMEConnectRoutes.power.name,
                builder: (context, state) => PowerScreen(key: state.pageKey),
              )
            ],
          ),

          // Settings Branch
          StatefulShellBranch(
            navigatorKey: _rootNavigatorSettings,
            routes: [
              GoRoute(
                path: "/${UTSMEConnectRoutes.settings.name}",
                name: UTSMEConnectRoutes.settings.name,
                builder: (context, state) => SettingsScreen(key: state.pageKey),
              )
            ],
          ),
        ],
      ),
    ],
  );
}
