import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_painting_tools/firebase_options.dart';
import 'package:user_painting_tools/view/pages/user/photo_qr_user.dart';
import 'package:user_painting_tools/view/pages/user/profile_user.dart';
import 'package:user_painting_tools/view/widgets/user/avail_tools.dart';
import 'package:user_painting_tools/view/widgets/user/loan_tools.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

Future<void> _setStatusBarColor() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFDF042C),
  ));
}

class _HomeUserState extends State<HomeUser> {

  int _selectedPage = 0;
  
  final List<Widget> _pages = [
    const AvailTools(),
    const PhotoQrUser(),
    const BorrowTools(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  void initState() {
    _setStatusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setStatusBarColor();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                // Get.to(FillingData());
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
                  Get.to(() => const ProfileUser());
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
                    flex: 1,
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
                      decoration: const BoxDecoration(
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
                  height: 70,
                  width: 70,
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
                          color: Color(0xFFDF042C),
                          size: 30,
                        ),
                        Text(
                          "Scan",
                          style: TextStyle(
                            color: Color(0xFFDF042C),
                            fontSize: 12,
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
            child: _pages[_selectedPage]),
      ),
    );
  }
}
