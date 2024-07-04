import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';

class UTSMEConnectNavigationBar extends StatefulWidget {
  const UTSMEConnectNavigationBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<UTSMEConnectNavigationBar> createState() =>
      _UTSMEConnectNavigationBarState();
}

class _UTSMEConnectNavigationBarState extends State<UTSMEConnectNavigationBar> {
  int selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: UTSMEConnectColors.kBackgroundSecondary,
        selectedItemColor: UTSMEConnectColors.kSelectedItem,
        unselectedItemColor: Colors.white70,
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
            icon: Icon(Icons.electric_bolt),
            label: "Power Readings",
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
