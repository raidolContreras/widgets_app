import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const name = 'theme_changer';

  const ThemeChangerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selector de Temas'),
        actions: [
          FadeInRight(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey<bool>(isDarkMode),
              icon: Icon(
                isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: colors.onSurface,
              ),
              onPressed: () {
                ref
                    .read(themeNotifierProvider.notifier)
                    .toggleDarkMode();
              },
            ),
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary, colors.onPrimary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      padding: const EdgeInsets.all(20.0),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        final colorName = getColorName(color);

        return Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: InkWell(
            onTap: () {
              ref
                  .read(themeNotifierProvider.notifier)
                  .changeColorIndex(index);
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.8), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text(
                      colorName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: Radio(
                      value: index,
                      groupValue: selectedColor,
                      onChanged: (value) {
                        ref
                            .read(themeNotifierProvider.notifier)
                            .changeColorIndex(value as int);
                      },
                      activeColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getColorName(Color color) {
    switch (color.value) {
      case 0xFFFFE082:
        return 'Ámbar Suave';
      case 0xFF81D4FA:
        return 'Azul Claro Suave';
      case 0xFFFFCCBC:
        return 'Naranja Profundo Suave';
      case 0xFFB2EBF2:
        return 'Cian Suave';
      case 0xFFC8E6C9:
        return 'Verde Claro Suave';
      case 0xFFF48FB1:
        return 'Rosa Suave';
      case 0xFFB39DDB:
        return 'Púrpura Profundo Suave';
      case 0xFFFFAB91:
        return 'Melocotón Suave';
      case 0xFF9FA8DA:
        return 'Azul Índigo Suave';
      case 0xFF80CBC4:
        return 'Turquesa Suave';
      default:
        return 'Color Desconocido';
    }
  }
}
