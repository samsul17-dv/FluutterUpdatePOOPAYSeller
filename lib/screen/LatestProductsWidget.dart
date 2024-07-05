import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ProductCard.dart'; // Pastikan path-nya benar
import 'package:google_fonts/google_fonts.dart';

class LatestProductsWidget extends StatefulWidget {
  @override
  _LatestProductsWidgetState createState() => _LatestProductsWidgetState();
}

class _LatestProductsWidgetState extends State<LatestProductsWidget> {
  List<Product> products = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        'https://samsulmuarif.my.id/server/poopay/get_products.php'; // Ganti dengan endpoint API PHP Anda
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          products = (jsonData['products'] as List)
              .map((data) => Product.fromJson(data))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Gagal memuat produk';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Produk Terbaru',
            style: GoogleFonts.patrickHand(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : products.isEmpty
                ? Center(child: Text('Tidak ada produk yang tersedia'))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      String imageUrl =
                          'https://samsulmuarif.my.id/server/poopay/get_products.php/${product.imageUrl}';
                      return ProductCard(
                        productName: product.productName,
                        price: product.price,
                        storeName: product.storeName,
                        imageUrl: imageUrl,
                      );
                    },
                  ),
      ],
    );
  }
}

class Product {
  final String productName;
  final String price;
  final String storeName;
  final String imageUrl;

  Product({
    required this.productName,
    required this.price,
    required this.storeName,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'],
      price: json['price'],
      storeName: json['storeName'],
      imageUrl: 'https://samsulmuarif.my.id/server/poopay/${json['imageUrl']}',
    );
  }
}
