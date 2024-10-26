import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';

class AddUsersAdmin extends StatelessWidget {
  const AddUsersAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: true);
    bool isLoading = userProvider.isLoading;

    final TextEditingController npkController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final Color _lightBlue = Color(0xFF0099FF);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: _lightBlue,
          centerTitle: true,
          title: Text(
            "Tambah Pengguna",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
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
                          controller: passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.password, color: _lightBlue),
                            hintText: "Password",
                            border: OutlineInputBorder(
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
                onPressed: isLoading
                    ? null
                    : () async {
                        if (passwordController.text.length < 6) {
                          passwordController.text = '';
                          Get.snackbar('Gagal',
                              'Password tidak boleh kurang dari 6 karakter');
                        } else {
                          if(userProvider.statusMessage == 'User Berhasil Ditambahkan') {
                            await userProvider.addUser(npkController.text, passwordController.text);
                            Get.snackbar(
                                'Sukses', 'Berhasil menambahkan user baru');
                          } else {
                            Get.snackbar('Gagal',
                                'User sudah terdaftar di database, silahkan ganti NPK');
                          }
                        }
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
                child: Text(
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
