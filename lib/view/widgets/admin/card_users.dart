import 'package:flutter/material.dart';

class CardUsers extends StatelessWidget {
  final String emailUser;
  final String longNameUser;
  final String npkUser;

  const CardUsers(
      {super.key,
      required this.emailUser,
      required this.longNameUser,
      required this.npkUser});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 176,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emailUser,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              longNameUser,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              npkUser,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
