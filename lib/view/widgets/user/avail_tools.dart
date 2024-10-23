import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/tools_provider.dart';
import 'package:user_painting_tools/view/widgets/user/card_avail_tools.dart';

class AvailTools extends StatefulWidget {
  const AvailTools({super.key});

  @override
  State<AvailTools> createState() => _AvailToolsState();
}

class _AvailToolsState extends State<AvailTools> {

  @override
  void initState() {
    super.initState();
    Provider.of<ToolsProvider>(context, listen: false).fetchTools();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 35),
          child: Text(
            "Barang yang tersedia :",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 10),
          height: MediaQuery.of(context).size.height - 208,
          child: Expanded(
            child: Consumer<ToolsProvider>(
              builder: (BuildContext context, toolsProvider, child) {
                final listTools = toolsProvider.listTools;
                final isLoading = toolsProvider.isLoading;
                return isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: listTools.length,
                        itemBuilder: (BuildContext context, int index) {
                          final toolData = listTools[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: CardAvailTools(
                              nameTools: toolData.namaAlat,
                              idTools: toolData.idAlat,
                              qtyTools: toolData.kuantitasAlat,
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
