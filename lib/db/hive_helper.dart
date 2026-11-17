import 'package:hive_flutter/hive_flutter.dart';
import '../models/catatan_moderasi.dart';

class HiveHelper {
  HiveHelper._internal();
  static final HiveHelper instance = HiveHelper._internal();

  static const String boxName = 'moderasi_ulasan_box';

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CatatanModerasiAdapter());
    }
    await Hive.openBox<CatatanModerasi>(boxName);
  }

  Box<CatatanModerasi> get box => Hive.box<CatatanModerasi>(boxName);

  // CREATE
  Future<int> tambahModerasi(CatatanModerasi data) async {
    return await box.add(data);
  }

  // READ
  List<CatatanModerasi> ambilSemuaModerasi() {
    return box.values.toList().reversed.toList();
  }

  // UPDATE
  Future<void> ubahStatusModerasi(CatatanModerasi data, String statusBaru) async {
    data.statusTindakan = statusBaru;
    await data.save();
  }

  // DELETE
  Future<void> hapusModerasi(CatatanModerasi data) async {
    await data.delete();
  }
}