import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xff3D568F);
  static var primary500 = const Color(0xff3D568F).withOpacity(0.1);
  static const background = Color(0xffFDFDF5);
  static const gray = Color(0xff71727A);
  static const white = Color(0xffFFFFFF);
  static const black = Color(0xff000000);
  static const gray500 = Color(0xffDADADA);
  static const info = Color(0xff006FFD);
  static const warning = Color(0xffE8BE32);
  static const danger = Color(0xffED3241);
  static const danger500 = Color(0xffFFE9E9);
  static const secondary = Color(0xffEAF3B2);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primary),
        headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primary),
        headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primary),
        bodyLarge: TextStyle(fontSize: 13, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 12, color: Colors.black54),
      ),

      cardTheme: CardTheme(
        color: white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}