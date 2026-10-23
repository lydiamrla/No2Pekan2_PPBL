import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/favorit_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFF0984E3), Color(0xFF6C5CE7)]),
              ),
              child: const CircleAvatar(
                radius: 46,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xFF6C5CE7)),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Paul McCarney', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('McCarney@ikapi.ac.id', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              icon: Icon(_isEditing ? Icons.check : Icons.edit),
              label: Text(_isEditing ? 'Simpan Profil' : 'Edit Profil'),
            ),
            const Divider(height: 40),
            
            BlocBuilder<FavoriteCubit, Set<String>>(
              builder: (context, favoritSet) {
                return ListTile(
                  leading: const Icon(Icons.star, color: Colors.amber),
                  title: const Text('Buku Favorit Saya'),
                  trailing: Chip(
                    label: Text('${favoritSet.length} Item'),
                    backgroundColor: Colors.purple.shade50,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}