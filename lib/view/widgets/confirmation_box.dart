import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ConfirmationBox extends StatefulWidget {
  final String textTitle;
  final String textDescription;
  final String textConfirm;
  final String textCancel;
  final Future<void> Function() onConfirm;
  final VoidCallback onCancel;

  const ConfirmationBox({
    super.key,
    required this.textTitle,
    required this.textDescription,
    required this.onConfirm,
    required this.onCancel,
    required this.textConfirm,
    required this.textCancel,
  });

  @override
  State<ConfirmationBox> createState() => _ConfirmationBoxState();
}

class _ConfirmationBoxState extends State<ConfirmationBox> {
  bool _isLoading = false;

  void _handleConfirm() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.onConfirm();
    } catch (e) {
      Get.snackbar("Gagal", "Terjadi kesalahan: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      title: Text(
        widget.textTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      content: _isLoading
          ? SizedBox(
              height: 80,
              width: 150,
              child: Center(child: CircularProgressIndicator()))
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.textDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: widget.onCancel,
              style: ElevatedButton.styleFrom(
                overlayColor: Colors.redAccent,
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Color(0xffDF042C)),
                ),
              ),
              child: SizedBox(
                width: 60,
                child: Center(
                  child: Text(
                    widget.textCancel,
                    style: TextStyle(color: Color(0xffDF042C)),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleConfirm,
              style: ElevatedButton.styleFrom(
                overlayColor: Colors.white,
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffDF042C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: SizedBox(
                  width: 60, child: Center(child: Text(widget.textConfirm))),
            ),
          ],
        ),
      ],
    );
  }
}
