import 'dart:convert';
import 'dart:io';

import 'package:aplikasi/screen/seller/WidgetWaiting.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class HalamanVerifikasi extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _namaTokoController = TextEditingController();
  final TextEditingController _alamatTokoController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final FocusNode _namaLengkapFocus = FocusNode();
  final FocusNode _namaTokoFocus = FocusNode();
  final FocusNode _alamatTokoFocus = FocusNode();
  final FocusNode _bankFocus = FocusNode();
  File? _selectedSelfieFile;
  File? _selectedKtpFile;

  HalamanVerifikasi({super.key});

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      hintText: labelText,
      hintStyle: GoogleFonts.patrickHand(color: Colors.grey[700]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF01AC66)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }

  void _openSelfiePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        _selectedSelfieFile = File(result.files.single.path!);
      }
    } catch (e) {
      print('Error picking selfie file: $e');
      // Handle error as needed
    }
  }

  void _openKtpPicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        _selectedKtpFile = File(result.files.single.path!);
      }
    } catch (e) {
      print('Error picking KTP file: $e');
      // Handle error as needed
    }
  }

  void _showDataEmptyPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.network(
                    'https://assets.tokopedia.net/assets-tokopedia-lite/v2/arael/kratos/ff154361.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Text(
                  'Kamu Belum Mengisi Data Nih!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Ayo isi Data Kamu dengan Benar dan Benar, Serta Gunakan Dokumen yang Valid untuk Kelancaran Verifikasi Data Diri Kamu!.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Close the bottom sheet when button is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01AC66),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Kembali Mengisi Data',
                      style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(fontSize: 18, color: Colors.white),
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
  }

  void _showConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://assets.tokopedia.net/assets-tokopedia-lite/v2/arael/kratos/ff154361.png',
                  height: 200,
                  width: 200,
                ),
                Text(
                  'Yeay! Data Sudah Lengkap.',
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Sebelum Lanjut, Apakah Kamu Yakin Sudah Memasukan Data dengan Baik dan Benar, serta Menggunakan Dokumen yang Valid?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet when button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WidgetWaiting()),
                      ); // Navigate to WidgetWaiting page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01AC66),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Lanjutkan untuk Konfirmasi',
                      textAlign: TextAlign.center, // Align text to the center horizontally
                      style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(fontSize: 18, color: Colors.white),
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
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String namaLengkap = _namaLengkapController.text;
      String namaToko = _namaTokoController.text;
      String alamatToko = _alamatTokoController.text;
      String bank = _bankController.text;

      // Prepare data to send
      Map<String, dynamic> data = {
        'nama_lengkap': namaLengkap,
        'nama_toko': namaToko,
        'alamat_toko': alamatToko,
        'bank': bank,
      };

      // Encode data to JSON
      String body = json.encode(data);

      // Send data to server
      Uri url = Uri.parse('https://yourdomain.com/save_data.php');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        // Data sent successfully, handle response if needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dikirim')),
        );
      } else {
        // Error sending data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengirim data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pendaftaran Toko', style: GoogleFonts.patrickHand()),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: _selectedSelfieFile != null
                                    ? Image.file(
                                        _selectedSelfieFile!,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Text('Belum ada foto selfie dipilih',
                                            style: GoogleFonts.patrickHand()),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  onPressed: _openSelfiePicker,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: _selectedKtpFile != null
                                    ? Image.file(
                                        _selectedKtpFile!,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Text('Belum ada foto KTP dipilih',
                                            style: GoogleFonts.patrickHand()),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  onPressed: _openKtpPicker,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _namaLengkapController,
                      focusNode: _namaLengkapFocus,
                      decoration: _buildInputDecoration('Masukan Nama Lengkap Anda'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama lengkap tidak boleh kosong';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_namaTokoFocus);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _namaTokoController,
                      focusNode: _namaTokoFocus,
                      decoration: _buildInputDecoration('Masukan Nama Toko Anda'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama toko tidak boleh kosong';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_alamatTokoFocus);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _alamatTokoController,
                      focusNode: _alamatTokoFocus,
                      decoration: _buildInputDecoration('Masukan Alamat Toko Anda'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Alamat toko tidak boleh kosong';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_bankFocus);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _bankController,
                      focusNode: _bankFocus,
                      decoration: _buildInputDecoration('Masukan Bank Anda'),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bank tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_selectedSelfieFile == null ||
                              _selectedKtpFile == null ||
                              !_formKey.currentState!.validate()) {
                            _showDataEmptyPopup(context);
                          } else {
                            _showConfirmationDialog(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF01AC66),
                          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Lanjutkan untuk Konfirmasi',
                            style: GoogleFonts.patrickHand(
                              textStyle: const TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputFields extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function(String?)? onFieldSubmitted;
  final String? Function(String?)? validator; // Update the type here

  const InputFields({super.key, 
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    required this.focusNode,
    required this.textInputAction,
    required this.onFieldSubmitted,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator, // Use the updated validator type
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}


class PhotoStack extends StatelessWidget {
  final File? photoFile;
  final VoidCallback onTap;

  const PhotoStack({super.key, 
    required this.photoFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: photoFile != null
              ? Image.file(
                  photoFile!,
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Text('Belum ada foto dipilih'),
                ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: onTap,
          ),
        ),
      ],
    );
  }
}
