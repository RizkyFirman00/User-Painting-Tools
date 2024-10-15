class Tools {
  final String idAlat;
  final String namaAlat;
  final int kuantitasAlat;

  Tools({required this.idAlat, required this.namaAlat, this.kuantitasAlat = 0});

  factory Tools.fromMap(Map<String, dynamic> map, String idAlat) {
    return Tools(
      idAlat: idAlat,
      namaAlat: map['namaAlat'],
      kuantitasAlat: map['kuantitasAlat'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idAlat': idAlat,
      'namaAlat': namaAlat,
      'kuantitasAlat': kuantitasAlat,
    };
  }
}
