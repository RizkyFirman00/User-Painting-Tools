class Tools {
  final String idAlat;
  final String namaAlat;
  final int kuantitasAlat;
  final int kuantitasTersediaAlat;
  final String status;

  Tools(
      {required this.idAlat,
      required this.namaAlat,
      this.kuantitasAlat = 0,
      this.kuantitasTersediaAlat = 0,
      this.status = "Tidak Tersedia"});

  factory Tools.fromMap(Map<String, dynamic> map, String idAlat) {
    return Tools(
      idAlat: idAlat,
      namaAlat: map['nama_alat'],
      kuantitasAlat: map['kuantitas_alat'],
      kuantitasTersediaAlat: map['kuantitas_tersedia_alat'],
      status: map['status'],
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
