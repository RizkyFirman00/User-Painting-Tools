import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/loans_provider.dart';
import 'package:user_painting_tools/models/view%20model/tools_provider.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';
import 'package:intl/intl.dart';

import '../../../helper/shared_preferences.dart';

class CardLoanTools extends StatefulWidget {
  final String toolName;
  final String toolId;
  final DateTime loanDate;
  final DateTime loanDateReturn;
  final String status;
  final int kuantitas_alat;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CardLoanTools({
    super.key,
    required this.toolName,
    required this.toolId,
    required this.loanDate,
    required this.loanDateReturn,
    required this.onConfirm,
    required this.onCancel,
    required this.status,
    required this.kuantitas_alat,
  });

  @override
  State<CardLoanTools> createState() => _CardLoanToolsState();
}

class _CardLoanToolsState extends State<CardLoanTools> {

  @override
  Widget build(BuildContext context) {
    bool light = (widget.status == 'Dipinjam');
    bool isCompleted = (widget.status == 'Dipinjam') ? false : true;

    String parsedLoanDate = DateFormat('dd-MM-yyyy').format(widget.loanDate);
    String parsedReturnDate =
        DateFormat('dd-MM-yyyy').format(widget.loanDateReturn);

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.toolName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          ' x${widget.kuantitas_alat}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(widget.toolId),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "From ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          parsedLoanDate,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "to ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          parsedReturnDate,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
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
                                        onConfirm: () async {
                                          widget.onConfirm();
                                          setState(() {
                                            light = false;
                                            isCompleted = true;
                                          });
                                          Get.back();
                                        },
                                        onCancel: () {
                                          widget.onCancel();
                                          Get.back();
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  setState(
                                    () {
                                      light = true;
                                    },
                                  );
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
