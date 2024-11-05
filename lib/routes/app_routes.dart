import 'package:flutter/material.dart';
import 'package:wishlist/models/product.dart';
import 'package:wishlist/ui/product/product_screen.dart';
import 'package:wishlist/ui/products/products_screen.dart';
import 'package:wishlist/ui/splash/splash_screen.dart';
import 'package:wishlist/ui/home/home_screen.dart';
import 'package:wishlist/ui/wishlist/wishlist_screen.dart';

class AppRoutes {
  static Widget _getScreen(BuildContext context, RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.tag:
        return const HomeScreen();
      case WishlistScreen.tag:
        return const WishlistScreen();
      case ProductsScreen.tag:
        return const ProductsScreen();
      case ProductScreen.tag:
        return ProductScreen(
          product: settings.arguments as Product,
        );
      default:
        return const SplashScreen();
    }
  }

  static Route generateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => _getScreen(context, settings),
      settings: settings,
    );
  }
}
