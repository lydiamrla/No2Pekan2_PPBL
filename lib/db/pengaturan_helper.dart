import 'package:shared_preferences/shared_preferences.dart';

class PengaturanHelper {
  PengaturanHelper._internal();
  static final PengaturanHelper instance = PengaturanHelper._internal();

  static const String _keyDarkMode = 'is_dark_mode';

  Future<void> simpanDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, isDark);
  }

  Future<bool> muatDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ?? false;
  }
}