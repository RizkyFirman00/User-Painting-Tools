import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_painting_tools/models/loans.dart';
import 'package:user_painting_tools/models/tools.dart';

class LoansService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Loans>> getUserLoans(String npkUser) async {
    QuerySnapshot snapshot = await _firestore
        .collection('loans')
        .where('npk_user', isEqualTo: npkUser)
        .get();

    return snapshot.docs.map((doc) => Loans.fromDocument(doc)).toList();
  }

  Future<void> deleteLoan(String loanId) async {
    await _firestore.collection('loans').doc(loanId).delete();
  }

  Future<List<Loans>> getAllLoans() async {
    QuerySnapshot snapshot = await _firestore.collection('loans').get();
    return snapshot.docs.map((doc) => Loans.fromDocument(doc)).toList();
  }

  Future<void> addLoan(Loans loan) async {
    DocumentReference docRef = await _firestore.collection('loans').add(loan.toMap());
    loan.loanId = docRef.id;
    await updateToolQuantityOnLoan(loan.toolId, loan.toolsQty);
  }

  Future<void> updateToolQuantityOnLoan(String toolId, int quantity) async {
    DocumentSnapshot doc = await _firestore.collection('tools').doc(toolId).get();
    Tools tool = Tools.fromDocument(doc);

    int updatedQtyAvailable = tool.kuantitasTersediaAlat - quantity;

    String status = updatedQtyAvailable > 0 ? 'Tersedia' : 'Tidak Tersedia';

    await _firestore.collection('tools').doc(toolId).update({
      'kuantitas_alat_tersedia': updatedQtyAvailable,
      'status': status,
    });
  }

  Future<void> returnLoan(Loans loan) async {
    await _firestore.collection('loans').doc(loan.loanId).update(
        {'status': 'Dikembalikan', 'tanggal_pengembalian': DateTime.now()});

    await updateToolQuantityOnReturn(loan.toolId, loan.toolsQty);
  }

  Future<void> updateToolQuantityOnReturn(String toolId, int quantity) async {
    DocumentSnapshot doc =
        await _firestore.collection('tools').doc(toolId).get();
    Tools tool = Tools.fromDocument(doc);

    int updatedQtyAvailable = tool.kuantitasTersediaAlat + quantity;

    String status = updatedQtyAvailable > 0 ? 'Tersedia' : 'Tidak Tersedia';

    await _firestore.collection('tools').doc(toolId).update({
      'kuantitas_alat_tersedia': updatedQtyAvailable,
      'status': status,
    });
  }
}
