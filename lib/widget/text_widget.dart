import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_isar_database/core/constant/app_color.dart';

/// A [Text] widget with the Inter font.
Widget textInter(String text,
    {TextAlign align = TextAlign.center,
    Color color = AppColors.white,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w400}) {
  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.inter(color: color, fontSize: fontSize, fontWeight: fontWeight),
  );
}

/// A [Text] widget with the Poppins font.
Widget textPoppins(String text,
    {TextAlign align = TextAlign.center,
    Color color = AppColors.white,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w400}) {
  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.poppins(color: color, fontSize: fontSize, fontWeight: fontWeight),
  );
}
