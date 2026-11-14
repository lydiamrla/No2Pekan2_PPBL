import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/catatan_pencairan.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();
  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'ikapi_jabar_707012400127.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE riwayat_pencairan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_penerbit TEXT NOT NULL,
            nominal INTEGER NOT NULL,
            nomor_referensi TEXT NOT NULL,
            status TEXT NOT NULL,
            tanggal TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // CREATE: Menyimpan catatan verifikasi pencairan dana baru
  Future<int> tambahPencairan(CatatanPencairan pencairan) async {
    final db = await database;
    return db.insert('riwayat_pencairan', pencairan.toMap());
  }

  // READ: Mengambil seluruh riwayat pencairan terurut dari yang terbaru
  Future<List<CatatanPencairan>> ambilSemuaPencairan() async {
    final db = await database;
    final hasil = await db.query('riwayat_pencairan', orderBy: 'id DESC');
    return hasil.map((baris) => CatatanPencairan.fromMap(baris)).toList();
  }

  // UPDATE: Memperbarui status atau nomor referensi berdasarkan ID tertentu
  Future<int> ubahPencairan(CatatanPencairan pencairan) async {
    final db = await database;
    return db.update(
      'riwayat_pencairan',
      pencairan.toMap(),
      where: 'id = ?',
      whereArgs: [pencairan.id],
    );
  }

  // DELETE: Menghapus satu baris riwayat pencairan berdasarkan ID tertentu
  Future<int> hapusPencairan(int id) async {
    final db = await database;
    return db.delete(
      'riwayat_pencairan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}