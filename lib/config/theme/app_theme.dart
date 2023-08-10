import 'package:flutter/material.dart';

List<Color> colors = [Colors.deepOrange, Colors.black, Colors.red];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false}): assert(selectedColor >= 0, 'selectedColor must be greater than or equal to 0'),
  assert(selectedColor <= colors.length -1, 'selectedColor must be less than or equal to the ${colors.length - 1}');


  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colors[selectedColor],
        brightness: isDarkMode ? Brightness.light : Brightness.dark,
      );
}
