import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//final textTheme = GoogleFonts.latoTextTheme();

const colorSeed = Color(0xFF0AA342);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);

class AppTheme {
  ThemeData theme() {
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorSeed,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: colorSeed,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: scaffoldBackgroundColor,
          elevation: 0,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: colorSeed,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.spaceGrotesk(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
