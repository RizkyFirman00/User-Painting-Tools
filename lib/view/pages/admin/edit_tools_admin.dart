import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/tools_provider.dart';

class EditToolsAdmin extends StatefulWidget {
  const EditToolsAdmin({super.key});

  @override
  State<EditToolsAdmin> createState() => _EditToolsAdminState();
}

class _EditToolsAdminState extends State<EditToolsAdmin> {
  final Color _lightBlue = const Color(0xff0099FF);
  final idAlat = Get.arguments;

  final TextEditingController idBarangController = TextEditingController();
  final TextEditingController namaBarangController = TextEditingController();
  final TextEditingController kuantitasController = TextEditingController();

  Future<void> loadCurrentUserData() async {
    try {
      String? toolId = idAlat;
      if (toolId != null && toolId.isNotEmpty) {
        final toolProvider = Provider.of<ToolsProvider>(context, listen: false);
        await toolProvider.fetchToolDataWithId(toolId);

        if (toolProvider.selectedTool != null) {
          idBarangController.text = toolProvider.selectedTool!.idAlat;
          namaBarangController.text = toolProvider.selectedTool!.namaAlat;
          kuantitasController.text =
              toolProvider.selectedTool!.kuantitasAlat.toString();
        }
      } else {
        if (kDebugMode) {
          print('Tool Id tidak ditemukan di SharedPreferences.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Tool Id: $e');
      }
    }
  }

  @override
  void initState() {
    loadCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final toolProvider = Provider.of<ToolsProvider>(context, listen: true);
    bool isLoading = toolProvider.isLoading;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: _lightBlue,
        title: Text(
          'Halaman Edit Data Barang',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  enabled: false,
                  controller: idBarangController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.label,
                      color: _lightBlue,
                    ),
                    hintText: "ID Barang",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () async {
                  await toolProvider.updateToolWithQty(
                    idAlat,
                    namaBarangController.text,
                    toolProvider.selectedTool!.kuantitasAlat,
                    int.parse(kuantitasController.text),
                    toolProvider.selectedTool!.kuantitasTersediaAlat,
                  );
                  Get.snackbar('Sukses', 'Data barang berhasil diperbarui');
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
                child: isLoading
                    ? Container(
                        height: 23,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
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
      ),
    );
  }
}
