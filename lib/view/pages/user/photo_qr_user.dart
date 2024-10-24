import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:user_painting_tools/view/pages/user/filling_data_user.dart';

class PhotoQrUser extends StatefulWidget {
  const PhotoQrUser({super.key});

  @override
  State<PhotoQrUser> createState() => _PhotoQrUserState();
}

class _PhotoQrUserState extends State<PhotoQrUser> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrCodeResult;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.stopCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {

    if (qrCodeResult != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller!.pauseCamera();
        Get.to(FillingDataUser(), arguments: {'idBarang': qrCodeResult})!.then((_) {
          controller!.resumeCamera();
        });
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (qrCodeResult != null)
                ? Column(
                  children: [
                    CircularProgressIndicator(),
                    const Text('Processing...'),
                  ],
                )
                  : const Text('Pindai kode QR untuk mendapatkan hasil.'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCodeResult = scanData.code;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
