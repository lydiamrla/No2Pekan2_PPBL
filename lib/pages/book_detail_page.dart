import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/favorite_provider.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<FavoriteProvider>().isFavorite(book);
    final isInCart = context.watch<CartProvider>().isBookInCart(book);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () => context.read<FavoriteProvider>().toggleFavorite(book),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF6C5CE7).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(book.image, height: 260, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(book.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Oleh ${book.author}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 16),
            Text('Rp ${book.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, color: Color(0xFF6C5CE7), fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            const Text('Deskripsi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(book.description, style: const TextStyle(height: 1.6, color: Colors.black87)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF0984E3), Color(0xFF6C5CE7)]),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              if (isInCart) {
                context.read<CartProvider>().removeFromCart(book);
              } else {
                context.read<CartProvider>().addToCart(book);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: Icon(isInCart ? Icons.delete_outline : Icons.shopping_cart, color: Colors.white),
            label: Text(
              isInCart ? 'Hapus dari Keranjang' : 'Tambah ke Keranjang',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}