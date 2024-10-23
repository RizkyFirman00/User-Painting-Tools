import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/tools_provider.dart';
import 'package:user_painting_tools/view/pages/admin/add_tools_admin.dart';
import 'package:user_painting_tools/view/widgets/admin/card_tools.dart';
import 'package:user_painting_tools/view/widgets/admin/top_app_bar_admin.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final Color _lightBlue = const Color(0xff0099FF);

  @override
  void initState() {
    super.initState();
    Provider.of<ToolsProvider>(context, listen: false).fetchTools();
  }

  @override
  Widget build(BuildContext context) {
    final toolsProvider = Provider.of<ToolsProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: TopAppBarAdmin(
          title: "Halaman Alat",
          onSearchChanged: (query) {
            toolsProvider.filterTools(query);
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightBlue,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () async {
                await Get.to(() => AddToolsAdmin());
                toolsProvider.fetchTools();
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Consumer<ToolsProvider>(
            builder: (BuildContext context, toolsProvider, child) {
          final listTools = toolsProvider.listTools;
          final isLoading = toolsProvider.isLoading;

          bool isThereQuery = toolsProvider.filteredUser.isEmpty;
          return isThereQuery
              ? Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text("Alat tidak ada"))
              : Padding(
                  padding: EdgeInsets.all(25),
                  child: listTools.isEmpty && toolsProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: listTools.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final toolData = listTools[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CardTools(
                                namaAlat: toolData.namaAlat,
                                idAlat: toolData.idAlat,
                                kuantitasAlat: toolData.kuantitasAlat,
                                onPressedDelete: () {
                                  return showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return ConfirmationBox(
                                        textTitle: "Hapus Akun",
                                        textDescription:
                                            "Apakah kamu yakin ingin menghapus data barang ${toolData.idAlat}?",
                                        textConfirm: "Iya",
                                        textCancel: "Tidak",
                                        onConfirm: () async {
                                          await toolsProvider.deleteTools(
                                              toolData.idAlat,
                                              toolData.namaAlat);
                                          await toolsProvider.fetchTools();
                                          Get.snackbar('Berhasil',
                                              'Akun ${toolData.namaAlat} berhasil dihapus');
                                          Navigator.pop(context);
                                        },
                                        onCancel: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ));
        }),
      ),
    );
  }
}
