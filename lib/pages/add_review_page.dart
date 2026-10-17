import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/review_provider.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedBookTitle;
  double _rating = 5.0;
  final _reviewerController = TextEditingController();
  final _reviewTextController = TextEditingController();

  @override
  void dispose() {
    _reviewerController.dispose();
    _reviewTextController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newReview = BookReview(
        id: DateTime.now().toString(),
        bookTitle: _selectedBookTitle!,
        rating: _rating,
        reviewText: _reviewTextController.text,
        reviewerName: _reviewerController.text,
      );

      context.read<ReviewProvider>().addReview(newReview);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ulasan berhasil ditambahkan!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tulis Ulasan Buku', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Pilih Buku',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: dummyBooks.map((book) {
                    return DropdownMenuItem(
                      value: book.title,
                      child: Text(book.title),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedBookTitle = val),
                  validator: (val) => val == null ? 'Pilih buku terlebih dahulu' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reviewerController,
                  decoration: InputDecoration(
                    labelText: 'Nama Anda',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (val) => (val == null || val.isEmpty) ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<double>(
                  value: _rating,
                  decoration: InputDecoration(
                    labelText: 'Rating (Bintang)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [1.0, 2.0, 3.0, 4.0, 5.0].map((star) {
                    return DropdownMenuItem(
                      value: star,
                      child: Text('$star Bintang ⭐'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _rating = val!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reviewTextController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Tulis Ulasan Anda...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (val) => (val == null || val.length < 5) ? 'Ulasan minimal 5 karakter' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Kirim Ulasan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}