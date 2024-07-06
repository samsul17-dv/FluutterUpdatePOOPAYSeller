import 'package:aplikasi/screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/screen/LoginScreen.dart';
import 'package:aplikasi/screen/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POOPAY',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(), // Remove const if constructor is not const
        '/home': (context) => const Homescreen(), // Remove const if constructor is not const
      },
    );
  }
}
