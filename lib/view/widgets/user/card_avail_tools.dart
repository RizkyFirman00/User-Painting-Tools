import 'package:flutter/material.dart';

class CardAvailTools extends StatelessWidget {
  final String nameTools;
  final String idTools;
  final int qtyTools;

  const CardAvailTools(
      {super.key,
      required this.nameTools,
      required this.idTools,
      required this.qtyTools});

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
                      nameTools,
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
                          qtyTools.toString(),
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
              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(idTools),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
