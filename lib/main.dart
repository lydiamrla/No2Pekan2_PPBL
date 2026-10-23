import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/favorit_cubit.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/review_cubit.dart'; 
import 'navigation/app_routes.dart';

void main() {
  runApp(const IkapiApp());
}

class IkapiApp extends StatelessWidget {
  const IkapiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteCubit>(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider<ReviewCubit>( 
          create: (context) => ReviewCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'IKAPI Bookstore',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF6C5CE7),
        ),
        initialRoute: AppRoutes.root,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onUnknownRoute: AppRoutes.onUnknownRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}