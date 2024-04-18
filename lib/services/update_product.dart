import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_test/models/product_model.dart';

class UpdateProduct {
  Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String price,
    required String desc,
    required String image,
    required String category,
  }) async {
    http.Response response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category,
      },
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      ProductModel product = ProductModel.fromJson(jsonData);
      return product;
    } else {
      throw Exception(
          'there is an error in status code ${response.statusCode}');
    }
  }
}
