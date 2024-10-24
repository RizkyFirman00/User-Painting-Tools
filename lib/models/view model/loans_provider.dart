import 'package:flutter/material.dart';
import 'package:user_painting_tools/models/loans.dart';
import 'package:user_painting_tools/models/services/loans_service.dart';

class LoansProvider with ChangeNotifier {
  final LoansService _loansService = LoansService();
  List<Loans> _loansList = [];

  List<Loans> get loansList => _loansList;

  Future<void> fetchUserLoans(String npkUser) async {
    _loansList = await _loansService.getUserLoans(npkUser);
    notifyListeners();
  }

  Future<void> fetchAllLoans() async {
    _loansList = await _loansService.getAllLoans();
    notifyListeners();
  }

  Future<void> addLoan(Loans loan) async {
    await _loansService.addLoan(loan);
    _loansList.add(loan);
    notifyListeners();
  }

  Future<void> returnLoan(Loans loan) async {
    await _loansService.returnLoan(loan);
    _loansList.removeWhere((l) => l.toolId == loan.toolId && l.status == 'Dipinjam');
    notifyListeners();
  }
}
