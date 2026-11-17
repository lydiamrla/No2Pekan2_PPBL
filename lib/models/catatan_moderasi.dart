import 'package:hive/hive.dart';

part 'catatan_moderasi.g.dart';

@HiveType(typeId: 0)
class CatatanModerasi extends HiveObject {
  @HiveField(0)
  final String judulBuku;

  @HiveField(1)
  final String namaPengulas;

  @HiveField(2)
  final String isiUlasan;

  @HiveField(3)
  String statusTindakan;

  @HiveField(4)
  final String tanggal;

  CatatanModerasi({
    required this.judulBuku,
    required this.namaPengulas,
    required this.isiUlasan,
    required this.statusTindakan,
    required this.tanggal,
  });
}