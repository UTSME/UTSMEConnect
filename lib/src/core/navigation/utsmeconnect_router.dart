import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utsmeconnect/src/features/home/view/screens/home_screen.dart';
import 'package:utsmeconnect/src/features/navigation_bar/view/screens/utsmeconnect_navigation_bar.dart';
import 'package:utsmeconnect/src/features/settings/view/screens/settings_screen.dart';
import 'package:utsmeconnect/src/features/splash/view/screens/splash_screen.dart';

class UTSMEConnectRouter {
  // ensure this class cannot be initialized
  UTSMEConnectRouter._();

  // private navigator key
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>();
  static final _rootNavigatorSettings = GlobalKey<NavigatorState>();

  // static is very important to prevent
  // the splash screen from always replaying
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/splash",
    routes: <RouteBase>[
      // Splash Branch
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: "/splash",
        name: "Splash",
        builder: (context, state) => SplashScreen(key: state.pageKey),
      ),

      // UTS:ME Connect - Navigation Bar Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            UTSMEConnectNavigationBar(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          // Home Branch
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: "/power",
                name: "Power",
                builder: (context, state) => HomeScreen(key: state.pageKey),
              )
            ],
          ),

          // Settings Branch
          StatefulShellBranch(
            navigatorKey: _rootNavigatorSettings,
            routes: [
              GoRoute(
                path: "/settings",
                name: "Settings",
                builder: (context, state) => SettingsScreen(key: state.pageKey),
              )
            ],
          ),
        ],
      ),
    ],
  );
}
