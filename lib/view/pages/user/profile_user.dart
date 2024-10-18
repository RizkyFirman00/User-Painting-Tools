import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/view/pages/login.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController npkController = TextEditingController();

  Future<void> fetchDataToInput() async {
    try {
      String? npkUser = await SharedPreferencesUsers.getNpk();

      if (npkUser != null && npkUser.isNotEmpty) {
        final userProvider = Provider.of<UsersProvider>(context, listen: false);
        await userProvider.fetchUserDataFromFirestoreWithNpk(npkUser);

        if (userProvider.currentUser != null) {
          emailController.text = userProvider.currentUser!.emailUser;
          npkController.text = userProvider.currentUser!.npkUser;
          namaLengkapController.text = userProvider.currentUser!.namaLengkap!;
        }
      } else {
        print('NPK tidak ditemukan di SharedPreferences.');
      }
    } catch (e) {
      print('Error fetching NPK or user data: $e');
    }
  }

  bool isThereLongName() {
    if (emailController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void logoutUser() async {
    await SharedPreferencesUsers.clearLoginData();
    Get.off(() => const Login());
  }

  @override
  void initState() {
    fetchDataToInput();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: true);
    bool isLoading = userProvider.isLoading;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFFDF042C),
        centerTitle: true,
        title: Text(
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
                logoutUser();
                Get.snackbar(
                    'Logout', 'Akun berhasil keluar');
              },
              icon: Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
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
                          controller: emailController,
                          enabled: isThereLongName() ? false : true,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Color(0xffDF042C),
                            ),
                            hintText: "Email",
                            border: OutlineInputBorder(
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
                            icon: Icon(Icons.person, color: Color(0xffDF042C)),
                            hintText: "Nama Lengkap",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          controller: npkController,
                          enabled: isThereLongName() ? false : true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.numbers, color: Color(0xffDF042C)),
                            hintText: "NPK",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await userProvider.updateNamaLengkap(
                                namaLengkapController.text.trim());
                            Get.snackbar(
                                'Sukses', 'Nama lengkap berhasil diperbarui');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xffDF042C),
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
                      ],
                    ),
                  ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  child: Image.asset("assets/images/bg_bawah_user.png"),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Tools Painting I",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
