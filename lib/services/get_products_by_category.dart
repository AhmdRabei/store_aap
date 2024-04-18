import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_test/models/product_model.dart';

class GetProductsByCategory {
  Future<List<ProductModel>> getProductsByCategory(
      {required String categoryName}) async {
    http.Response response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/category/$categoryName'));

    if (response.statusCode == 200) {
      List<dynamic> jsonDate = jsonDecode(response.body);

      List<ProductModel> productsList = [];
      for (int i = 0; i < jsonDate.length; i++) {
        productsList.add(ProductModel.fromJson(jsonDate[i]));
      }
      return productsList;
    } else {
      throw Exception(
          'there is an error with status code ${response.statusCode}');
    }
  }
}
