import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';


final colorListProvider = Provider((ref) => colorList);

// Un bool
final isDarkModeProvider = StateProvider((ref) => false);

// Un entero
final selectedColorProvider = StateProvider((ref) => 0);
