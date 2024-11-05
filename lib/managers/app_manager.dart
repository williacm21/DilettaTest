import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/core/configs.dart';
import 'package:wishlist/models/_responses/api_response.dart';
import 'package:wishlist/models/_responses/manager_response.dart';
import 'package:wishlist/models/wishlist.dart';
import 'package:wishlist/services/wishlist_service.dart';

class AppManager extends ChangeNotifier {
  final _wishlistService = WishlistService();
  List<Wishlist> wishlists = [];

  Future<void> getAllWishlists() async {
    ApiResponse<List<Wishlist>> aux = await _wishlistService.getAllFromDevice(Configs.deviceID);

    if (!aux.isValid) {
      return;
    }

    wishlists = aux.response!;
    notifyListeners();
  }

  Future<ManagerResponse<bool>> postWishlist({
    required String name,
  }) async {
    Wishlist item = Wishlist.complete(
      id: 0,
      userDeviceId: Configs.deviceID,
      name: name,
      createdAt: DateTime.now().toIso8601String(),
      itens: [],
    );
    ApiResponse<bool> aux = await _wishlistService.post(item);

    if (!aux.isValid) {
      return ManagerResponse(
        response: false,
        errorMessage: aux.errorMessage,
      );
    }

    notifyListeners();
    return ManagerResponse(
      response: true,
      errorMessage: aux.errorMessage,
    );
  }
}
