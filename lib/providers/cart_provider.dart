import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  CartProvider() {
    _loadCart();
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }

    notifyListeners();
    _saveCart();
  }

  // void increaseQty(String productId) {
  //   final item = _items.firstWhere((item) => item.product.id == productId);
  //   item.quantity++;
  //   notifyListeners();
  // }

  // void decreaseQty(String productId) {
  //   final item = _items.firstWhere((item) => item.product.id == productId);
  //   if (item.quantity > 1) {
  //     item.quantity--;
  //   } else {
  //     _items.removeWhere((item) => item.product.id == productId);
  //   }
  //   notifyListeners();
  // }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
    } else {
      _items.remove(productId);
    }

    notifyListeners();
    _saveCart();
  }

  void completelyRemoveItem(String productId) {
    _items.remove(productId);
    notifyListeners();
    _saveCart();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCart();
  }

  Future<void> _saveCart() async {
    final preferences = await SharedPreferences.getInstance();
    final String cartJson = json.encode(
      _items.map((key, item) => MapEntry(key, item.toJson())),
    );
    await preferences.setString('cart', cartJson);
  }

  Future<void> _loadCart() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('cartData')) return;

    final String? cartJson = preferences.getString('cartData');
    if (cartJson == null) return;

    final Map<String, dynamic> decodedData = json.decode(cartJson);
    _items = decodedData.map(
      (key, itemData) => MapEntry(key, CartItem.fromJson(itemData)),
    );
    notifyListeners();
  }
}
