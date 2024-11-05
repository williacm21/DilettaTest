import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/common/extensions/num_extension.dart';
import 'package:wishlist/managers/wishlist_manager.dart';
import 'package:wishlist/models/_responses/manager_response.dart';
import 'package:wishlist/models/product.dart';
import 'package:wishlist/widgets/loader.dart';
import 'package:wishlist/widgets/snackbar_helper.dart';

mixin ProductMixin {
  late BuildContext contextMixin;
  late Product product;

  ValueNotifier<int> quantity = ValueNotifier(1);

  String get productValue {
    num value = product.price == null ? 0 : (product.price! * quantity.value);
    return "R\$${value.formatterToPtBr()}";
  }

  Future<void> initialLoad(BuildContext context) async {
    contextMixin = context;
  }

  Future<void> addToWishList() async {
    openLoader(contextMixin);
    ManagerResponse<bool> response = await contextMixin.read<WishlistManager>().addItem(
          product: product,
        );
    Navigator.pop(contextMixin);
    if (response.hasError || !response.response!) {
      showInSnackBar(
        context: contextMixin,
        type: SnackBarType.error,
        text: response.errorMessage ?? 'Ocorreu um erro inesperado',
      );
      return;
    }

    Navigator.pop(contextMixin);
    showInSnackBar(
      context: contextMixin,
      type: SnackBarType.success,
      text: 'Produto adicionado!',
    );
  }
}
