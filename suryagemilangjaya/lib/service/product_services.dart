// lib/services/product_service.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:suryagemilangjaya/models/product_model.dart';

Future<List<ProductModel>> loadProducts() async {
  final jsonString = await rootBundle.loadString('assets/product.json');
  final List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((json) => ProductModel.fromJson(json)).toList();
}
