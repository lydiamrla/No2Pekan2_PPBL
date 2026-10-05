import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../navigation/app_routes.dart';
import '../providers/cart_provider.dart';

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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                final cartProvider = context.watch<CartProvider>();
                final isInCart = cartProvider.isBookInCart(book);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
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
                    trailing: IconButton(
                      icon: Icon(
                        isInCart ? Icons.shopping_bag : Icons.add_shopping_cart,
                        color: const Color(0xFF6C5CE7),
                      ),
                      onPressed: () {
                        if (isInCart) {
                          context.read<CartProvider>().removeFromCart(book);
                        } else {
                          context.read<CartProvider>().addToCart(book);
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.bookDetail, arguments: book);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}