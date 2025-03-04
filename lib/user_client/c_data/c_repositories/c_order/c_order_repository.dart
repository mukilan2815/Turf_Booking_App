// lib/user_client/c_data/c_repositories/c_order/c_order_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turf_app/user_client/c_features/user_client/models/c_order_model.dart'; // Correct path
import '../c_authentication/c_authentication_repository.dart'; // Adjust if needed

class ClientOrderRepository {
  final _db = FirebaseFirestore.instance;

  /// Fetch user's orders (excluding cancelled ones)
  Future<List<ClientOrderModel>> clientFetchUserOrders() async {
    try {
      final userId = AuthenticationRepositoryClient.instance.clientAuthUser!.uid;
      final snapshot = await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .where('status', isNotEqualTo: 'cancelled') // Filter out cancelled orders
          .get();
      return snapshot.docs
          .map((doc) => ClientOrderModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw 'Error fetching orders: $e';
    }
  }

  /// Save an order
  Future<void> clientSaveOrder(ClientOrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .doc(order.id)
          .set(order.toJson());
    } catch (e) {
      throw 'Error saving order: $e';
    }
  }

  /// Cancel an order by updating its status
  Future<void> clientCancelOrder(String orderId, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .doc(orderId)
          .update({'status': 'cancelled'});
    } catch (e) {
      throw 'Error cancelling order: $e';
    }
  }
}