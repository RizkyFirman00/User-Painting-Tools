import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String emailUser;
  final String namaLengkapUser;
  final String npkUser;

  Users({
    required this.emailUser,
    this.namaLengkapUser = "",
    this.npkUser = "",
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      emailUser: doc['email'],
      namaLengkapUser: doc['nama_lengkap'],
      npkUser: doc['npk'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': emailUser,
      'nama_lengkap': namaLengkapUser,
      'npk': npkUser,
    };
  }
}
