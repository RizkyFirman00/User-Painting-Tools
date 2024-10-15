import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/pages/home.dart';

class SplashScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController npkController = TextEditingController();

  SplashScreen({super.key});

  void _login(BuildContext context) async {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    String email = emailController.text;
    String npk = npkController.text;

    if (email.isEmpty && npk.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email dan NPK tidak boleh kosong")));
      return;
    }

    if (npk.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("NPK tidak boleh kurang dari 6 karakter")));
      return;
    }

    bool loginSuccess = await userProvider.loginUser(email, npk);

    if (loginSuccess) {
      Get.off(Home());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login gagal, silakan coba lagi.")));
      npkController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: const Color(0xfffbf0f3),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: npkController,
                      decoration: InputDecoration(
                          labelText: 'NPK',
                          filled: true,
                          fillColor: const Color(0xfffbf0f3),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () => _login(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffDF042C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 80.0),
                      ),
                      child: const Text(
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
    );
  }
}
