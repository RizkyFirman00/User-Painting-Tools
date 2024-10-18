import 'package:flutter/material.dart';
import 'package:user_painting_tools/view/widgets/admin/top_app_bar_admin.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color _lightBlue = const Color(0xff0099FF);
    return SafeArea(
      child: Scaffold(
        appBar: TopAppBarAdmin(title: "Halaman Barang"),
        body: Center(child: Text("Users Page")),
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
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
