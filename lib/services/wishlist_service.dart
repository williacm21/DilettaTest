import 'dart:developer';

import 'package:wishlist/models/_responses/api_response.dart';
import 'package:wishlist/models/wishlist.dart';
import 'package:wishlist/models/wishlist_item.dart';
import 'package:wishlist/services/api/api_service.dart';

class WishlistService {
  static final WishlistService _instance = WishlistService.internal();

  factory WishlistService() => _instance;

  WishlistService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<Wishlist>>> getAllFromDevice(String deviceID) async {
    try {
      Map<String, dynamic> response = await _apiService.request(
        method: ApiMethod.get,
        query: 'wishlist/getAllWishlistFromDevice?deviceID=$deviceID',
      );

      List<Wishlist> list = (response['wishlists'] as List)
          .map(
            (e) => Wishlist().fromJson(e),
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

  Future<ApiResponse<Wishlist>> getWishlist(String id) async {
    try {
      Map<String, dynamic> response = await _apiService.request(
        method: ApiMethod.get,
        query: 'wishlist?id=$id',
      );

      return ApiResponse(
        response: Wishlist().fromJson(response),
      );
    } catch (e) {
      log(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse<bool>> post(Wishlist wishlist) async {
    try {
      Map<String, dynamic> response = await _apiService.request(
        method: ApiMethod.post,
        query: 'wishlist',
        body: wishlist.toJson(),
      );

      return ApiResponse(
        response: true,
      );
    } catch (e) {
      log(e.toString());
      return ApiResponse(
        response: false,
        errorMessage: 'Ocorreu um erro inesperado',
      );
    }
  }

  Future<ApiResponse<bool>> postItem(WishlistItem item) async {
    try {
      Map<String, dynamic> response = await _apiService.request(
        method: ApiMethod.post,
        query: 'wishlistItem',
        body: item.toJson(),
      );

      return ApiResponse(
        response: true,
      );
    } catch (e) {
      log(e.toString());
      return ApiResponse(
        response: false,
        errorMessage: 'Ocorreu um erro inesperado',
      );
    }
  }

  Future<ApiResponse<bool>> putItem(WishlistItem item) async {
    try {
      Map<String, dynamic> response = await _apiService.request(
        method: ApiMethod.put,
        query: 'wishlistItem',
        body: item.toJson(),
      );

      return ApiResponse(
        response: true,
      );
    } catch (e) {
      log(e.toString());
      return ApiResponse(
        response: false,
        errorMessage: 'Ocorreu um erro inesperado',
      );
    }
  }

  Future<ApiResponse<bool>> deleteItem(WishlistItem item) async {
    try {
      Map<String, dynamic> response = await _apiService.request(
        method: ApiMethod.delete,
        query: 'wishlistItem?id=${item.id}',
        body: item.toJson(),
      );

      return ApiResponse(
        response: true,
      );
    } catch (e) {
      log(e.toString());
      return ApiResponse(
        response: false,
        errorMessage: 'Ocorreu um erro inesperado',
      );
    }
  }
}
