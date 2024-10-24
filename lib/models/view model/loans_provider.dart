import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/loans.dart';
import 'package:user_painting_tools/models/services/loans_service.dart';

class LoansProvider with ChangeNotifier {
  final LoansService _loansService = LoansService();
  final SimpleLogger _simpleLogger = SimpleLogger();

  // Loading Param
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  // List Param
  List<Loans> _loansList = [];
  List<Loans> get loansList => _loansList;
  
  List<Loans> _loansUserList = [];
  List<Loans> get loansUserList => _loansUserList;

  List<Loans> _filteredList = [];
  List<Loans> get filteredList => _loansList.isEmpty ? _loansList : _filteredList;
  
  void _setLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void filterLoans(String query) {
    if (query.isNotEmpty) {
      _filteredList = _loansList
          .where((loan) =>
          loan.userNpk.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    } else {
      _filteredList = _loansList;
    }
    notifyListeners();
  }

  Future<void> fetchUserLoans(String npkUser) async {
    _setLoading(true);
    try {
      _loansUserList = await _loansService.getUserLoans(npkUser);
      _simpleLogger.info('Fetching data user loan: $_loansUserList');
      notifyListeners();
    } catch(e) {
      _simpleLogger.info('Eror fetching data user loan: $_loansUserList');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchAllLoans() async {
    _setLoading(true);
    try {
      _loansList = await _loansService.getAllLoans();
      _simpleLogger.info('Fetching data user loan: $_loansList');
      notifyListeners();
    } catch(e) {
      _simpleLogger.info('Error fetching all data loan: $_loansList');
    } finally {
     _setLoading(false);
    }
  }

  Future<void> addLoan(Loans loan) async {
    _setLoading(true);
    try {
      await _loansService.addLoan(loan);
      _loansList.add(loan);
      _simpleLogger.info('Success adding new loan: $_loansList');
      notifyListeners();
    } catch(e) {
      _simpleLogger.info('Error adding new loan: $_loansList');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> returnLoan(Loans loan) async {
    _setLoading(true);
    try {
      await _loansService.returnLoan(loan);
      _loansList.removeWhere((l) => l.toolId == loan.toolId && l.status == 'Dipinjam');
      _simpleLogger.info('Success adding new loan: $_loansList');
      notifyListeners();
    } catch(e) {
      _simpleLogger.info('Error adding new loan: $_loansList');
    } finally {
      _setLoading(false);
    }
  }
}
