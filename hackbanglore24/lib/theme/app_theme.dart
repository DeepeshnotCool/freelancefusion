import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark() {
    final themeData = ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.cyan,
    );
    return themeData.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(themeData.textTheme)
    );
  }
}
