import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constant/colors.dart';
import '../providers/wishlist_provider.dart';
import '../viewmodels/product_viewmodel.dart';
import '../models/product_model.dart';

class ProductGrid extends StatefulWidget {
  final bool isListView;

  const ProductGrid({super.key, this.isListView = false});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  void initState() {
    super.initState();
    // Fetch products and wishlist when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
      context.read<WishlistProvider>().fetchWishlist(); // Fetch wishlist
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, productViewModel, child) {
        if (productViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productViewModel.error != null) {
          return Center(child: Text('Error: ${productViewModel.error}'));
        }

        final products = productViewModel.products;

        if (products.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        return widget.isListView
            ? ListView.builder(
              itemCount: products.length,
              itemBuilder:
                  (context, index) => ProductCard(product: products[index]),
            )
            : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder:
                  (context, index) => ProductCard(product: products[index]),
            );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, _) {
        wishlistProvider.isInWishlist(product.id);
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                              icon: 
                               Image.asset(
    wishlistProvider.isInWishlist(product.id)
        ? 'assets/icons/Fill.png'
        : 'assets/icons/Empty.png',
    width: 24,  // Adjust the size as needed
    height: 24,
  ),
                              // Icon(
                              //   wishlistProvider.isInWishlist(product.id)
                              //       ? Icons.favorite
                              //       : Icons.favorite_border,
                              //   color:
                              //       wishlistProvider.isInWishlist(product.id)
                              //           ? Colors.red
                              //           : Colors.grey,
                              // ),

                              onPressed: () async {
                                final bool existing = wishlistProvider
                                    .isInWishlist(product.id);
                                await wishlistProvider.toggleWishlist(
                                  product.id,
                                  product,
                                  existing,
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
            ],
          ),
        );
      },
    );
  }
}
