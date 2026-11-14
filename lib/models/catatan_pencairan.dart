class CatatanPencairan {
  final int? id;
  final String namaPenerbit;
  final int nominal;
  final String nomorReferensi;
  final String status;
  final String tanggal;

  CatatanPencairan({
    this.id,
    required this.namaPenerbit,
    required this.nominal,
    required this.nomorReferensi,
    required this.status,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_penerbit': namaPenerbit,
      'nominal': nominal,
      'nomor_referensi': nomorReferensi,
      'status': status,
      'tanggal': tanggal,
    };
  }

  factory CatatanPencairan.fromMap(Map<String, dynamic> map) {
    return CatatanPencairan(
      id: map['id'] as int?,
      namaPenerbit: map['nama_penerbit'] as String,
      nominal: map['nominal'] as int,
      nomorReferensi: map['nomor_referensi'] as String,
      status: map['status'] as String,
      tanggal: map['tanggal'] as String,
    );
  }
}