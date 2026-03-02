import 'package:flutter/material.dart';
import 'package:todo_list_isar_database/widget/text_widget.dart';

class Button extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadius borderRadius;
  final VoidCallback onPressed;


/// A customizable button widget.
  const Button({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.fontSize,
    required this.fontWeight,
    required this.borderRadius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: textPoppins(text,
            fontSize: fontSize, fontWeight: fontWeight, color: textColor),
      ),
    );
  }
}
