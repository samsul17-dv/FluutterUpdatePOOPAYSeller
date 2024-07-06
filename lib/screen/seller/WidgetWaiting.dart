import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetWaiting extends StatefulWidget {
  const WidgetWaiting({super.key});

  @override
  _WidgetWaitingState createState() => _WidgetWaitingState();
}

class _WidgetWaitingState extends State<WidgetWaiting> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // optionally set background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _isLoading ? 0.0 : 1.0,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://assets.tokopedia.net/assets-tokopedia-lite/v2/arael/kratos/ff154361.png',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 16),
              Text(
                'Cie, Menunggu Konfirmasi Yaaa ..',
                style: GoogleFonts.patrickHand(
                  textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Data Kamu Sedang dalam Proses Peninjauan oleh Tim POOPAY. \n Proses ini Membutuhkan Waktu Paling Lama Tiga Hari Kerja.',
                textAlign: TextAlign.center,
                style: GoogleFonts.patrickHand(
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
