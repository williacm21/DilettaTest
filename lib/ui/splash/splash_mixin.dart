import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/managers/app_manager.dart';
import 'package:wishlist/managers/products_manager.dart';
import 'package:wishlist/ui/home/home_screen.dart';

mixin SplashMixin {
  late BuildContext contextMixin;

  Future<void> initialLoad(BuildContext context) async {
    contextMixin = context;
    await Future.delayed(const Duration(seconds: 1));
    await Future.wait([
      contextMixin.read<AppManager>().getAllWishlists(),
      contextMixin.read<ProductsManager>().getAllProducts(),
    ]);
    navigate();
  }

  Future<void> navigate() async {
    Navigator.pushNamedAndRemoveUntil(
      contextMixin,
      HomeScreen.tag,
      (_) => false,
    );
  }
}
