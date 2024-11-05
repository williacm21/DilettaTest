import 'package:flutter/material.dart';
import 'package:wishlist/common/extensions/num_extension.dart';
import 'package:wishlist/models/wishlist_item.dart';

class WishlistItemCard extends StatelessWidget {
  const WishlistItemCard({
    super.key,
    required this.wishlistItem,
    required this.onTap,
    required this.onDelete,
  });

  final WishlistItem wishlistItem;
  final VoidCallback? onTap;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Each Dismissible must contain a Key. Keys allow Flutter to
      // uniquely identify widgets.
      key: Key(wishlistItem.id!.toString()),

      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmar"),
              content: const Text("Você tem certeza que deseja deletar esse item?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    return await onDelete.call();
                  },
                  child: const Text("Deletar"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancelar"),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        title: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Image.network(
                  wishlistItem.product!.thumbnail!,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wishlistItem.product!.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        wishlistItem.product!.description ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'R\$${wishlistItem.product!.price?.formatterToPtBr() ?? ''}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
