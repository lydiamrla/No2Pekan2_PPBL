import 'package:flutter/material.dart';
import '../models/book.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Book> _favoriteBooks = [];

  List<Book> get favoriteBooks => _favoriteBooks;

  bool isFavorite(Book book) => _favoriteBooks.any((item) => item.id == book.id);

  void toggleFavorite(Book book) {
    if (isFavorite(book)) {
      _favoriteBooks.removeWhere((item) => item.id == book.id);
    } else {
      _favoriteBooks.add(book);
    }
    notifyListeners();
  }
}