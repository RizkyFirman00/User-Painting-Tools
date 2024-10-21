import 'package:cloud_firestore/cloud_firestore.dart';

class Tools {
  final String idAlat;
  final String namaAlat;
  final int kuantitasAlat;
  final int kuantitasTersediaAlat;
  final String status;

  Tools({
    required this.idAlat,
    required this.namaAlat,
    this.kuantitasAlat = 0,
    this.kuantitasTersediaAlat = 0,
    this.status = "Tidak Tersedia",
  });

  factory Tools.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Tools(
      idAlat: data['id_lat'],
      namaAlat: data['nama_alat'],
      kuantitasAlat: data['kuantitas_alat'],
      kuantitasTersediaAlat: data['kuantitas_tersedia_alat'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_alat': idAlat,
      'nama_alat': namaAlat,
      'kuantitas_alat': kuantitasAlat,
      'kuantitas_tersedia_alat': kuantitasTersediaAlat,
      'status': status,
    };
  }
}
