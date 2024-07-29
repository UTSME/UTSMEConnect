import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';

class UTSMEConnectNavigationBar extends ConsumerStatefulWidget {
  const UTSMEConnectNavigationBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<UTSMEConnectNavigationBar> createState() =>
      _UTSMEConnectNavigationBarState();
}

class _UTSMEConnectNavigationBarState
    extends ConsumerState<UTSMEConnectNavigationBar> {
  int selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    // retrieve the theme controller
    UTSMEConnectThemeController themeController =
        ref.watch(utsmeConnectThemeControllerProvider.notifier);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeController.getBackgroundSecondaryColor(),
        selectedItemColor: themeController.getActiveItemColor(),
        unselectedItemColor: themeController.getTextColor(),
        currentIndex: selectedIndex,
        iconSize: 30,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          _goToBranch(selectedIndex);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.speed_rounded),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_bolt),
            label: "Power",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: "Temperature",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
