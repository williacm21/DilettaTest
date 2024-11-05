import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/managers/products_manager.dart';
import 'package:wishlist/models/product.dart';
import 'package:wishlist/ui/product/product_screen.dart';

mixin ProductsMixin {
  late BuildContext contextMixin;

  List<Product> get products => contextMixin.read<ProductsManager>().products;

  Future<void> initialLoad(BuildContext context) async {
    contextMixin = context;
  }

  goToProductScreen(Product product) {
    Navigator.pushNamed(
      contextMixin,
      ProductScreen.tag,
      arguments: product,
    );
  }
}
