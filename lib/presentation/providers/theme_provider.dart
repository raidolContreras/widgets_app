import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';


final colorListProvider = Provider((ref) => colorList);

// Un bool
final isDarkModeProvider = StateProvider((ref) => false);

// Un entero
final selectedColorProvider = StateProvider((ref) => 0);

// Un objeto de tipo Apptheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

// Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {

  // State = Estado = New AppTheme
  ThemeNotifier(): super(AppTheme());

  void toggleDarkMode(){
    state = state.copyWith( isDarkmode: !state.isDarkmode );
  }

  void changeColorIndex( int colorIndex ) {
    state = state.copyWith( selectedColor: colorIndex);
  }

}