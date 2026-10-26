import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/favorit_cubit.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/review_cubit.dart'; 
import 'cubits/theme_cubit.dart';
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
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'IKAPI Bookstore',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6C5CE7),
                brightness: Brightness.light,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6C5CE7),
                brightness: Brightness.dark,
              ),
            ),
            themeMode: themeMode,
            initialRoute: AppRoutes.root,
            routes: AppRoutes.routes,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            onUnknownRoute: AppRoutes.onUnknownRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}