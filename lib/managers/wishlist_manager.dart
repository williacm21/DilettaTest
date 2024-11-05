import 'package:flutter/foundation.dart';
import 'package:wishlist/models/_responses/api_response.dart';
import 'package:wishlist/models/_responses/manager_response.dart';
import 'package:wishlist/models/product.dart';
import 'package:wishlist/models/wishlist.dart';
import 'package:wishlist/models/wishlist_item.dart';
import 'package:wishlist/services/wishlist_service.dart';

class WishlistManager extends ChangeNotifier {
  final _wishlistService = WishlistService();
  Wishlist? wishlist;

  Future<ManagerResponse<bool>> setWishlist(Wishlist wishlist) async {
    ApiResponse<Wishlist> aux = await _wishlistService.getWishlist(wishlist.id.toString());

    if (!aux.isValid) {
      return ManagerResponse(
        response: false,
        errorMessage: aux.errorMessage,
      );
    }

    this.wishlist = aux.response!;
    notifyListeners();
    return ManagerResponse(
      response: true,
      errorMessage: aux.errorMessage,
    );
  }

  Future<ManagerResponse<bool>> addItem({
    required Product product,
  }) async {
    WishlistItem item = WishlistItem.complete(
      id: 0,
      wishlistId: wishlist!.id!,
      product: product,
    );
    ApiResponse<bool> aux = await _wishlistService.postItem(item);

    if (!aux.isValid) {
      return ManagerResponse(
        response: false,
        errorMessage: aux.errorMessage,
      );
    }
    setWishlist(wishlist!);

    notifyListeners();
    return ManagerResponse(
      response: true,
      errorMessage: aux.errorMessage,
    );
  }

  Future<ManagerResponse<bool>> deleteItem({
    required WishlistItem item,
  }) async {
    ApiResponse<bool> aux = await _wishlistService.deleteItem(item);

    if (!aux.isValid) {
      return ManagerResponse(
        response: false,
        errorMessage: aux.errorMessage,
      );
    }
    setWishlist(wishlist!);

    notifyListeners();
    return ManagerResponse(
      response: true,
      errorMessage: aux.errorMessage,
    );
  }
}
