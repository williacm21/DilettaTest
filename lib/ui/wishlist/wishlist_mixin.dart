import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/managers/wishlist_manager.dart';
import 'package:wishlist/models/_responses/manager_response.dart';
import 'package:wishlist/models/wishlist.dart';
import 'package:wishlist/models/wishlist_item.dart';
import 'package:wishlist/ui/products/products_screen.dart';
import 'package:wishlist/widgets/loader.dart';
import 'package:wishlist/widgets/snackbar_helper.dart';

mixin WishlistMixin {
  late BuildContext contextMixin;

  Wishlist get wishlist => contextMixin.read<WishlistManager>().wishlist!;

  Future<void> initialLoad(BuildContext context) async {
    contextMixin = context;
  }

  goToProductsScreen() {
    Navigator.pushNamed(
      contextMixin,
      ProductsScreen.tag,
    );
  }

  Future<bool> removeProduct(WishlistItem item) async {
    openLoader(contextMixin);
    ManagerResponse<bool> response = await contextMixin.read<WishlistManager>().deleteItem(item: item);

    Navigator.pop(contextMixin);
    if (response.hasError || !response.response!) {
      Navigator.pop(contextMixin);
      showInSnackBar(
        context: contextMixin,
        type: SnackBarType.error,
        text: response.errorMessage ?? 'Ocorreu um erro inesperado',
      );
      return false;
    }

    showInSnackBar(
      context: contextMixin,
      type: SnackBarType.success,
      text: 'Item removido!',
    );
    return true;
  }
}
