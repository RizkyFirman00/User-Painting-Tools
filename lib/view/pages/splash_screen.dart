import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/view/pages/admin/home_admin.dart';
import 'package:user_painting_tools/view/pages/login.dart';
import 'package:user_painting_tools/view/pages/user/home_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SimpleLogger _simpleLogger = SimpleLogger();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        checkLoginStatus();
      },
    );
  }

  Future<void> checkLoginStatus() async {
    bool isUserLoggedIn = await SharedPreferencesUsers.isLoggedIn();
    bool? isAdmin = await SharedPreferencesUsers.getIsAdmin();
    _simpleLogger.info(isAdmin);
    if (isUserLoggedIn && isAdmin != null) {
      if (isAdmin) {
        Get.off(() => const HomeAdmin());
      } else {
        Get.off(() => const HomeUser());
      }
    } else {
      Get.off(() => const Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 300,
            width: 300,
            child: Image.asset("assets/images/logo_kyb.png"),
          ),
        ),
      ),
    );
  }
}
