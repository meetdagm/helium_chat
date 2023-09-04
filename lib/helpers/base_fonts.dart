import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_colors.dart';

class BaseFonts {
  // static TextStyle Function() style = GoogleFonts.lato;

  static TextStyle extraLargeTitle({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: 55,
    );
  }

  static TextStyle largeTitle({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 34,
    );
  }

  static TextStyle title1({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );
  }

  static TextStyle title2({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    );
  }

  static TextStyle title3({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    );
  }

  static TextStyle headline(
      {Color color = BaseColors.black, double fontSize = 18}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
    );
  }

  static TextStyle headline2({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 17,
    );
  }

  static TextStyle headline3({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
  }

  static TextStyle custom({
    Color color = BaseColors.black,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  static TextStyle body({
    Color color = BaseColors.black,
    double fontSize = 14,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
    );
  }

  static TextStyle footNote({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    );
  }

  static TextStyle caption({Color color = BaseColors.black}) {
    return GoogleFonts.roboto(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 11,
    );
  }

  static TextStyle logo({
    Color color = BaseColors.black,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.firaSans(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }
}
