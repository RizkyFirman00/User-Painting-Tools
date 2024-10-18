import 'package:flutter/material.dart';
import 'package:user_painting_tools/view/widgets/user/card_avail_tools.dart';

class AvailTools extends StatelessWidget {
  const AvailTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: MediaQuery.of(context).size.height - 208,
          child: const Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: CardAvailTools(),
            ),
          ),
        ),
      ],
    );
  }
}
