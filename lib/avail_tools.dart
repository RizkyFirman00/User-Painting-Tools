import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_painting_tools/card_avail_tools.dart';
import 'package:user_painting_tools/profile_user.dart';

class AvailTools extends StatefulWidget {
  const AvailTools({super.key});

  @override
  State<AvailTools> createState() => _AvailToolsState();
}

class _AvailToolsState extends State<AvailTools> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              "Halaman Persediaan Barang",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Get.off(const ProfileUser());
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
              topRight: Radius.circular(100),
              topLeft: Radius.circular(100),
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
                      onPressed: () {},
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
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () {},
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
                    onPressed: () {},
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
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 35),
                child: Text(
                  "Barang yang tersedia :",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: const CardAvailTools()),
            ],
          ),
        ),
      ),
    );
  }
}
