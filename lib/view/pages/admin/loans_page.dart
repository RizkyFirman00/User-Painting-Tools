import 'package:flutter/material.dart';
import 'package:user_painting_tools/view/widgets/admin/top_app_bar_admin.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color _lightBlue = const Color(0xff0099FF);
    return SafeArea(
      child: Scaffold(
        // appBar: TopAppBarAdmin(title: "Halaman Peminjaman"),
        body: Center(child: Text("Loans Page")),
      ),
    );
  }
}
