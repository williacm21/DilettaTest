import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/managers/app_manager.dart';
import 'package:wishlist/managers/wishlist_manager.dart';
import 'package:wishlist/models/_responses/manager_response.dart';
import 'package:wishlist/models/wishlist.dart';
import 'package:wishlist/ui/wishlist/wishlist_screen.dart';
import 'package:wishlist/widgets/get_text_dialog.dart';
import 'package:wishlist/widgets/loader.dart';
import 'package:wishlist/widgets/snackbar_helper.dart';

mixin HomeMixin {
  late BuildContext contextMixin;

  List<Wishlist> get wishlists => contextMixin.read<AppManager>().wishlists;

  Future<void> initialLoad(BuildContext context) async {
    contextMixin = context;
  }

  goToWishlistScreen(Wishlist wishlist) async {
    openLoader(contextMixin);
    ManagerResponse<bool> response = await contextMixin.read<WishlistManager>().setWishlist(wishlist);
    Navigator.pop(contextMixin);
    if (response.hasError || !response.response!) {
      showInSnackBar(
        context: contextMixin,
        type: SnackBarType.error,
        text: response.errorMessage ?? 'Ocorreu um erro inesperado',
      );
      return;
    }

    Navigator.pushNamed(
      contextMixin,
      WishlistScreen.tag,
    );
  }

  addNewWishlist() {
    showDialog(
        context: contextMixin,
        builder: (context) => GetTextDialog<String>(
              title: 'Nova Wishlist',
              hintText: 'Informe o nome da sua lista',
              confirmAction: 'Criar',
              onConfirm: (String text) {
                Navigator.pop(context);
                _addNewWishlistAction(text);
              },
            ));
  }

  _addNewWishlistAction(String name) async {
    openLoader(contextMixin);
    ManagerResponse<bool> response = await contextMixin.read<AppManager>().postWishlist(name: name);

    if (response.hasError || !response.response!) {
      Navigator.pop(contextMixin);
      showInSnackBar(
        context: contextMixin,
        type: SnackBarType.error,
        text: response.errorMessage ?? 'Ocorreu um erro inesperado',
      );
      return;
    }

    await contextMixin.read<AppManager>().getAllWishlists();
    Navigator.pop(contextMixin);
    showInSnackBar(
      context: contextMixin,
      type: SnackBarType.success,
      text: 'Wishlist criada com sucesso',
    );
  }
}
