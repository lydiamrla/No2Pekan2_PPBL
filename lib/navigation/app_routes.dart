import 'package:flutter/material.dart';
import '../models/book.dart';
import '../pages/main_wrapper.dart';
import '../pages/book_detail_page.dart';

class AppRoutes {
  static const String root = '/';
  static const String main = '/main';
  static const String bookDetail = '/book-detail';

  static Map<String, WidgetBuilder> get routes => {
        root: (context) => const MainWrapper(initialIndex: 0),
        main: (context) => const MainWrapper(initialIndex: 0),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.purple),
              const SizedBox(height: 16),
              Text('404\nRoute "${settings.name}" tidak ditemukan!', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, root, (route) => false),
                child: const Text('Kembali ke Beranda'),
              )
            ],
          ),
        ),
      ),
    );
  }
}