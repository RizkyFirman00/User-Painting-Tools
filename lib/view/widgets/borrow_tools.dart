import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_painting_tools/view/widgets/card_borrow_tools.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';

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
        Container(
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ConfirmationBox(
                              textDescription:
                                  "Apakah kamu yakin ingin menghapus daftar data yang sudah dikembalikan?",
                              textTitle: "Hapus Data Pinjam",
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onConfirm: () {},
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outlined,
                        color: Color(0xffDF042C),
                      )))
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
          height: MediaQuery.of(context).size.height - 208,
          child: const Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                  CardBorrowTools(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
