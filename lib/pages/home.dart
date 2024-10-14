import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_painting_tools/pages/filling_data.dart';
import 'package:user_painting_tools/widgets/avail_tools.dart';
import 'package:user_painting_tools/widgets/borrow_tools.dart';
import 'package:user_painting_tools/pages/photo_qr.dart';
import 'package:user_painting_tools/pages/profile_user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AvailTools(),
    const PhotoQr(),
    const BorrowTools(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                Get.to(FillingData());
              },
              child: const Text(
                "Halaman Persediaan Barang",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Get.to(const ProfileUser());
                },
                icon: const Icon(Icons.person_outline),
              ),
            ),
          ],
          foregroundColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFFDF042C),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xffDF042C),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        _onItemTapped(0);
                      },
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            'Persediaan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(20))),
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          _onItemTapped(2);
                        },
                        icon: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.repeat_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Pengembalian',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFDF042C),
                        spreadRadius: 5,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      _onItemTapped(1);
                    },
                    icon: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_2_outlined,
                          size: 37,
                        ),
                        Text(
                          "Scan",
                          style: TextStyle(
                            color: Color(0xFFDF042C),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _pages[_selectedIndex]),
      ),
    );
  }
}
