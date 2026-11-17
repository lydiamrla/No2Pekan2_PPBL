import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/favorit_cubit.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/review_cubit.dart';
import 'cubits/theme_cubit.dart';
import 'db/hive_helper.dart';
import 'db/pengaturan_helper.dart';
import 'navigation/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.instance.init();
  final isDarkMode = await PengaturanHelper.instance.muatDarkMode();

  runApp(IkapiApp(initialDarkMode: isDarkMode));
}

class IkapiApp extends StatelessWidget {
  final bool initialDarkMode;

  const IkapiApp({super.key, required this.initialDarkMode});

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
          create: (context) => ThemeCubit(
            initialMode: initialDarkMode ? ThemeMode.dark : ThemeMode.light,
          ),
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