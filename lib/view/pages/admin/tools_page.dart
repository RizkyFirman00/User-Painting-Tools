import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_painting_tools/view/pages/admin/add_tools_admin.dart';
import 'package:user_painting_tools/view/widgets/admin/top_app_bar_admin.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color _lightBlue = const Color(0xff0099FF);
    return SafeArea(
      child: Scaffold(
        appBar: TopAppBarAdmin(
          title: "Halaman Barang",
          onSearchChanged: (String) {
            onSearchChanged:
            () {

            };
          },
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10, right: 10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightBlue,
            ),
            child: Center(
              child: IconButton(
                onPressed: () {Get.to(() => const AddToolsAdmin());},
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Center(child: Text("Tools Page")),
      ),
    );
  }
}
