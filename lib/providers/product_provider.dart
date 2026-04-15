import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => _products;

  List<Product> get featuredProducts =>
      _products.where((p) => p.featured).toList();

  Product getById(String id) =>
      _products.firstWhere((product) => product.id == id);
}