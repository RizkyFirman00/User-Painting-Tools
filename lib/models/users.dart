import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String emailUser;
  final String npkUser;
  final String? namaLengkap;

  Users({
    required this.emailUser,
    required this.npkUser,
    this.namaLengkap = "",
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Users(
      emailUser: doc['email'] ?? '',
      npkUser: doc['npk'] ?? '',
      namaLengkap: data.containsKey('nama_lengkap') ? data['nama_lengkap'] : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': emailUser,
      'npk': npkUser,
      if (namaLengkap != null) 'nama_lengkap': namaLengkap,
    };
  }
}
