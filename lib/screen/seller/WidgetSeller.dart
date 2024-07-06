import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasi/screen/seller/WidgetDaftarSeller.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String buttonText = 'Buka Toko';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    buttonText = 'Buka Toko'; // Set initial button text
  }

  void _handleButtonPress() {
    setState(() {
      isLoading = true; // Set loading state
      buttonText = 'Tunggu Dulu Ya!'; // Update button text

      // Simulate delay and navigate to next screen
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const DaftarSeller(),
            transitionDuration: const Duration(seconds: 0), // No animation duration
          ),
        ).then((_) {
          // Reset button text and loading state when returning from next screen
          if (mounted) {
            _resetScreenState();
          }
        });
      });
    });
  }

  // Method to reset button text and loading state
  void _resetScreenState() {
    setState(() {
      isLoading = false;
      buttonText = 'Buka Toko';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Toko Saya',
          style: GoogleFonts.patrickHand(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 140.0), // Adjust top padding here
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://assets.tokopedia.net/assets-tokopedia-lite/v2/atreus/kratos/5dba116d.png', // Placeholder image URL
                height: 300, // Adjust the height as needed
              ),
              const SizedBox(height: 0),
              Text(
                'Ciptakan Peluangmu dengan Membuka Toko!',
                style: GoogleFonts.patrickHand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Mulai dari satu tempat! Buka usaha kamu dan capai banyak pembeli dengan pengalaman mengelola usaha semudah update status.',
                style: GoogleFonts.patrickHand(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleButtonPress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01AC66), // Set the button color
                    padding: const EdgeInsets.symmetric(vertical: 16), // Increase button height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // Add rounded corners if desired
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText, // Show buttonText
                    style: GoogleFonts.patrickHand(
                      fontSize: 18,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Add your button press logic here
                },
                child: Text(
                  'Toko Kamu Hilang? Pelajari Selengkapnya',
                  style: GoogleFonts.patrickHand(
                    color: const Color(0xFF01AC66),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
