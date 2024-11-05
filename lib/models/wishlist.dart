import 'package:wishlist/models/wishlist_item.dart';

class Wishlist {
  num? id;
  String? userDeviceId;
  String? name;
  String? createdAt;
  List<WishlistItem>? itens;

  Wishlist();

  Wishlist.complete({
    required this.id,
    required this.userDeviceId,
    required this.name,
    required this.createdAt,
    required this.itens,
  });

  Wishlist fromJson(Map<String, dynamic> json) {
    return Wishlist.complete(
      id: json['id'],
      userDeviceId: json['userDeviceId'],
      name: json['name'],
      createdAt: json['createdAt'],
      itens:
          !json.containsKey('itens') ? [] : ((json['itens'] as List).map((e) => WishlistItem().fromJson(e)).toList()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userDeviceId': userDeviceId,
      'name': name,
      'createdAt': createdAt,
      if (itens?.isNotEmpty ?? false) 'itens': [],
    };
  }
}
