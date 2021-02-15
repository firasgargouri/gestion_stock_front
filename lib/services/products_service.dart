import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductsService {
  String baseUrl = 'http://192.168.1.4:8000/';
  String allProductsEndPoint = 'product/all/';

  Future<List<dynamic>> getProducts(String access) async {
    String url = "$baseUrl$allProductsEndPoint";

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $access'},
    );
    // print(json.decode(response.body));
    // print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [];
    }
  }
}
