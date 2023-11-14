import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.lightBlue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent
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
