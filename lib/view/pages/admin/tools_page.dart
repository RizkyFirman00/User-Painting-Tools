import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/tools_provider.dart';
import 'package:user_painting_tools/view/pages/admin/add_tools_admin.dart';
import 'package:user_painting_tools/view/widgets/admin/card_tools.dart';
import 'package:user_painting_tools/view/widgets/admin/top_app_bar_admin.dart';

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
    print("LIST TOOLS ${Provider.of<ToolsProvider>(context, listen: false).listTools}");
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
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Get.to(() => const AddToolsAdmin());
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Consumer<ToolsProvider>(
            builder: (BuildContext context, toolsProvider, child) {
          final listTools = toolsProvider.listTools;
          print("Isi daftar barang: $listTools");
          bool isThereQuery = toolsProvider.filteredUser.isEmpty;
          return isThereQuery
              ? Center(child: Text("Alat tersebut tidak ada"))
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
                                  kuantitasAlat: toolData.kuantitasAlat),
                            );
                          },
                        ));
        }),
      ),
    );
  }
}
