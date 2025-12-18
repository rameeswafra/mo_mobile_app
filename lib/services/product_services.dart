import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductsService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  /// Fetch all products
  static Future<ProductsResponse> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      final url = Uri.parse(_baseUrl);
      print("$url");
      print("$response");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return ProductsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
