import 'package:flutter/material.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';

class CardBorrowTools extends StatefulWidget {
  const CardBorrowTools({super.key});

  @override
  State<CardBorrowTools> createState() => _CardBorrowToolsState();
}

class _CardBorrowToolsState extends State<CardBorrowTools> {
  bool light = true;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Pemecah Kacang",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Text("X512AA"),
                    Container(
                      child: const Text(
                        "10.09.2024 - 10.09.2024",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(
                        activeColor: const Color(0xffDF042C),
                        trackColor: const WidgetStatePropertyAll(Colors.white),
                        trackOutlineColor:
                            const WidgetStatePropertyAll(Colors.black45),
                        value: light,
                        onChanged: isCompleted
                            ? null
                            : (bool value) {
                                if (value == false) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ConfirmationBox(
                                            textTitle: "Pengembalian Barang",
                                            textDescription:
                                                "Apakah kamu yakin sudah selesai menggunakan barang?",
                                            textConfirm: "Sudah",
                                            textCancel: "Belum",
                                            onConfirm: () {
                                              setState(() {
                                                light = false;
                                                isCompleted = true;
                                              });
                                              Navigator.pop(context);
                                            },
                                            onCancel: () {
                                              setState(() {
                                                light = true;
                                              });
                                              Navigator.pop(context);
                                            });
                                      });
                                } else {
                                  setState(() {
                                    light = true;
                                  });
                                }
                              },
                      ),
                      light
                          ? const Text(
                              "Dipinjam",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            )
                          : const Text("Selesai"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
