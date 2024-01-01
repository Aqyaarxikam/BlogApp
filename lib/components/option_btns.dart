import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  OptionButton({required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
          minWidth: double.infinity,
          color: Colors.white,
          height: 55,
          child: Text(
            title,
            style: GoogleFonts.nunito(color: Colors.blueAccent, fontSize: 20,fontWeight: FontWeight.w800),
          ),
          onPressed: onPress),
    );
  }
}
