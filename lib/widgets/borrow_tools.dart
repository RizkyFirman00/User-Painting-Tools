import 'package:flutter/material.dart';
import 'package:user_painting_tools/widgets/card_borrow_tools.dart';

class BorrowTools extends StatefulWidget {
  const BorrowTools({super.key});

  @override
  State<BorrowTools> createState() => _BorrowToolsState();
}

class _BorrowToolsState extends State<BorrowTools> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 35),
          child: Text(
            "Barang yang dipinjam :",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: const Expanded(
            child: SingleChildScrollView(
              child: CardBorrowTools(),
            ),
          ),
        ),
      ],
    );
  }
}
