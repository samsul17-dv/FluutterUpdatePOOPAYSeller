import 'package:aplikasi/screen/seller/WidgetSeller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key});

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  String username = 'Pengguna';
  String email = 'example@example.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Pengguna';
      email = prefs.getString('email') ?? 'example@example.com';
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data dari SharedPreferences
    Navigator.of(context).pushReplacementNamed('/login'); // Mengarahkan ke halaman login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Pengguna
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://images.tokopedia.net/img/cache/300/tPxBYm/2023/1/20/915df97c-3b46-4de9-ab6b-a22e2190b8e9.jpg.webp?ect=4g',
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username, // Nama pengguna dari shared_preferences
                      style: GoogleFonts.patrickHand(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 0),
                    Text(
                      email, // Email pengguna dari shared_preferences
                      style: GoogleFonts.patrickHand(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.grey),
                  iconSize: 24.0,
                  onPressed: () {
                    // Handler untuk tombol pengaturan
                  },
                ),
              ],
            ),
            const SizedBox(height: 20), // Jarak vertikal
            // Menu Horizontal
            GestureDetector(
              onTap: () {
                // Handler untuk tombol "Buka Toko"
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SecondScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // No transition animation
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Garis border abu-abu
                  borderRadius: BorderRadius.circular(5), // Sudut bulat
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0), // Increase vertical padding
                  child: Row(
                    children: [
                      const Icon(Icons.store,
                          color: Colors.grey, size: 24), // Ikon toko
                      const SizedBox(width: 8), // Jarak horizontal
                      Text(
                        'Mau Jualan? Buka Toko Yuk!', // Teks untuk menu "Buka Toko"
                        style: GoogleFonts.patrickHand(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(), // Ruang pembuat
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 20), // Ikon panah ke kanan
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10), // Jarak vertikal
            // Menu Logout atau Login
            GestureDetector(
              onTap: () {
                // Handler untuk tombol "Logout" atau "Login"
                if (username == 'Pengguna') {
                  // Jika username masih default, artinya belum login
                  Navigator.of(context).pushReplacementNamed('/login');
                } else {
                  // Jika sudah login, lakukan logout
                  _logout();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          username == 'Pengguna' ? Colors.grey : Colors.grey),
                  // Garis border berwarna hijau jika belum login, merah jika sudah login
                  borderRadius: BorderRadius.circular(5), // Sudut bulat
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0), // Increase vertical padding
                  child: Row(
                    children: [
                      Icon(
                        username == 'Pengguna' ? Icons.login : Icons.logout,
                        color:
                            username == 'Pengguna' ? Colors.grey : Colors.grey,
                        size: 24,
                      ), // Ikon login atau logout
                      const SizedBox(width: 8), // Jarak horizontal
                      Text(
                        username == 'Pengguna' ? 'Kamu Belum Masuk Nih, Masuk Dulu Yuk!' : 'Keluar Akun',
                        // Teks untuk menu "Login" atau "Logout"
                        style: GoogleFonts.patrickHand(
                          color:
                              username == 'Pengguna' ? Colors.grey : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(), // Ruang pembuat
                      Icon(Icons.arrow_forward_ios,
                          color: username == 'Pengguna'
                              ? Colors.grey
                              : Colors.grey,
                          size: 20), // Ikon panah ke kanan
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
