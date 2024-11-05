import 'package:flutter/material.dart';
import 'package:wishlist/ui/products/components/product_card.dart';
import 'package:wishlist/ui/products/products_mixin.dart';

class ProductsScreen extends StatefulWidget {
  static const String tag = '/products';

  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with ProductsMixin {
  @override
  void initState() {
    initialLoad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (_, index) => ProductCard(
          product: products[index],
          onTap: () => goToProductScreen(products[index]),
        ),
      ),
    );
  }
}
