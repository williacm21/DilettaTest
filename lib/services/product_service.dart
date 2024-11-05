import 'dart:developer';

import 'package:wishlist/models/_responses/api_response.dart';
import 'package:wishlist/models/product.dart';
import 'package:wishlist/services/api/api_service.dart';

class ProductService {
  static final ProductService _instance = ProductService.internal();

  factory ProductService() => _instance;

  ProductService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<Product>>> getAll() async {
    try {
      Map<String, dynamic> response = await _apiService.request(
        method: ApiMethod.get,
        api: Api.products,
        query: 'products?limit=60',
      );

      List<Product> list = (response['products'] as List)
          .map(
            (e) => Product().fromJson(e),
          )
          .toList();

      return ApiResponse(
        response: list,
      );
    } catch (e) {
      log(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
