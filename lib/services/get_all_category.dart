import 'dart:convert';
import 'package:http/http.dart' as http;

class GetAllCategory {
  Future<dynamic> getAllCategory() async {
    http.Response response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception(
          'there is an error with status code ${response.statusCode}');
    }
  }
}
