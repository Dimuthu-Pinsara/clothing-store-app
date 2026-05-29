import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order.dart';
import '../models/cart_item.dart';

class OrderProvider with ChangeNotifier {
  List<CustomerOrder> _orders = [];
  bool _isLoading = false;

  List<CustomerOrder> get orders => _orders;
  bool get isLoading => _isLoading;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> placeOrder({
    required String userId,
    required double totalAmount,
    required List<CartItem> cartItems,
    required String deliveryAddress,
    required String phone,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newDocRef = _firestore.collection('orders').doc();

      final newOrder = CustomerOrder(
        id: newDocRef.id, 
        userId: userId,
        totalAmount: totalAmount,
        items: cartItems,
        deliveryAddress: deliveryAddress,
        phone: phone,
        dateTime: DateTime.now(),
      );

      await newDocRef.set(newOrder.toJson());
      
      _isLoading = false;
      notifyListeners();
      return null; 
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  Future<void> fetchUserOrders(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('dateTime', descending: true)
          .get();

      _orders = snapshot.docs.map((doc) {
        return CustomerOrder.fromFirestore(doc.data(), doc.id);
      }).toList();
      
    } catch (e) {
      print("Error fetching orders: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}