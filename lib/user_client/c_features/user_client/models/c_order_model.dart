// lib/user_client/c_features/user_client/models/c_order_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turf_app/user_client/c_features/user_client/models/c_product_model.dart';

class ClientOrderModel {
  final String id;
  final String userId;
  final double totalAmount;
  final String orderDate;
  final String paymentMethod;
  final ClientProductModel? items;
  final String? status;

  ClientOrderModel({
    required this.id,
    this.userId = "",
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.status = 'confirmed',
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'userId': userId,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'items': items?.toJson(),
      'status': status,
    };
  }

  factory ClientOrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ClientOrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      totalAmount: data['totalAmount'] as double,
      orderDate: data['orderDate'] as String,
      paymentMethod: data['paymentMethod'] as String,
      items: ClientProductModel.fromMap(data['items'] as Map<String, dynamic>),
      status: data['status'] as String?,
    );
  }
}