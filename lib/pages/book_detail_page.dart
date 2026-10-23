import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/favorit_cubit.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _sedangMemproses = false;

  void _prosesTambahKeranjang(Book book) async {
    setState(() {
      _sedangMemproses = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    final cartCubit = context.read<CartCubit>();
    final isInCart = cartCubit.isBookInCart(book);

    if (isInCart) {
      cartCubit.hapusDariKeranjang(book);
    } else {
      cartCubit.tambahKeKeranjang(book);
    }

    setState(() {
      _sedangMemproses = false;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isInCart
              ? 'Buku "${book.title}" dihapus dari keranjang 🛍️'
              : 'Buku "${book.title}" berhasil ditambahkan ke keranjang 🛍️',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<FavoriteCubit, Set<String>>(
            builder: (context, favoritSet) {
              final isFav = favoritSet.contains(widget.book.id);
              return IconButton(
                icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : Colors.grey),
                onPressed: () {
                  context.read<FavoriteCubit>().toggleFavorite(widget.book.id);
                  
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? 'Dihapus dari favorit ⭐'
                            : 'Berhasil ditambahkan ke favorit ⭐',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(widget.book.image, height: 260, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 28),
            Text(widget.book.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Oleh ${widget.book.author}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 16),
            Text('Rp ${widget.book.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, color: Color(0xFF6C5CE7), fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            const Text('Deskripsi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.book.description, style: const TextStyle(height: 1.6, color: Colors.black87)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CartCubit, List<Book>>(
          builder: (context, cartItems) {
            final cartCubit = context.read<CartCubit>();
            final isInCart = cartCubit.isBookInCart(widget.book);

            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0984E3), Color(0xFF6C5CE7)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton.icon(
                onPressed: _sedangMemproses ? null : () => _prosesTambahKeranjang(widget.book),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: _sedangMemproses
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Icon(isInCart ? Icons.delete_outline : Icons.shopping_cart, color: Colors.white),
                label: Text(
                  _sedangMemproses
                      ? 'Memproses...'
                      : (isInCart ? 'Hapus dari Keranjang' : 'Tambah ke Keranjang'),
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}