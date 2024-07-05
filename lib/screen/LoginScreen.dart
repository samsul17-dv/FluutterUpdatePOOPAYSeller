import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart'; // Pastikan import file HomeScreen.dart yang benar
import 'SignUp.dart'; // Pastikan import file SignUp.dart yang benar

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>(); // Kunci form untuk validasi
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final url = Uri.parse('https://samsulmuarif.my.id/server/api_login.php');

    try {
      final response = await http.post(
        url,
        body: {
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        bool success = jsonData['success'] ?? false;

        if (success) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', jsonData['user']['username']);
          await prefs.setString('email', jsonData['user']['email']);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homescreen()), // Ganti dengan nama kelas halaman beranda Anda
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Gagal'),
              content: Text('Email atau Password salah.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        throw Exception('Gagal melakukan permintaan ke server');
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat melakukan login.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    'Masuk Dulu Yuk!',
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
                    'Setelah Kamu membuat Akun, Kamu Wajib mengisi Formulir Masuk ini dengan Akun dan Kata Sandi yang sudah di buat ya!',
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
                controller: _emailController,
                style: GoogleFonts.patrickHand(),
                decoration: InputDecoration(
                  labelText: 'Alamat Email',
                  hintText: 'Masukan Alamat Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  isCollapsed: true,
                  prefixIcon: Icon(Icons.email, color: Color(0xFF01AC66)),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Alamat Email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Format Email tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                style: GoogleFonts.patrickHand(),
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
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  isCollapsed: true,
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF01AC66)),
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
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Kata Sandi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validasi berhasil, lakukan proses login
                    _login();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF01AC66), // Warna teks di tombol
                  padding: EdgeInsets.symmetric(vertical: 18.0), // Sedikit tinggikan tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Masuk dan Nikmati Fitur',
                  style: GoogleFonts.patrickHand(
                    textStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                    // Ganti SignUpScreen dengan nama kelas halaman pendaftaran Anda
                  );
                },
                child: Text(
                  'Belum memiliki akun? Buat Yuk!',
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
