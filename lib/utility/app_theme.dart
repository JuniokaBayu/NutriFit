import 'package:flutter/material.dart';
import 'package:fit_scale/utility/app_color.dart';


class AppTheme {
  // For Light Mode
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF7AB8F5)),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColor.creamLight,

      fontFamily: 'Ubuntu',

        
      // popupMenuTheme: const PopupMenuThemeData(
      //   color: Color(0xFFE3F2FD), // Biru sangat muda untuk popup
      //   textStyle: TextStyle(
      //     color: Color(0xFF0D47A1), // Text biru tua
      //     fontSize: 16,
      //   ),
      // ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18),
        bodyMedium: TextStyle(fontSize: 16),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  // For Dark Mode
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87, brightness: Brightness.dark),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Ubuntu',

      
      // popupMenuTheme: const PopupMenuThemeData(
      //   color: Color(0xFF2C2C2C), // Abu gelap untuk popup
      //   textStyle: TextStyle(
      //     color: Colors.white,
      //     fontSize: 16,
      //   ),
      // ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}