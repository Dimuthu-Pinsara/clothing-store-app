import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('products').get();

      _products.clear();
      for (var doc in snapshot.docs) {
        _products.add(Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Product getById(String id) {
    return _products.firstWhere(
      (prod) => prod.id == id,
      // Optional safety fallback if a product is ever missing
      orElse: () => throw Exception('Product with id $id not found'),
    );
  }

  List<Product> getProductsByCategory(String categoryName) {
    if (categoryName == 'All') return _products;
    return _products.where((p) => p.category == categoryName).toList();
  }
}