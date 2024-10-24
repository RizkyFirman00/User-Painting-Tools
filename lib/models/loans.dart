import 'package:cloud_firestore/cloud_firestore.dart';

class Loans {
  final String toolId;
  final String toolName;
  final String toolsQty;
  final String userName;
  final String userNpk;
  final DateTime loanDate;
  final DateTime? loanDateReturn;
  final String status;

  Loans({
    required this.toolId,
    required this.toolName,
    required this.toolsQty,
    required this.userName,
    required this.userNpk,
    required this.loanDate,
    this.loanDateReturn,
    this.status = "Dipinjam",
  });

  factory Loans.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Loans(
      toolId: data['id_alat'],
      toolName: data['nama_alat'],
      toolsQty: data['kuantitas_alat'],
      userName: data['nama_user'],
      userNpk: data['npk_user'],
      loanDate: (data['tanggal_pinjam'] as Timestamp).toDate(),
      loanDateReturn: data['tanggal_pengembalian'] != null
          ? (data['tanggal_pengembalian'] as Timestamp).toDate()
          : null,
      status: data['status'] ?? 'Dipinjam',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_alat': toolId,
      'nama_alat': toolName,
      'kuantitas_alat': toolsQty,
      'nama_user': userName,
      'npk_user': userNpk,
      'tanggal_pinjam': loanDate,
      'tanggal_pengembalian': loanDateReturn,
      'status': status,
    };
  }
}
