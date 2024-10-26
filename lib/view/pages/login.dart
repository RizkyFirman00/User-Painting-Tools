import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/view/pages/admin/home_admin.dart';
import 'package:user_painting_tools/view/pages/user/home_user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordVisiblePressed = true;
  final TextEditingController npkController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    String npk = npkController.text;
    String password = passwordController.text;

    if (npk.isEmpty && password.isEmpty) {
      Get.snackbar(
          'Perhatikan lagi', 'Silahkan Isi NPK & Password terlebih dahulu');
      return;
    }

    if (npk.isEmpty) {
      Get.snackbar('Perhatikan lagi', 'Silahkan Isi NPK terlebih dahulu');
      return;
    }

    if (password.isEmpty) {
      Get.snackbar('Perhatikan lagi', 'Silahkan Isi NPK terlebih dahulu');
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
          'Perhatikan lagi', 'Password tidak boleh kurang dari 6 karakter');
      return;
    }

    if (!await _checkInternetConnection()) {
      Get.snackbar(
          'Terjadi kesalahan', 'Tidak ada koneksi internet, coba lagi nanti');
      return;
    }

    try {
      bool loginSuccess = await usersProvider.loginUser(npk, password);

      if (loginSuccess) {
        final bool? isAdminUser = await SharedPreferencesUsers.getIsAdmin();
        if (isAdminUser != null) {
          if (isAdminUser) {
            Get.off(const HomeAdmin());
            Get.snackbar('Selamat datang admin ', npkController.text);
          } else {
            Get.off(const HomeUser());
            Get.snackbar('Selamat datang ', npkController.text);
          }
        } else {
          Get.snackbar('Terjadi kesalahan', 'Password atau NPK salah');
          _clearInputFields();
        }
      } else {
        Get.snackbar('Terjadi kesalahan', 'Password atau NPK salah');
        _clearInputFields();
      }
    } catch (e) {
      Get.snackbar('Login Gagal', e.toString());
      _clearInputFields();
    }
  }

  Future<void> _setStatusBarColor() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFDF042C),
    ));
  }

  void _clearInputFields() {
    passwordController.clear();
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _setStatusBarColor();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: true);
    final isLoading = userProvider.isLoading;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/bg_atas.png"),
                Column(
                  children: [
                    SizedBox(
                      width: 207,
                      height: 155,
                      child: Image.asset("assets/images/logo_kyb.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: npkController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              labelText: 'NPK',
                              hintText: 'Masukkan NPK Kamu',
                              filled: true,
                              fillColor: const Color(0xfffbf0f3),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              disabledBorder: themeTextForm(),
                              enabledBorder: themeTextForm(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: isPasswordVisiblePressed,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            controller: passwordController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              suffixIcon: Container(
                                margin: EdgeInsets.all(5),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisiblePressed =
                                          !isPasswordVisiblePressed;
                                    });
                                  },
                                  icon: isPasswordVisiblePressed
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                              ),
                              disabledBorder: themeTextForm(),
                              enabledBorder: themeTextForm(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              labelText: 'Password',
                              hintText: 'Masukkan Password Kamu',
                              filled: true,
                              fillColor: const Color(0xfffbf0f3),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    _login(context);
                                  },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xffDF042C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 80.0),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset("assets/images/bg_bawah.png"),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Created by ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "Ikhwan Fadhilah",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder themeTextForm() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );
  }
}
