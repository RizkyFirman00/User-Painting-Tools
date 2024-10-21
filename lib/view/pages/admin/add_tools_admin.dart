import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/tools_provider.dart';

class AddToolsAdmin extends StatelessWidget {
  const AddToolsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final toolsProvider = Provider.of<ToolsProvider>(context, listen: true);
    bool isLoading = toolsProvider.isLoading;

    final TextEditingController idBarangController = TextEditingController();
    final TextEditingController namaBarangController = TextEditingController();
    final TextEditingController kuantitasController = TextEditingController();

    final Color _lightBlue = Color(0xFF0099FF);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: _lightBlue,
        centerTitle: true,
        title: Text(
          "Tambah Barang",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: isLoading
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          isLoading
              ? const Expanded(
              child: Center(child: CircularProgressIndicator()))
              : Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextField(
                  controller: idBarangController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.label,
                      color: _lightBlue,
                    ),
                    hintText: "ID Barang",
                    border: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: namaBarangController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.inventory, color: _lightBlue),
                    hintText: "Nama Barang",
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: kuantitasController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.numbers, color: _lightBlue),
                    hintText: "Kuantitas Barang",
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                if (namaBarangController.text.length < 6) {
                  namaBarangController.text = '';
                  Get.snackbar('Gagal',
                      'NPK tidak boleh kurang dari 6 karakter');
                } else {
                  await toolsProvider.addToolToFirestore(idBarangController.text, namaBarangController.text, int.parse(kuantitasController.text));
                  Get.snackbar(
                      'Sukses', 'Berhasil menambahkan user baru');
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: _lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 100.0),
              ),
              child: Text(
                'Simpan',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
