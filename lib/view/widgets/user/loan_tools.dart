import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/loans.dart';
import 'package:user_painting_tools/models/view%20model/loans_provider.dart';
import 'package:user_painting_tools/view/widgets/user/card_loan_tools.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';

import '../../../helper/shared_preferences.dart';

class LoansTools extends StatefulWidget {
  const LoansTools({super.key});

  @override
  State<LoansTools> createState() => _LoansToolsState();
}

class _LoansToolsState extends State<LoansTools> {
  Future<void> _loadData() async {
    final loadProvider = Provider.of<LoansProvider>(context, listen: false);
    String? npk = await SharedPreferencesUsers.getNpk();

    if (npk != null) {
      loadProvider.fetchUserLoans(npk);
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _handleLoanReturn(Loans loan) {
    final loansProvider = Provider.of<LoansProvider>(context, listen: false);
    loansProvider.returnLoan(loan);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Barang yang dipinjam :",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ConfirmationBox(
                              textDescription:
                                  "Apakah kamu yakin ingin menghapus daftar data yang sudah dikembalikan?",
                              textTitle: "Hapus Data Pinjam",
                              textConfirm: "Iya",
                              textCancel: "Tidak",
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onConfirm: () async {},
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outlined,
                        color: Color(0xffDF042C),
                      )))
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 5),
          height: MediaQuery.of(context).size.height - 208,
          child: Expanded(
            child: Consumer<LoansProvider>(
                builder: (BuildContext context, loanProvider, child) {
              final listLoans = loanProvider.loansUserList;
              final isLoading = loanProvider.isLoading;
              return isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: listLoans.length,
                      itemBuilder: (BuildContext context, int index) {
                        final loanData = listLoans[index];
                        return CardLoanTools(
                          toolName: loanData.userNpk,
                          toolId: loanData.toolId,
                          loanDate: loanData.loanDate,
                          loanDateReturn: loanData.loanDateReturn!,
                          onConfirm: () => _handleLoanReturn(loanData),
                          onCancel: () {},
                        );
                      });
            }),
          ),
        ),
      ],
    );
  }
}
