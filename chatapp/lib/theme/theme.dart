import 'package:flutter/material.dart';
import './palette.dart';

class Themes {
  static final ThemeData lightMode = ThemeData(
      accentColor: Palette.accent,
      primaryColor: Palette.primary,
      backgroundColor: Palette.bg,
      scaffoldBackgroundColor: Palette.sc,
      cardColor: Palette.bg,
      canvasColor: Palette.bg,
      brightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      buttonTheme: ButtonThemeData(
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
          elevation: 0
      ),
      fontFamily: 'Gilroy',
      visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}