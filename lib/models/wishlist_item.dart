import 'dart:convert';

import 'package:wishlist/models/product.dart';

class WishlistItem {
  num? id;
  num? wishlistId;
  Product? product;

  WishlistItem();

  WishlistItem.complete({
    required this.id,
    required this.wishlistId,
    required this.product,
  });

  WishlistItem fromJson(Map<String, dynamic> json) {
    return WishlistItem.complete(
      id: json['id'],
      wishlistId: json['wishlistId'],
      product: Product().fromJson(jsonDecode(json['product'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wishlistId': wishlistId,
      'quantity': 1,
      'product': jsonEncode(product!.toJson()),
    };
  }
}
