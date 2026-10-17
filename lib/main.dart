import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/app_routes.dart';
import 'providers/cart_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/review_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()), // Provider Baru
      ],
      child: const IkapiApp(),
    ),
  );
}

class IkapiApp extends StatelessWidget {
  const IkapiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IKAPI Bookstore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C5CE7),
      ),
      initialRoute: AppRoutes.root,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}