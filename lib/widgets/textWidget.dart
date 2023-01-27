import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  String text;
  TextWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
      textAlign: TextAlign.center,
    );
  }
}
