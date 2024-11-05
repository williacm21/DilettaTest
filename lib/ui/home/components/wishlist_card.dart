import 'package:flutter/material.dart';
import 'package:wishlist/models/wishlist.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
    required this.wishlist,
    required this.onTap,
  });

  final Wishlist wishlist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  wishlist.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}
