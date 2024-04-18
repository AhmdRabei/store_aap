import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_test/models/product_model.dart';

class AddProduct {
  Future<ProductModel> addProduct({
    required String title,
    required String price,
    required String desc,
    required String image,
    required String category,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category,
      },
      headers: {
        // 'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonDate = jsonDecode(response.body);
      ProductModel addProduct = ProductModel.fromJson(jsonDate);
      return addProduct;
    } else {
      throw Exception(
          'there is an error with status code ${response.statusCode}');
    }
  }
}
