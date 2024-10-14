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
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Barang yang dipinjam :",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outlined,
                        color: Color(0xffDF042C),
                      )))
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30, ),
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
