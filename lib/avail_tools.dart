import 'package:flutter/material.dart';
import 'package:user_painting_tools/card_avail_tools.dart';

class AvailTools extends StatefulWidget {
  const AvailTools({super.key});

  @override
  State<AvailTools> createState() => _AvailToolsState();
}

class _AvailToolsState extends State<AvailTools> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Halaman Persediaan Barang",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_outline),
          ),
        ],
        foregroundColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFDF042C),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              topLeft: Radius.circular(100),
            ),
            color: Color(0xffDF042C),
          ),
          height: 60,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 35),
              child: Text(
                "Barang yang tersedia :",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: CardAvailTools()),
          ],
        ),
      ),
    );
  }
}
