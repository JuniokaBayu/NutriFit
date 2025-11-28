import 'package:flutter/material.dart';

class AppColor {
  // Static common colors

  // Black
  static const Color black = Colors.black;
  static const Color black12 = Colors.black12;
  static const Color black26 = Colors.black26;
  static const Color black38 = Colors.black38;
  static const Color black45 = Colors.black45;
  static const Color black54 = Colors.black54;
  static const Color black87 = Colors.black87;

  // dark
  static const Color darkBlack = Color(0xFF000000);
  static const Color lightBlack = Color(0xE5100F0F);
  static const Color extraLightBlack = Color(0xCD434141);

  // gray


  //white
  static const Color darkWhite = Color(0xFFFFFFFF);
  static const Color white = Color(0xCBFFFFFF);
  static const Color lightWhite = Color(0x99FFFFFF);

  // Blue - pengganti Cream
  static const Color cream = Color(0xFF4A90E2); // Biru utama (medium blue)
  static const Color creamLight = Color(0xFF7AB8F5); // Biru muda
  static const Color creamDark = Color(0xFF2E5C8A); // Biru gelap
  static const Color border = Color(0xFF1E3A5F); // Biru navy untuk border
  static const Color buttonBg = Color(0xFFE3F2FD); // Biru sangat muda untuk background button
  static const Color buttonFg = Color(0xFFBBDEFB); // Biru pastel untuk foreground button
  static const Color dotColor1 = Color(0xFF5C9FD6); // Biru medium untuk dot
  static const Color dotColor2 = Color(0xFF2196F3); // Biru cerah untuk dot kedua
  static const Color appBarTitle = Color.fromARGB(255, 5, 41, 94); // Biru tua untuk app bar title
  static const Color userName = Color(0xFF1565C0); // Biru gelap untuk username

  // red
  static const Color red = Color(0xFFF17171);

  // color: Color(0xFF7AB8F5) - biru muda alternatif



  // static const Color backgroundLight = Color(0xFFF5F5F5);
  // static const Color backgroundDark = Color(0xFF121212);
  static const Color textLight = Color(0xFF212121);
  static const Color textDark = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFFFA000);

  // static Color background1(BuildContext context)=> Theme.of(context).brightness == Brightness.dark
  //     ? AppColor.black
  //     : AppColor.bgLight;

  //  background Color
  static Color background(
      BuildContext context, {
        Color? light,
        Color? dark,
      }) {
    return Theme.of(context).brightness == Brightness.dark
        ? (dark ?? AppColor.lightBlack)
        : (light ?? AppColor.cream);
  }

  // Paragraph Color
  static Color paraColor(
      BuildContext context, {
        Color? light,
        Color? dark,
      }) {
    return Theme.of(context).brightness == Brightness.dark
        ? (dark ?? AppColor.lightBlack)
        : (light ?? AppColor.white);
  }

  // Border Color
  static Color borderColor(
      BuildContext context, {
        Color? light,
        Color? dark,
      }) {
    return Theme.of(context).brightness == Brightness.dark
        ? (dark ?? AppColor.white)
        : (light ?? AppColor.border);
  }

  //button color
  static Color buttonColor(
      BuildContext context, {
        Color? light,
        Color? dark,
      }) {
    return Theme.of(context).brightness == Brightness.dark
        ? (dark ?? AppColor.lightWhite)
        : (light ?? AppColor.buttonBg);
  }
}