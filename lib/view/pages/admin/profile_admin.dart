import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/view/pages/login.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  final Color _lightBlue = const Color(0xFF0099FF);
  final TextEditingController npkController = TextEditingController();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loadCurrentUserData() async {
    try {
      String? passwordUser = await SharedPreferencesUsers.getNpk();
      if (passwordUser != null && passwordUser.isNotEmpty) {
        final userProvider = Provider.of<UsersProvider>(context, listen: false);
        await userProvider.fetchUserDataWithNpk(passwordUser);

        if (userProvider.currentUser != null) {
          npkController.text = userProvider.currentUser!.npkUser;
          passwordController.text = userProvider.currentUser!.passwordUser;
          namaLengkapController.text = userProvider.currentUser!.namaLengkap!;
        }
      } else {
        if (kDebugMode) {
          print('NPK tidak ditemukan di SharedPreferences.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching NPK or user data: $e');
      }
    }
  }

  Future<void> _setStatusBarColor() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0099FF),
    ));
  }

  bool isThereLongName() {
    if (npkController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void logoutUser() async {
    await SharedPreferencesUsers.clearLoginData();
    Get.offAll(() => const Login());
  }

  @override
  void initState() {
    _setStatusBarColor();
    loadCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: true);
    bool isLoading = userProvider.isLoading;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: _lightBlue,
          centerTitle: true,
          title: const Text(
            "Profil Pengguna",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationBox(
                        textTitle: "Logout",
                        textDescription:
                            "Apakah kamu yakin ingin keluar dari akun ini?",
                        textConfirm: "Iya",
                        textCancel: "Tidak",
                        onConfirm: () async {
                          logoutUser();
                          Get.snackbar('Logout', 'Akun berhasil keluar');
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.logout_outlined),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: isLoading
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: npkController,
                          enabled: isThereLongName() ? false : true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.numbers,
                              color: _lightBlue,
                            ),
                            hintText: "NPK",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          controller: namaLengkapController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person, color: _lightBlue),
                            hintText: "Nama Lengkap",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          controller: passwordController,
                          enabled: isThereLongName() ? false : true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.password, color: _lightBlue),
                            hintText: "Password",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () async {
                  await userProvider
                      .updateLongName(namaLengkapController.text.trim());
                  Get.snackbar('Sukses', 'Nama lengkap berhasil diperbarui');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 100.0),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
