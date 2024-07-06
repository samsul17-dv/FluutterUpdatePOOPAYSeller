import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AccountWidget.dart'; // Import your account widget file
import 'BannerSliderWidget.dart';
import 'MenuWidget.dart';
import 'LatestProductsWidget.dart';

class Homescreen extends StatefulWidget {
  final List<String> imgList = const [
    'https://samsulmuarif.my.id/server/banner/banner_01.png',
    'https://samsulmuarif.my.id/server/banner/banner_02.png',
    'https://samsulmuarif.my.id/server/banner/banner_03.png',
  ];

  final List<String> menuImgList = const [
    'https://samsulmuarif.my.id/server/menu/menu_01.png',
    'https://samsulmuarif.my.id/server/menu/menu_02.png',
    'https://samsulmuarif.my.id/server/menu/menu_03.jpeg',
    'https://samsulmuarif.my.id/server/menu/menu_04.jpeg',
  ];

  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _selectedIndex = 0;
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        if (_pageController.page?.round() == widget.imgList.length - 1) {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
        }
      }
    });
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // Jika user memilih item yang sedang aktif, tidak lakukan apa-apa
      return;
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget _getAppBar() {
    switch (_selectedIndex) {
      case 0:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari di POOPAY',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mail_outline, color: Colors.grey),
                    iconSize: 24.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.grey),
                    iconSize: 24.0,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      case 1:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari di Official Store',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mail_outline, color: Colors.grey),
                    iconSize: 24.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.grey),
                    iconSize: 24.0,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      case 2:
        return AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari Transaksi Kamu',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mail_outline, color: Colors.grey),
                    iconSize: 24.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.grey),
                    iconSize: 24.0,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      case 3:
        return AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Account Page"),
        );
      default:
        return AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Home Page"),
        );
    }
  }

  Widget _getBodyContent() {
    switch (_selectedIndex) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              BannerSliderWidget(
                imgList: widget.imgList,
                pageController: _pageController,
              ),
              const SizedBox(height: 10),
              MenuWidget(
                menuImgList: widget.menuImgList,
              ),
              const SizedBox(height: 10),
              const LatestProductsWidget(),
            ],
          ),
        );
      case 1:
        return const Center(child: Text("Official Page"));
      case 2:
        return const Center(child: Text("Transactions Page"));
      case 3:
        return const AccountWidget(); // Use AccountWidget here
      default:
        return const Center(child: Text("Home Page"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        if (_selectedIndex != 0) {
          // Jika bukan dari Beranda, kembali ke Beranda
          setState(() {
            _selectedIndex = 0;
          });
          return false; // Prevent exiting
        } else {
          DateTime now = DateTime.now();
          if (_lastBackPressed == null ||
              now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
            // Set last back pressed time
            _lastBackPressed = now;
            return false; // Prevent exiting
          }
          // Langsung tutup aplikasi
          SystemNavigator.pop();
          return true; // Allow exiting
        }
      },
      child: Scaffold(
        appBar: _getAppBar(),
        body: _getBodyContent(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Toko',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Akun',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
