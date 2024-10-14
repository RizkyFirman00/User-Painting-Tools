import 'package:flutter/material.dart';

class CardBorrowTools extends StatefulWidget {
  const CardBorrowTools({super.key});

  @override
  State<CardBorrowTools> createState() => _CardBorrowToolsState();
}

class _CardBorrowToolsState extends State<CardBorrowTools> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Nama Barang",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(", X512AA"),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "10.09.2024 - 10.09.2024",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Switch(
                    activeColor: Color(0xffDF042C),
                    value: light,
                    splashRadius: ,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                      });
                    },
                  ),
                  Text("Dipinjam"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
