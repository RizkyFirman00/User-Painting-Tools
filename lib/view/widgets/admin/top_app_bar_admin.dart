import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_painting_tools/view/pages/admin/profile_admin.dart';

class TopAppBarAdmin extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final Function(String) onSearchChanged;

  const TopAppBarAdmin(
      {super.key, required this.title, required this.onSearchChanged, required this.subTitle});

  @override
  State<TopAppBarAdmin> createState() => _TopAppBarAdminState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopAppBarAdminState extends State<TopAppBarAdmin> {
  final Color _lightBlue = const Color(0xff0099FF);
  bool isPressed = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              if (!isPressed) {
                _searchController.clear();
                widget.onSearchChanged('');
              }
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
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  widget.onSearchChanged(value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                    border: InputBorder.none,
                    hintText: "Cari ${widget.subTitle}..."),
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
