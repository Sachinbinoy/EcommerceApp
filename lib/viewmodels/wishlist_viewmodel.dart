import 'package:flutter/material.dart';
import 'package:testapp/models/product_model.dart';
import 'package:testapp/services/wishlist_service.dart';

class WishlistViewModel extends ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();
  List<Product> wishlist = [];

  Future<void> loadWishlist() async {
    wishlist = await _wishlistService.fetchWishlist();
    notifyListeners();
  }

  Future<void> toggleWishlist(int productId) async {
    await loadWishlist();
     notifyListeners();
  }

  bool isInWishlist(int productId) {
    return wishlist.any((product) => product.id == productId);
  }
}
