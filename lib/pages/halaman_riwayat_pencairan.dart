import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/catatan_pencairan.dart';

class HalamanRiwayatPencairan extends StatefulWidget {
  const HalamanRiwayatPencairan({super.key});

  @override
  State<HalamanRiwayatPencairan> createState() =>
      _HalamanRiwayatPencairanState();
}

class _HalamanRiwayatPencairanState extends State<HalamanRiwayatPencairan> {
  late Future<List<CatatanPencairan>> _daftarPencairan;

  @override
  void initState() {
    super.initState();
    _muatUlangData();
  }

  void _muatUlangData() {
    setState(() {
      _daftarPencairan = DatabaseHelper.instance.ambilSemuaPencairan();
    });
  }

  // ===== FUNGSI CREATE: POP-UP FORM TAMBAH PENCAIRAN =====
  Future<void> _tampilkanFormTambah() async {
    final penerbitController = TextEditingController();
    final nominalController = TextEditingController();
    final referensiController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Catat Pencairan Dana'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: penerbitController,
                decoration: const InputDecoration(labelText: 'Nama Penerbit'),
              ),
              TextField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Nominal (Rp)'),
              ),
              TextField(
                controller: referensiController,
                decoration: const InputDecoration(labelText: 'Nomor Referensi'),
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
              final nominal = int.tryParse(nominalController.text);
              if (penerbitController.text.isEmpty ||
                  nominal == null ||
                  referensiController.text.isEmpty) {
                return;
              }

              await DatabaseHelper.instance.tambahPencairan(
                CatatanPencairan(
                  namaPenerbit: penerbitController.text,
                  nominal: nominal,
                  nomorReferensi: referensiController.text,
                  status: 'Selesai Ditransfer',
                  tanggal: DateTime.now().toString().substring(0, 16),
                ),
              );

              if (!context.mounted) return;
              Navigator.pop(context);
              _muatUlangData();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Riwayat pencairan dana berhasil disimpan.'),
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
      appBar: AppBar(title: const Text('Riwayat Pencairan Penerbit')),
      body: FutureBuilder<List<CatatanPencairan>>(
        future: _daftarPencairan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final daftar = snapshot.data ?? [];
          if (daftar.isEmpty) {
            return const Center(
              child: Text('Belum ada riwayat pencairan dana tersimpan.'),
            );
          }
          return ListView.builder(
            itemCount: daftar.length,
            itemBuilder: (context, index) {
              final item = daftar[index];
              return Dismissible(
                key: ValueKey(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) async {
                  await DatabaseHelper.instance.hapusPencairan(item.id!);
                  _muatUlangData();
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      '${item.namaPenerbit} • Rp${item.nominal}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Ref: ${item.nomorReferensi} (${item.status})\n'
                      'Tanggal: ${item.tanggal}',
                    ),
                    isThreeLine: true,
                    onTap: () async {
                      final controller = TextEditingController(
                        text: item.nomorReferensi,
                      );
                      final refBaru = await showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Koreksi Nomor Referensi Transfer'),
                          content: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              labelText: 'Nomor Referensi Bank',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, controller.text),
                              child: const Text('Simpan'),
                            ),
                          ],
                        ),
                      );

                      if (refBaru != null && refBaru.isNotEmpty) {
                        await DatabaseHelper.instance.ubahPencairan(
                          CatatanPencairan(
                            id: item.id,
                            namaPenerbit: item.namaPenerbit,
                            nominal: item.nominal,
                            nomorReferensi: refBaru,
                            status: item.status,
                            tanggal: item.tanggal,
                          ),
                        );
                        _muatUlangData();
                      }
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
        tooltip: 'Catat Pencairan Baru',
        child: const Icon(Icons.add),
      ),
    );
  }
}