import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF3D568F);
  static const Color backgroundColor = Color(0xFFFDFDF5);
  static const Color whiteColor = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
        headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primaryColor),
        headline3: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor),
        bodyText1: TextStyle(fontSize: 13, color: Colors.black87),
        bodyText2: TextStyle(fontSize: 12, color: Colors.black54),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          onPrimary: whiteColor,
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      cardTheme: CardTheme(
        color: whiteColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}