import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utsmeconnect/src/features/dashboard/view/screens/dashboard_screen.dart';
import 'package:utsmeconnect/src/features/power/view/screens/power_screen.dart';
import 'package:utsmeconnect/src/features/navigation_bar/view/screens/utsmeconnect_navigation_bar.dart';
import 'package:utsmeconnect/src/features/settings/view/screens/settings_screen.dart';
import 'package:utsmeconnect/src/features/splash/view/screens/splash_screen.dart';
import 'package:utsmeconnect/src/features/temperature/view/screens/temperature_screen.dart';

enum UTSMEConnectRoutes {
  splash,
  dashboard,
  power,
  temperature,
  settings,
}

class UTSMEConnectRouter {
  // ensure this class cannot be initialized
  UTSMEConnectRouter._();

  // private navigator key
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorDashboard = GlobalKey<NavigatorState>();
  static final _rootNavigatorPower = GlobalKey<NavigatorState>();
  static final _rootNavigatorTemperature = GlobalKey<NavigatorState>();
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
          // Dashboard Branch
          StatefulShellBranch(
            navigatorKey: _rootNavigatorDashboard,
            routes: [
              GoRoute(
                path: "/${UTSMEConnectRoutes.dashboard.name}",
                name: UTSMEConnectRoutes.dashboard.name,
                builder: (context, state) =>
                    DashboardScreen(key: state.pageKey),
              )
            ],
          ),

          // Power Branch
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

          // Temperature Branch
          StatefulShellBranch(
            navigatorKey: _rootNavigatorTemperature,
            routes: [
              GoRoute(
                path: "/${UTSMEConnectRoutes.temperature.name}",
                name: UTSMEConnectRoutes.temperature.name,
                builder: (context, state) =>
                    TemperatureScreen(key: state.pageKey),
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
