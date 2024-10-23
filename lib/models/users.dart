import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String npkUser;
  final String passwordUser;
  final String? namaLengkap;
  final bool isAdmin;

  Users({
    required this.npkUser,
    required this.passwordUser,
    this.namaLengkap = "",
    this.isAdmin = false,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Users(
      npkUser: data['npk'] ?? '',
      passwordUser: data['password'] ?? '',
      namaLengkap:
          data.containsKey('nama_lengkap') ? data['nama_lengkap'] : null,
      isAdmin: data['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'npk': npkUser,
      'password': passwordUser,
      if (namaLengkap != null) 'nama_lengkap': namaLengkap,
      'isAdmin': isAdmin,
    };
  }
}
