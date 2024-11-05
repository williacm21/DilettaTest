import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/common/extensions/num_extension.dart';
import 'package:wishlist/models/product.dart';
import 'package:wishlist/ui/product/product_mixin.dart';

class ProductScreen extends StatefulWidget {
  static const String tag = '/product';

  const ProductScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with ProductMixin {
  @override
  void initState() {
    product = widget.product;
    initialLoad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: (product.images ?? []).length > 1 ? true : false,
                      ),
                      items: (product.images ?? [])
                          .map(
                            (item) => Container(
                              height: 300,
                              color: Colors.transparent,
                              child: Image.network(
                                item,
                                width: 300,
                                height: 300,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Text(
                    product.title ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$${product.price?.formatterToPtBr() ?? ''}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
                valueListenable: quantity,
                builder: (_, __, ___) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => addToWishList(),
                          child: Text(
                            'Adicionar a Lista ($productValue)',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // IconButton(
                      //   onPressed: quantity.value == 1
                      //       ? null
                      //       : () {
                      //           quantity.value--;
                      //         },
                      //   icon: const Icon(Icons.remove),
                      // ),
                      // Text(
                      //   quantity.value.toString(),
                      //   style: const TextStyle(
                      //     fontSize: 22,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // IconButton(
                      //   onPressed: () {
                      //     quantity.value++;
                      //   },
                      //   icon: const Icon(Icons.add),
                      // ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
