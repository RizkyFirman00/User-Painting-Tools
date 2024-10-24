import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardLoans extends StatelessWidget {
  final String toolName;
  final String toolId;
  final String userName;
  final String userNpk;
  final DateTime loanDate;
  final DateTime loanReturnDate;
  final String status;

  const CardLoans(
      {super.key,
      required this.toolName,
      required this.toolId,
      required this.userName,
      required this.userNpk,
      required this.loanDate,
      required this.loanReturnDate,
      required this.status});

  @override
  Widget build(BuildContext context) {
    String parsedLoanDate = DateFormat('dd-MM-yyyy').format(loanDate);
    String parsedReturnDate = DateFormat('dd-MM-yyyy').format(loanReturnDate);
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Alat: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    toolName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID Alat: ",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                ),
                Expanded(
                  child: Text(
                    toolId,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Peminjam: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NPK Peminjam: ",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                ),
                Expanded(
                  child: Text(
                    userNpk,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "From: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    parsedLoanDate,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "To: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    parsedReturnDate,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: (status == 'Dipinjam')
                          ? Color(0xff27fb2f)
                          : Color(0xFFDF042C),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
