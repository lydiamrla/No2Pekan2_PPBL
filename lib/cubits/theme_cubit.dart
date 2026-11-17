import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../db/pengaturan_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({ThemeMode initialMode = ThemeMode.light}) : super(initialMode);

  Future<void> toggleTheme() async {
    final jadiGelap = state != ThemeMode.dark;
    await PengaturanHelper.instance.simpanDarkMode(jadiGelap);
    emit(jadiGelap ? ThemeMode.dark : ThemeMode.light);
  }
}