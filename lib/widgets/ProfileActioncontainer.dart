import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants.dart';

class ProfileActionContainer extends StatelessWidget {
  String title;
  String Subtitle;
  void Function() OnTap;
  ProfileActionContainer(
      {required this.title,
      required this.Subtitle,
      required this.OnTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: boxColor),
        child: ListTile(
          title: AutoSizeText(title,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18)),
          subtitle: AutoSizeText(Subtitle,
              style: GoogleFonts.inter(
                  color: Colors.grey.withOpacity(0.5), fontSize: 16)),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
