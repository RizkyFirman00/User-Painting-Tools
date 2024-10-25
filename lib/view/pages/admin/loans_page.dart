import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/loans_provider.dart';
import 'package:user_painting_tools/view/widgets/admin/card_loans.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  bool isSearchIconPressed = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<LoansProvider>(context, listen: false).fetchAllLoans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loanProvider = Provider.of<LoansProvider>(context, listen: false);
    final Color _lightBlue = const Color(0xff0099FF);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: _lightBlue,
          centerTitle: true,
          title: isSearchIconPressed
              ? Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  loanProvider.filterLoans(value);
                },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                    border: InputBorder.none,
                    hintText: "Cari NPK User..."),
              ),
            ),
          )
              : Text(
            "Daftar Peminjaman Barang",
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isSearchIconPressed = !isSearchIconPressed;
                  });
                },
                icon: isSearchIconPressed
                    ? Icon(Icons.clear)
                    : Icon(Icons.search)),
          ),
        ),
        body: Consumer<LoansProvider>(
          builder: (BuildContext context, loanProvider, child) {
            final listLoans = loanProvider.loansList;
            final isLoading = loanProvider.isLoading;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : listLoans.isEmpty
                  ? Center(child: Text('Tidak ada barang yang dipinjam'))
                  : ListView.builder(
                itemCount: listLoans.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final loanData = listLoans[index];
                  return CardLoans(
                    toolName: loanData.userNpk,
                    toolId: loanData.toolId,
                    userName: loanData.userName,
                    userNpk: loanData.userNpk,
                    loanDate: loanData.loanDate,
                    loanReturnDate: loanData.loanDateReturn!,
                    status: loanData.status, toolQty: loanData.toolsQty,);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
