import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/models/_responses/api_response.dart';
import 'package:wishlist/models/product.dart';
import 'package:wishlist/services/product_service.dart';

class ProductsManager extends ChangeNotifier {
  final _productService = ProductService();
  List<Product> products = [];

  Future<void> getAllProducts() async {
    ApiResponse<List<Product>> aux = await _productService.getAll();

    if (!aux.isValid) {
      return;
    }

    products = aux.response!;
    notifyListeners();
  }
}
