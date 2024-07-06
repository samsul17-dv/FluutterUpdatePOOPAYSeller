import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Implement save logic here
          // Include validation and data saving functionality
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF01AC66),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          'Simpan Data',
          style: GoogleFonts.patrickHand(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
