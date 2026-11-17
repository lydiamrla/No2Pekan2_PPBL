import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../db/hive_helper.dart';
import '../models/catatan_moderasi.dart';

class HalamanModerasiUlasan extends StatefulWidget {
  const HalamanModerasiUlasan({super.key});

  @override
  State<HalamanModerasiUlasan> createState() => _HalamanModerasiUlasanState();
}

class _HalamanModerasiUlasanState extends State<HalamanModerasiUlasan> {
  Future<void> _tampilkanFormTambah() async {
    final bukuController = TextEditingController();
    final pengulasController = TextEditingController();
    final ulasanController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Catat Moderasi Ulasan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bukuController,
                decoration: const InputDecoration(labelText: 'Judul Buku'),
              ),
              TextField(
                controller: pengulasController,
                decoration: const InputDecoration(labelText: 'Nama Pengulas'),
              ),
              TextField(
                controller: ulasanController,
                decoration: const InputDecoration(labelText: 'Isi Ulasan'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (bukuController.text.isEmpty ||
                  pengulasController.text.isEmpty ||
                  ulasanController.text.isEmpty) return;

              await HiveHelper.instance.tambahModerasi(
                CatatanModerasi(
                  judulBuku: bukuController.text,
                  namaPengulas: pengulasController.text,
                  isiUlasan: ulasanController.text,
                  statusTindakan: 'Dihapus (Peringatan Akun)',
                  tanggal: DateTime.now().toString().substring(0, 16),
                ),
              );

              if (!context.mounted) return;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Catatan moderasi disimpan ke Hive.'),
                ),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderasi Ulasan (Hive)')),
      body: ValueListenableBuilder<Box<CatatanModerasi>>(
        valueListenable: HiveHelper.instance.box.listenable(),
        builder: (context, box, _) {
          final daftar = HiveHelper.instance.ambilSemuaModerasi();
          if (daftar.isEmpty) {
            return const Center(
              child: Text('Belum ada riwayat moderasi ulasan tersimpan.'),
            );
          }
          return ListView.builder(
            itemCount: daftar.length,
            itemBuilder: (context, index) {
              final item = daftar[index];
              return Dismissible(
                key: ValueKey(item.key),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) async {
                  await HiveHelper.instance.hapusModerasi(item);
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      '${item.judulBuku} • @${item.namaPengulas}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '"${item.isiUlasan}"\n'
                      'Status: ${item.statusTindakan} (${item.tanggal})',
                    ),
                    isThreeLine: true,
                    onTap: () async {
                      final statusBaru =
                          item.statusTindakan == 'Dihapus (Peringatan Akun)'
                              ? 'Laporan Diabaikan (Bersih)'
                              : 'Dihapus (Peringatan Akun)';
                      await HiveHelper.instance
                          .ubahStatusModerasi(item, statusBaru);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tampilkanFormTambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}