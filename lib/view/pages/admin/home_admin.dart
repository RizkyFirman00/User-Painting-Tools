import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:user_painting_tools/view/pages/admin/loans_page.dart';
import 'package:user_painting_tools/view/pages/admin/tools_page.dart';
import 'package:user_painting_tools/view/pages/admin/users_page.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

void _setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: const Color(0xFF0099FF), // Light Blue
  ));
}

class _HomeAdminState extends State<HomeAdmin> {
  final Color _lightBlue = const Color(0xff0099FF);
  final PersistentTabController _bottomNavBarController =
  PersistentTabController(initialIndex: 0);

  // List of pages to navigate to
  final List<Widget> _screens = [
    const UsersPage(),
    const ToolsPage(),
    const LoansPage(),
  ];

  @override
  void initState() {
    _setStatusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.07; // Adjust icon size based on screen width
    double bottomNavBarHeight = MediaQuery.of(context).orientation == Orientation.portrait
        ? kBottomNavigationBarHeight
        : kBottomNavigationBarHeight * 1.5; // Adjust for landscape

    return SafeArea(
      child: PersistentTabView(
        context,
        controller: _bottomNavBarController,
        screens: _screens,
        hideNavigationBarWhenKeyboardAppears: true,
        backgroundColor: Colors.white,
        confineToSafeArea: true,
        navBarHeight: bottomNavBarHeight, // Adjust nav bar height based on orientation
        navBarStyle: NavBarStyle.style10, // Customize style as needed
        items: [
          PersistentBottomNavBarItem(
            icon: Icon(Icons.person, size: iconSize), // Use relative size for icons
            title: 'Pengguna',
            activeColorPrimary: _lightBlue,
            activeColorSecondary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.systemGrey,
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035, // Responsive text size
              fontWeight: FontWeight.w400,
            ),
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.inventory_2, size: iconSize),
            title: 'Barang',
            activeColorPrimary: _lightBlue,
            activeColorSecondary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.systemGrey,
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              fontWeight: FontWeight.w400,
            ),
          ),
          PersistentBottomNavBarItem(
            icon: Icon(Icons.loop, size: iconSize),
            title: 'Peminjaman',
            activeColorPrimary: _lightBlue,
            activeColorSecondary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.systemGrey,
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
