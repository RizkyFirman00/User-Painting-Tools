import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'avail_tools.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(AvailTools);
            },
            icon: Icon(Icons.arrow_back)),
        title: Center(
          child: Text(
            "Profil Pengguna",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: const Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Nama Lengkap"),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "NPK"),
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
                      color: Colors.white
                    ),
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
