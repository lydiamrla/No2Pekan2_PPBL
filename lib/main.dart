import 'package:flutter/material.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(const IkapiApp());
}

class IkapiApp extends StatelessWidget {
  const IkapiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IKAPI Online Bookstore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      initialRoute: AppRoutes.root,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}