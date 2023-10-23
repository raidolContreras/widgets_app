import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const name = 'theme_changer';
  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final clickDarkMode = ref.watch( themeNotifierProvider ).isDarkmode;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon( clickDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: (){
              // ref.read( isDarkModeProvider.notifier )
                // .update((state) => !state);
                ref.read(themeNotifierProvider.notifier ).toggleDarkMode();
            },
          )
        ],
        title: const Text('Selector de Temas'),
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {

    final List<Color> colors = ref.watch( colorListProvider );
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index){
        final color = colors[index];
        return RadioListTile(
          title: Text('Tema ${index + 1}', style: TextStyle(color: color),),
          // subtitle: Text('${color.value}'),
          activeColor: color,
          value: index,
          groupValue: selectedColor,
          onChanged: (value) {
            // ref.read( selectedColorProvider.notifier ).state = index;
            ref.read(themeNotifierProvider.notifier ).changeColorIndex(index);
          }
        );
      },
    );
  }
}