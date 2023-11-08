import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';
import 'package:flutter/services.dart';

void main() {
  AppTheme appTheme = AppTheme(
    selectedColor: 0,
    isDarkmode: true,
    allowOrientationChange: false, // Esto evitará el cambio a orientación horizontal
  );
  
  appTheme.applySystemSettings(); // Aplica la configuración de orientación

  // Configura la orientación de la pantalla
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Orientación vertical
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      title: 'Flutter Widgets',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
    );
  }
}
