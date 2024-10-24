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
    required this.kuantitasAlat,
    this.kuantitasTersediaAlat = 0,
    this.status = "Tidak Tersedia",
  });

  factory Tools.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Tools(
      idAlat: data['id_alat'],
      namaAlat: data['nama_alat'],
      kuantitasAlat: data['kuantitas_alat'],
      kuantitasTersediaAlat: data.containsKey('kuantitas_tersedia_alat') ? data['kuantitas_tersedia_alat'] : 0,
      status: data['status'] ?? 'Tidak Tersedia',
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
