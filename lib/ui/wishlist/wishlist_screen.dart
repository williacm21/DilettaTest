import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/managers/wishlist_manager.dart';
import 'package:wishlist/ui/wishlist/components/wishlist_item_card.dart';
import 'package:wishlist/ui/wishlist/wishlist_mixin.dart';
import 'package:wishlist/widgets/empty_message.dart';

class WishlistScreen extends StatefulWidget {
  static const String tag = '/wishlist';

  const WishlistScreen({
    super.key,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> with WishlistMixin {
  @override
  void initState() {
    initialLoad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WishList ${wishlist.name}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToProductsScreen(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<WishlistManager>(builder: (_, __, ___) {
        return (wishlist.itens?.isEmpty ?? true)
            ? const EmptyMessage(
                image: 'assets/images/empty_product.jpg',
                text: 'Sua Wishlist esta vázia!'
                    '\nAdicione seu primeiro produto'
                    ' clicando no botão \'+\' no menu inferior',
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: wishlist.itens?.length ?? 0,
                itemBuilder: (_, index) => WishlistItemCard(
                  wishlistItem: wishlist.itens![index],
                  onTap: null,
                  onDelete: () async {
                    Navigator.of(context).pop(await removeProduct(wishlist.itens![index]));
                  },
                ),
              );
      }),
    );
  }
}
