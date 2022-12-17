import 'dart:convert';

import 'package:flutter_application_provider/product_model.dart';
import 'package:http/http.dart';

class API {
  String endponit = 'https://dummyjson.com/products';
  Future<List<Products>> getProduct() async {
    Response response = await get(Uri.parse(endponit));
    if (response.statusCode == 200) {
      final List listProduct = jsonDecode(response.body)['products'];
      return listProduct.map((e) => Products.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
