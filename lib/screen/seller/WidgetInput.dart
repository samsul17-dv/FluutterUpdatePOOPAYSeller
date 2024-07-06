import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class InputFields extends StatelessWidget {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _namaTokoController = TextEditingController();
  final TextEditingController _alamatTokoController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _namaLengkapFocus = FocusNode();
  final FocusNode _namaTokoFocus = FocusNode();
  final FocusNode _alamatTokoFocus = FocusNode();
  final FocusNode _bankFocus = FocusNode();

  InputFields({super.key});

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

  void sendDataToServer(BuildContext context) async {
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
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaLengkapController,
                focusNode: _namaLengkapFocus,
                decoration: _buildInputDecoration('Nama Lengkap'),
                style: GoogleFonts.patrickHand(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Lengkap wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaTokoController,
                focusNode: _namaTokoFocus,
                decoration: _buildInputDecoration('Nama Toko'),
                style: GoogleFonts.patrickHand(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Toko wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamatTokoController,
                focusNode: _alamatTokoFocus,
                decoration: _buildInputDecoration('Alamat Toko'),
                style: GoogleFonts.patrickHand(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat Toko wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bankController,
                focusNode: _bankFocus,
                decoration: _buildInputDecoration('Bank'),
                style: GoogleFonts.patrickHand(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Bank wajib diisi';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
