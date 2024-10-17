import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController npkController = TextEditingController();

  void _login(BuildContext context) async {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    String email = emailController.text;
    String npk = npkController.text;

    if (email.isEmpty && npk.isEmpty) {
      Get.snackbar(
          'Perhatikan lagi', 'Silahkan Isi Email & NPK terlebih dahulu');
      return;
    }

    if (email.isEmpty) {
      Get.snackbar('Perhatikan lagi', 'Silahkan Isi Email terlebih dahulu');
      return;
    }

    if (npk.isEmpty) {
      Get.snackbar('Perhatikan lagi', 'Silahkan Isi NPK terlebih dahulu');
      return;
    }

    if (npk.length < 6) {
      Get.snackbar('Perhatikan lagi', 'NPK tidak boleh kurang dari 6 karakter');
      return;
    }

    if (!await _checkInternetConnection()) {
      Get.snackbar(
          'Terjadi kesalahan', 'Tidak ada koneksi internet, coba lagi nanti');
      return;
    }

    try {
      bool loginSuccess = await usersProvider.loginUser(email, npk);

      if (loginSuccess) {
        Get.off(const Home());
        Get.snackbar(
            'Selamat datang ', emailController.text);
      } else {
        Get.snackbar('Terjadi kesalahan', 'Password atau NPK salah');
        _clearInputFields();
      }
    } catch (e) {
      Get.snackbar('Terjadi kesalahan', e.toString());
      _clearInputFields();
    }
  }

  void _clearInputFields() {
    npkController.clear();
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
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: true);
    final isLoading = userProvider.isLoading;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery
                .of(context)
                .size
                .width,
            minHeight: MediaQuery
                .of(context)
                .size
                .height,
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
                            controller: emailController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Masukkan Email Kamu',
                              filled: true,
                              fillColor: const Color(0xfffbf0f3),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              disabledBorder: themeTextForm(),
                              enabledBorder: themeTextForm(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: npkController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              disabledBorder: themeTextForm(),
                              enabledBorder: themeTextForm(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              labelText: 'NPK',
                              hintText: 'Masukkan NPK Kamu',
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
                            onPressed: () {
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
                                ? Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                                : Text(
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
                      child: Text(
                        "Tools Painting I",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
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
