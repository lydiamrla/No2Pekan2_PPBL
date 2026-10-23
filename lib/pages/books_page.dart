import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book.dart';
import '../navigation/app_routes.dart';
import '../cubits/cart_cubit.dart';
import '../cubits/favorit_cubit.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredBooks = dummyBooks.where((book) {
      return book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Buku', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari judul atau penulis...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6C5CE7)),
                filled: true,
                fillColor: Colors.purple.shade50.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<FavoriteCubit, Set<String>>(
              builder: (context, favoritSet) {
                return BlocBuilder<CartCubit, List<Book>>(
                  builder: (context, cartItems) {
                    final cartCubit = context.read<CartCubit>();

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];
                        final isFavorit = favoritSet.contains(book.id);
                        final isInCart = cartCubit.isBookInCart(book);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(book.image, width: 50, height: 70, fit: BoxFit.cover),
                            ),
                            title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(book.author),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Tombol Favorit + Notifikasi SnackBar
                                IconButton(
                                  icon: Icon(
                                    isFavorit ? Icons.star : Icons.star_border,
                                    color: isFavorit ? Colors.amber : null,
                                  ),
                                  onPressed: () {
                                    context.read<FavoriteCubit>().toggleFavorite(book.id);
                                    
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isFavorit
                                              ? 'Dihapus dari favorit ⭐'
                                              : 'Berhasil ditambahkan ke favorit ⭐',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                ),
                                // Tombol Keranjang + Notifikasi SnackBar
                                IconButton(
                                  icon: Icon(
                                    isInCart ? Icons.shopping_bag : Icons.add_shopping_cart,
                                    color: const Color(0xFF6C5CE7),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    if (isInCart) {
                                      cartCubit.hapusDariKeranjang(book);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Buku dihapus dari keranjang 🛍️'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      cartCubit.tambahKeKeranjang(book);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Berhasil ditambahkan ke keranjang 🛍️'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.bookDetail, arguments: book);
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}