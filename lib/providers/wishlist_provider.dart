import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistProvider extends ChangeNotifier {
  Set<int> _wishlistIds = {};

  WishlistProvider() {
    loadWishlist(); // Load wishlist from storage on app start
  }

  // Check if a product is in wishlist
  bool isFavorite(int productId) {
    return _wishlistIds.contains(productId);
  }

  // Toggle wishlist
  void toggleWishlist(int productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    saveWishlist(); // Save changes to device
    notifyListeners(); // Update UI
  }

  // Get all wishlist IDs
  List<int> get wishlistIds => _wishlistIds.toList();

  // Load wishlist from SharedPreferences
  Future<void> loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('wishlist') ?? [];
    _wishlistIds = savedList.map((e) => int.parse(e)).toSet();
    notifyListeners();
  }

  // Save wishlist to SharedPreferences
  Future<void> saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'wishlist',
      _wishlistIds.map((e) => e.toString()).toList(),
    );
  }
}
