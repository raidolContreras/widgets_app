import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/config/theme/app_theme.dart';

final colorListProvider = Provider((ref) => colorList);

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme()) {
    _loadThemeSettings();
  }

  Future<void> _loadThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeIndex = prefs.getInt('themeIndex') ?? 0;
    final savedDarkMode = prefs.getBool('darkMode') ?? false;

    state = state.copyWith(selectedColor: savedThemeIndex, isDarkmode: savedDarkMode);
  }

  Future<void> _saveThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeIndex', state.selectedColor);
    prefs.setBool('darkMode', state.isDarkmode);
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkmode: !state.isDarkmode);
    _saveThemeSettings();
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
    _saveThemeSettings();
  }
}
