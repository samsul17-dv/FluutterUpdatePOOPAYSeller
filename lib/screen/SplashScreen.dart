import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikasi/screen/HomeScreen.dart';
import 'package:aplikasi/screen/WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnLoginStatus();
  }

  void _navigateBasedOnLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 3)); // Simulate a loading process

    if (isLoggedIn) {
      // Navigate to HomeScreen if logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } else {
      // Navigate to WelcomeScreen if not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01AC66), // Background color 01AC66
      body: Center(
        child: Image.asset(
          'assets/logo/logo.png', // Path to your logo image asset
          width: 300, // Adjust width as needed
          height: 300, // Adjust height as needed
        ),
      ),
    );
  }
}
