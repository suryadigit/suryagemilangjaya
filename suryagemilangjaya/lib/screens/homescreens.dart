import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product_model.dart';
import '../widgets/product_widget.dart';
import '../widgets/searchbar_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> products = [];
  final Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    loadProducts();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _backgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  Future<void> loadProducts() async {
    final String jsonString =
        await rootBundle.loadString('assets/product.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);

    setState(() {
      products =
          jsonResponse.map((data) => ProductModel.fromJson(data)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 5, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBars(hintText: ''),
            const SizedBox(height: 20),
            Expanded(
              child: ProductPage(
                 
              ),
            ),
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
    );
  }
}
