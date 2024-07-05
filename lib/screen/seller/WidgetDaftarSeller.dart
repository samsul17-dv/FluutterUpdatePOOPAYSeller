import 'package:aplikasi/screen/seller/WidgetHalamanverifikasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DaftarSeller extends StatefulWidget {
  @override
  _DaftarSellerState createState() => _DaftarSellerState();
}

class _DaftarSellerState extends State<DaftarSeller> {
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool acceptPolicy = false; // State untuk checkbox
  bool isVerifying = false; // State untuk menunjukkan sedang dalam proses verifikasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mulai Berjualan di POOPAY!',
              style: GoogleFonts.patrickHand(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Jenis Toko Apa yang ingin Kamu Buat?',
              style: GoogleFonts.patrickHand(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuButton(
                    'https://assets.tokopedia.net/assets-tokopedia-lite/v2/atreus/kratos/573bbc81.svg',
                    'Toko Perorangan',
                    'Buka toko, prosesnya mudah dan cepat, hanya dengan verifikasi e-KTP.',
                    isSelected1,
                    () {
                      setState(() {
                        isSelected1 = !isSelected1;
                        isSelected2 = false; // Untuk memastikan hanya satu yang dipilih
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _buildMenuButton(
                    'https://assets.tokopedia.net/assets-tokopedia-lite/v2/atreus/kratos/684e58ec.svg',
                    'Official Store',
                    'Toko dengan layanan eksklusif yang memiliki dokumen SIUP/NIB, KTP & NPWP.',
                    isSelected2,
                    () {
                      setState(() {
                        isSelected2 = !isSelected2;
                        isSelected1 = false; // Untuk memastikan hanya satu yang dipilih
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!isSelected1 && !isSelected2) {
                    // Tampilkan notifikasi pop-up jika tidak ada jenis toko yang dipilih
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://assets.tokopedia.net/assets-tokopedia-lite/v2/atreus/kratos/5dba116d.png', // Ganti dengan URL gambar yang diinginkan
                                width: 200,
                                height: 200,
                              ),
                              SizedBox(height: 0),
                              Text(
                                'Kamu Belum Memilih Jenis Toko Nih!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.patrickHand(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 0),
                              Text(
                                'Silakan Pilih Jenis Toko Terlebih Dahulu Sebelum Membuat Toko, Pastikan Pilih Sesuai dengan Bisnis dan Keinginan Kamu Ya!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.patrickHand(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Kembali untuk Memilih Jenis Toko',
                                    style: GoogleFonts.patrickHand(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF01AC66), // Ganti backgroundColor ke primary
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    return;
                  }

                  // Tampilkan pop-up notifikasi
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Verifikasi Data Diri',
                                    style: GoogleFonts.patrickHand(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  _buildVerificationItem(
                                    'https://assets.tokopedia.net/assets-tokopedia-lite/v2/arael/kratos/ff154361.png', // URL gambar KTP dari internet
                                    'Ambil Foto E-KTP',
                                    'Siapkan E-KTP Asli Kamu dan Pastikan Masih Berlaku Ya!',
                                  ),
                                  SizedBox(height: 16),
                                  _buildVerificationItem(
                                    'https://assets.tokopedia.net/assets-tokopedia-lite/v2/atreus/kratos/a46faa51.png?ect=4g', // URL gambar lainnya dari internet
                                    'Ambil Selfie',
                                    'Siap - Siap! Cari Tempat Terang dan Lepas Kacamata atau Masker Kamu Ya!',
                                  ),
                                  SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        acceptPolicy = !acceptPolicy;
                                      });
                                    },
                                    child: Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: GoogleFonts.patrickHand(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Saya menyetujui ',
                                            ),
                                            TextSpan(
                                              text: 'Syarat & Ketentuan ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'WebSpaceStudio dan POOPAY Indonesia.',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: isVerifying
                                          ? null
                                          : () async {
                                              setState(() {
                                                isVerifying = true;
                                              });

                                              // Simulasi proses verifikasi
                                              await Future.delayed(
                                                  Duration(seconds: 2));

                                              setState(() {
                                                acceptPolicy = !acceptPolicy;
                                                isVerifying = false;
                                              });

                                              // Ganti teks tombol menjadi "Tunggu Sebentar Ya!"
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context, animation,
                                                          secondaryAnimation) =>
                                                      HalamanVerifikasi(),
                                                  transitionsBuilder: (context, animation,
                                                      secondaryAnimation, child) {
                                                    return child;
                                                  },
                                                  transitionDuration:
                                                      Duration(milliseconds: 0),
                                                  // Set duration to 0 milliseconds
                                                ),
                                              );
                                            },
                                      child: Text(
                                        isVerifying
                                            ? 'Tunggu Sebentar Ya!'
                                            : 'Mulai Verifikasi',
                                        style: GoogleFonts.patrickHand(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF01AC66), // Ganti backgroundColor ke primary
                                        padding: EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Text(
                  'Lanjut untuk Membuka Toko',
                  style: GoogleFonts.patrickHand(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF01AC66), // Ganti backgroundColor ke primary
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(String iconUrl, String title, String description,
      bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: isSelected ? Colors.green : Colors.grey, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.network(
              iconUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              placeholderBuilder: (context) =>
                  CircularProgressIndicator(), // Indikator loading opsional
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.patrickHand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.patrickHand(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10), // Sesuaikan spasi di sini
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationItem(
      String imageUrl, String label, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.patrickHand(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.patrickHand(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
