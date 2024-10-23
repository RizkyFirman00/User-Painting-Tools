import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class CardTools extends StatefulWidget {
  final String namaAlat;
  final String idAlat;
  final int kuantitasAlat;
  final Future<void> Function() onPressedDelete;

  const CardTools({
    Key? key,
    required this.namaAlat,
    required this.idAlat,
    required this.kuantitasAlat,
    required this.onPressedDelete,
  }) : super(key: key);

  @override
  State<CardTools> createState() => _CardToolsState();
}

class _CardToolsState extends State<CardTools> {
  bool isCardPressed = false;
  GlobalKey _globalKey = GlobalKey();

  final Color _lightBlue = const Color(0xff0099FF);
  final ScreenshotController screenshotController = ScreenshotController();

  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Screenshot(
                      controller: screenshotController,
                      child: RepaintBoundary(
                        key: _globalKey,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: 200,
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrImageView(
                                data: widget.idAlat,
                                version: QrVersions.auto,
                                size: 200.0,
                                gapless: true,
                              ),
                              Text(
                                widget.namaAlat,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(_lightBlue), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () async {
                    var status = await Permission.storage.request();
                    if (status.isGranted) {
                      final image =
                          await screenshotController.capture(pixelRatio: 3.0);
                      if (image != null) {
                        await saveImage(image, widget.namaAlat);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Izin penyimpanan ditolak')),
                      );
                    }
                  },
                  child: const Text("Simpan ke Galeri"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> saveImage(Uint8List imageBytes, String fileName) async {
    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception("Storage permission denied");
      }

      await _saveLocalImage();
    } catch (e) {
      print("Error saat menyimpan gambar: $e");
    }
  }

  Future<void> _saveLocalImage() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (_globalKey.currentContext != null) {
          RenderRepaintBoundary boundary = _globalKey.currentContext!
              .findRenderObject() as RenderRepaintBoundary;
          ui.Image image = await boundary.toImage(pixelRatio: 3.0);
          ByteData? byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData != null) {
            final result = await ImageGallerySaverPlus.saveImage(
                byteData.buffer.asUint8List());
            print(result);
          }
        } else {
          print("Render context is still null");
        }
      });
    } catch (e) {
      print("Error saat menyimpan gambar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color lightBlue = const Color(0xff0099FF);
    return InkWell(
      splashColor: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        setState(() {
          isCardPressed = !isCardPressed;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Nama Alat: "),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                widget.namaAlat,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("ID Alat: "),
                          Text(
                            widget.idAlat,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Quantity: "),
                          Text(
                            widget.kuantitasAlat.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _showQrDialog(context);
                  },
                  splashColor: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: lightBlue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.qr_code_outlined, color: Colors.white),
                        Text(
                          "QR Code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            secondChild: Container(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.onPressedDelete().then((_) {
                          setState(() {
                            isCardPressed = false;
                          });
                        });
                      },
                      icon:
                          const Icon(Icons.delete, size: 40, color: Colors.red),
                    ),
                    const Text(
                      "Delete",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            crossFadeState: isCardPressed
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ),
      ),
    );
  }
}
