import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Roundedbutton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  Roundedbutton({required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
          minWidth: double.infinity,
          color: Color.fromARGB(255, 42, 69, 164),
          height: 55,
          child: Text(
            title,
            style: GoogleFonts.nunito(color: Color(0xffffffff), fontSize: 20),
          ),
          onPressed: onPress),
    );
  }
}
