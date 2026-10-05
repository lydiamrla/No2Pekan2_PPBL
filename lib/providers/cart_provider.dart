import 'package:flutter/material.dart';
import '../models/book.dart';

class CartProvider extends ChangeNotifier {
  final List<Book> _items = [];

  List<Book> get items => _items;
  int get itemCount => _items.length;
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  bool isBookInCart(Book book) => _items.any((item) => item.id == book.id);

  void addToCart(Book book) {
    if (!isBookInCart(book)) {
      _items.add(book);
      notifyListeners();
    }
  }

  void removeFromCart(Book book) {
    _items.removeWhere((item) => item.id == book.id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}