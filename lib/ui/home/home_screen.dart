import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/managers/app_manager.dart';
import 'package:wishlist/ui/home/components/wishlist_card.dart';
import 'package:wishlist/ui/home/home_mixin.dart';
import 'package:wishlist/widgets/empty_message.dart';

class HomeScreen extends StatefulWidget {
  static const String tag = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeMixin {
  @override
  void initState() {
    initialLoad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Diletta Wishlist - Flutter Test'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewWishlist(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<AppManager>(
        builder: (_, __, ___) {
          return (wishlists.isEmpty)
              ? const EmptyMessage(
                  image: 'assets/images/empty_list.jpg',
                  text: 'Você não possui nenhuma Wishlist!'
                      '\nAdicione sua primeira lista'
                      ' clicando no botão \'+\' no menu inferior',
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: wishlists.length,
                  itemBuilder: (_, index) => WishlistCard(
                    wishlist: wishlists[index],
                    onTap: () => goToWishlistScreen(wishlists[index]),
                  ),
                );
        },
      ),
    );
  }
}
