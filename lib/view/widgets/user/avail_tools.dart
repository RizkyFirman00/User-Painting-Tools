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
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            top: screenHeight * 0.04,
            // bottom: screenHeight * 0.04,
          ),
          child: const Text(
            "Barang yang tersedia :",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
              top: screenHeight * 0.015,
            ),
            height: screenHeight - (screenHeight * 0.2),
            child: Consumer<ToolsProvider>(
              builder: (BuildContext context, toolsProvider, child) {
                final listTools = toolsProvider.listTools;
                final isLoading = toolsProvider.isLoading;
          
                return isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFDF042C),
                  ),
                )
                    : listTools.isEmpty
                    ? const Center(child: Text('Tidak ada data barang'))
                    : ListView.builder(
                  itemCount: listTools.length,
                  itemBuilder: (BuildContext context, int index) {
                    final toolData = listTools[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.005),
                      child: CardAvailTools(
                        nameTools: toolData.namaAlat,
                        idTools: toolData.idAlat,
                        qtyTools: toolData.kuantitasTersediaAlat,
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
