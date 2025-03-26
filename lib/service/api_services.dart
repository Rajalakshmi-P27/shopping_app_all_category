import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_h/models/product_models.dart';

class ApiService {
  static const String apiUrl = "https://dummyjson.com/products";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Product> products =
          (data['products'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
      return products;
    } else {
      throw Exception("Failed to load products");
    }
  }
}
