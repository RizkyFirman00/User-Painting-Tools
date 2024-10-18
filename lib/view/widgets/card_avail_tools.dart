import 'package:flutter/material.dart';

class CardAvailTools extends StatelessWidget {
  const CardAvailTools({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Barang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Quantity:",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "10",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text("X512AA"),
            ],
          ),
        ),
      ),
    );
  }
}
