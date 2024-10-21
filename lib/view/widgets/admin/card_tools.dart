import 'package:flutter/material.dart';

class CardTools extends StatelessWidget {
  final String namaAlat;
  final String idAlat;
  final int kuantitasAlat;

  const CardTools(
      {super.key,
      required this.namaAlat,
      required this.idAlat,
      required this.kuantitasAlat});

  @override
  Widget build(BuildContext context) {
    final Color _lightBlue = const Color(0xff0099FF);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Nama Alat: "),
                    Text(
                      namaAlat,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("ID Alat: "),
                    Text(
                      idAlat,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text("Quantity:  "),
                        Text(
                          kuantitasAlat.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () {},
              splashColor: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: _lightBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      "QR Code",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
