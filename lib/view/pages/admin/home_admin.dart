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
    statusBarColor: Color(0xFF0099FF),
  ));
}

class _HomeAdminState extends State<HomeAdmin> {
  final Color _lightBlue = const Color(0xff0099FF);
  final PersistentTabController _bottomNavBarController =
      PersistentTabController(initialIndex: 0);

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
    return SafeArea(
      child: PersistentTabView(
        resizeToAvoidBottomInset: false,
        context,
        controller: _bottomNavBarController,
        screens: _screens,
        hideNavigationBarWhenKeyboardAppears: true,
        backgroundColor: Colors.white,
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: NavBarStyle.style10,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: 'Pengguna',
            activeColorPrimary: _lightBlue,
            activeColorSecondary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.systemGrey,
            textStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.inventory_2),
            title: 'Barang',
            activeColorPrimary: _lightBlue,
            activeColorSecondary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.systemGrey,
            textStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.loop),
            title: 'Peminjaman',
            activeColorPrimary: _lightBlue,
            activeColorSecondary: CupertinoColors.white,
            inactiveColorPrimary: CupertinoColors.systemGrey,
            textStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
