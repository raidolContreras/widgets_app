import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const colorList = <Color>[
  Color(0xFFFFE082), // Amarillo suave
  Color(0xFF81D4FA), // Azul suave
  Color(0xFFFFCCBC), // Naranja suave
  Color(0xFFB2EBF2), // Cian suave
  Color(0xFFC8E6C9), // Verde suave
  Color(0xFFF48FB1), // Rosa suave
  Color(0xFFB39DDB), // Púrpura suave
  Color(0xFFFFAB91), // Melocotón suave
  Color(0xFF9FA8DA), // Azul índigo suave
  Color(0xFF80CBC4), // Turquesa suave
];


class AppTheme {
  final int selectedColor;
  final bool isDarkmode;
  final bool allowOrientationChange;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkmode = false,
    this.allowOrientationChange = false,
  }) : assert(selectedColor >= 0, 'Selected color must be greater than or equal to 0'),
       assert(selectedColor < colorList.length, 'Selected color must be less than ${colorList.length}');

  void applySystemSettings() {
    if (!allowOrientationChange) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme: const AppBarTheme(
      centerTitle: false,
    ),
    fontFamily: 'Poppins',
  );

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkmode,
    bool? allowOrientationChange = false,
  }) {
    return AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDarkmode: isDarkmode ?? this.isDarkmode,
      allowOrientationChange: allowOrientationChange ?? this.allowOrientationChange,
    );
  }
}
