import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({
    super.key,
    required this.image,
    required this.text,
  });

  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 340,
            width: double.infinity,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff0082C6),
            ),
          ),
        ],
      ),
    );
  }
}
