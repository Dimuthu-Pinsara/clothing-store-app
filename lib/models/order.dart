import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item.dart';

class CustomerOrder {
  final String id;
  final String userId;
  final double totalAmount;
  final List<CartItem> items;
  final String deliveryAddress;
  final String phone;
  final DateTime dateTime;
  final String status;

  CustomerOrder({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.items,
    required this.deliveryAddress,
    required this.phone,
    required this.dateTime,
    this.status = 'Pending',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'totalAmount': totalAmount,
    'items': items.map((item) => item.toJson()).toList(),
    'deliveryAddress': deliveryAddress,
    'phone': phone,
    'dateTime': dateTime.toIso8601String(),
    'status': status,
  };

  factory CustomerOrder.fromFirestore(Map<String, dynamic> data, String documentId) {
    return CustomerOrder(
      id: documentId,
      userId: data['userId'] ?? '',
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
      items:
          (data['items'] as List<dynamic>?)
              ?.map((item) => CartItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      deliveryAddress: data['deliveryAddress'] ?? '',
      phone: data['phone'] ?? '',
      dateTime: DateTime.parse(
        data['dateTime'] ?? DateTime.now().toIso8601String(),
      ),
      status: data['status'] ?? 'Pending',
    );
  }
}
