import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_test/models/product_model.dart';

class GetAllProducts {
  Future<List<ProductModel>> getAllProducts() async {
    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      List<ProductModel> productsList = [];
      for (int i = 0; i < jsonData.length; i++) {
        productsList.add(
          ProductModel.fromJson(jsonData[i]),
        );
      }
      return productsList;
    } else {
      throw Exception(
          'there is an error with status code ${response.statusCode}');
    }
  }
}
