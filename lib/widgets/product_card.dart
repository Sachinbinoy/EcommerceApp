import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constant/colors.dart';
import 'package:testapp/models/product_model.dart';
import 'package:testapp/providers/wishlist_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, _) {
        wishlistProvider.isInWishlist(product.id);
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 250, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        product.featuredImage ??
                            "https://admin.kushinirestaurant.com/media/images/products/additional_image/pieces-raw-fresh-meat-isolated-black-stone-board-compressed.jpg",
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            color: Colors.grey[200],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: IconButton(
                          icon: Icon(
                            wishlistProvider.isInWishlist(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: wishlistProvider.isInWishlist(product.id)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () async {
                            final bool existing = wishlistProvider
                                .isInWishlist(product.id);
                            await wishlistProvider.toggleWishlist(
                              product.id,
                              product, existing
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (product.salePrice != null)
                                Text(
                                  '₹${product.mrp}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              const SizedBox(width: 3),
                              Text(
                                '₹${product.salePrice}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${product.avgRating}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${product.name}",
                        style: const TextStyle(
                          fontFamily: "Heebo",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


