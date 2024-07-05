import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>(); // Kunci form untuk validasi
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    final Uri uri =
        Uri.parse('https://samsulmuarif.my.id/server/api_signup.php');
    final response = await http.post(uri, body: {
      'username': _usernameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'password': _passwordController.text,
    });

    setState(() {
      _isSubmitting = false;
    });

    if (response.statusCode == 200) {
      // Decode JSON response
      Map<String, dynamic> responseData = jsonDecode(response.body);
      bool status = responseData['status'];
      String message = responseData['message'];

      if (status) {
        // Pendaftaran berhasil
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero, // Remove default padding
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center align content
              children: <Widget>[
                SizedBox(height: 20), // Margin top for the image
                Center(
                  child: Image.asset(
                    'assets/vector/ilustrasi.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Yeay! Akun Berhasil dibuat.',
                    style: GoogleFonts.patrickHand(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00540C), // Set the color to 00540C
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    message,
                    style: GoogleFonts.patrickHand(),
                    textAlign:
                        TextAlign.center, // Center align the message text
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: GoogleFonts.patrickHand(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset form setelah pendaftaran berhasil
                  _resetForm();
                  // Tidak melakukan navigasi ke halaman login
                },
              ),
            ],
          ),
        );
      } else {
        // Pendaftaran gagal
        _showErrorDialog(message);
      }
    } else {
      // Response gagal dari server
      print('Gagal mengirim data');
      print('Response: ${response.body}');
      // Tampilkan notifikasi gagal
      _showErrorDialog('Terjadi kesalahan saat melakukan pendaftaran.');
    }
  }

  void _resetForm() {
    _usernameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pendaftaran Gagal'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Agar form tetap diam saat keyboard muncul
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buat Akun Dulu Ya!',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.patrickHand(
                      textStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Sebelum Kamu bisa mendapatkan layanan POOPAY Indonesia Sepenuhnya, Kamu wajib Buat Akun dulu nih! Data Kamu dijamin Aman Kok!',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.patrickHand(
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _usernameController,
                style: GoogleFonts
                    .patrickHand(), // Menggunakan font PatrickHand untuk input
                decoration: InputDecoration(
                  labelText: 'Nama Kamu',
                  hintText: 'Masukan Nama Kamu Yuk!',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ), // Tinggi input diperbesar sedikit
                  isCollapsed: true,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFF01AC66),
                  ), // Icon berwarna latar belakang tombol
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, // Tidak ada animasi placeholder saat input aktif
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nama Kamu Yuk!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _emailController,
                style: GoogleFonts
                    .patrickHand(), // Menggunakan font PatrickHand untuk input
                decoration: InputDecoration(
                  labelText: 'Alamat Email',
                  hintText: 'Masukan Alamat Email Yuk!',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ), // Tinggi input diperbesar sedikit
                  isCollapsed: true,
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xFF01AC66),
                  ), // Icon berwarna latar belakang tombol
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, // Tidak ada animasi placeholder saat input aktif
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Alamat Email';
                  }
                  if (!value.endsWith('@gmail.com')) {
                    return 'Alamat Email Wajib @gmail.com Ya!.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _phoneController,
                style: GoogleFonts
                    .patrickHand(), // Menggunakan font PatrickHand untuk input
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon atau WhatsApp',
                  hintText: 'Masukan Nomor Telepon atau WhatsApp',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ), // Tinggi input diperbesar sedikit
                  isCollapsed: true,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xFF01AC66),
                  ), // Icon berwarna latar belakang tombol
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, // Tidak ada animasi placeholder saat input aktif
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nomor Telepon/ WhatsApp Yuk!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                style: GoogleFonts
                    .patrickHand(), // Menggunakan font PatrickHand untuk input
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi',
                  hintText: 'Masukan Kata Sandi',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ), // Tinggi input diperbesar sedikit
                  isCollapsed: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF01AC66),
                  ), // Icon berwarna latar belakang tombol
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFF01AC66),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, // Tidak ada animasi placeholder saat input aktif
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Kata Sandi Kamu.';
                  }
                  if (value.length < 6) {
                    return 'Kata Sandi Kamu Harus 6 Karakter.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _confirmPasswordController,
                style: GoogleFonts
                    .patrickHand(), // Menggunakan font PatrickHand untuk input
                obscureText: _obscureConfirmText,
                decoration: InputDecoration(
                  labelText: 'Ulangi Kata Sandi',
                  hintText: 'Masukan Ulangi Kata Sandi',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ), // Tinggi input diperbesar sedikit
                  isCollapsed: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF01AC66),
                  ), // Icon berwarna latar belakang tombol
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFF01AC66),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmText = !_obscureConfirmText;
                      });
                    },
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Ulangi Kata Sandi Kamu.';
                  }
                  if (value != _passwordController.text) {
                    return 'Kata Sandi Kamu Harus Sama.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF01AC66), // Text color
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: _isSubmitting
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'Sudah punya akun? Masuk di sini',
                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF01AC66),
                    ),
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
