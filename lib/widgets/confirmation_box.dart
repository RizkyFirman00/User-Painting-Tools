import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationBox extends StatelessWidget {
  final String textTitle;
  final String textDescription;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationBox({
    super.key,
    required this.textTitle,
    required this.textDescription,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      title: Text(
        textTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      content: Text(
        textDescription,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                overlayColor: Colors.redAccent,
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Color(0xffDF042C)),
                ),
              ),
              child: const Text(
                'Belum',
                style: TextStyle(color: Color(0xffDF042C)),
              ),
            ),
            ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                overlayColor: Colors.white,
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffDF042C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Sudah'),
            ),
          ],
        ),
      ],
    );
  }
}
