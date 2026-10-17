import 'package:flutter/material.dart';
import '../models/book.dart';
import '../pages/add_review_page.dart'; // Import halaman baru
import '../pages/main_wrapper.dart';
import '../pages/book_detail_page.dart';

class AppRoutes {
  static const String root = '/';
  static const String main = '/main';
  static const String bookDetail = '/book-detail';
  static const String addReview = '/add-review'; // <-- PASTIKAN BARIS INI ADA

  static Map<String, WidgetBuilder> get routes => {
        root: (context) => const MainWrapper(initialIndex: 0),
        main: (context) => const MainWrapper(initialIndex: 0),
        addReview: (context) => const AddReviewPage(), // <-- PASTIKAN BARIS INI ADA
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == bookDetail) {
      final book = settings.arguments as Book;
      return MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book),
        settings: settings,
      );
    }
    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
        body: Center(
          child: Text('404 - Route "${settings.name}" tidak ditemukan!'),
        ),
      ),
    );
  }
}