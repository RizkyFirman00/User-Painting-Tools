import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/view/pages/admin/profile_admin.dart';
import 'package:user_painting_tools/view/pages/login.dart';

class TopAppBarAdmin extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const TopAppBarAdmin({super.key, required this.title});

  @override
  State<TopAppBarAdmin> createState() => _TopAppBarAdminState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopAppBarAdminState extends State<TopAppBarAdmin> {
  final Color _lightBlue = const Color(0xff0099FF);
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: _lightBlue,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          onPressed: () {
            setState(() {
              isPressed = !isPressed;
            });
          },
          icon: Icon(isPressed ? Icons.close : Icons.search),
        ),
      ),
      title: isPressed
          ? Container(
        height: 40,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: const TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              border: InputBorder.none,
              hintText: "Search Pengguna..."),
        ),
      )
          : Text(
        widget.title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
              onPressed: () {
                Get.to(() => ProfileAdmin());
              },
              icon: Icon(Icons.person)),
        ),
      ],
    );
  }
}
