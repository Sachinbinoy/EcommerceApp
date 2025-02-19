// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:testapp/models/product_model.dart';
// import 'package:testapp/providers/wishlist_provider.dart';
// import 'package:testapp/widgets/product_card.dart';

// class WishlistScreen extends StatelessWidget {
//   const WishlistScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Wishlist")),
//       body: Consumer<WishlistProvider>(
//         builder: (context, wishlistProvider, _) {
//           final List<Product> wishlistProducts =
//               wishlistProvider.wishlistProducts;
//           const Text("My Wishlist");
//           if (wishlistProducts.isEmpty) {
//             return const Center(
//               child: Text(
//                 "Your wishlist is empty",
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GridView.builder(
//               itemCount: wishlistProducts.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//                 childAspectRatio: 0.75,
//               ),
//               itemBuilder: (context, index) {
//                 return ProductCard(product: wishlistProducts[index]);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/models/product_model.dart';
import 'package:testapp/providers/wishlist_provider.dart';
import 'package:testapp/widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("My Wishlist")),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, _) {
          final List<Product> wishlistProducts =
              wishlistProvider.wishlistProducts;

          if (wishlistProducts.isEmpty) {
            return const Center(
              child: Text(
                "Your wishlist is empty",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 26, left: 4, bottom: 16),
                  child: Text(
                    "Wishlist",
                    style: TextStyle(
                      fontFamily: "Heebo",
                      fontSize: 18, 
                      fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: wishlistProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: wishlistProducts[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
