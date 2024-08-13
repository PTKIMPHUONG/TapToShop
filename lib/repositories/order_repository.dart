import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:test_app/models/order.dart' as my_models;
import '../models/user_shipment_details.dart';

class OrderRepository {
  final firestore.FirebaseFirestore _firestore = firestore.FirebaseFirestore.instance;

  Future<void> createOrder(my_models.Order order) async {
    try {
      await _firestore.collection('orders').doc(order.orderId).set(order.toJson());
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<my_models.Order?> getOrder(String orderId) async {
    try {
      final doc = await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return my_models.Order.fromJson(doc.data()! as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  Future<void> updateOrder(my_models.Order order) async {
    try {
      await _firestore.collection('orders').doc(order.orderId).update(order.toJson());
    } catch (e) {
      throw Exception('Failed to update order: $e');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
    } catch (e) {
      throw Exception('Failed to delete order: $e');
    }
  }

  Future<List<my_models.Order>> getOrders() async {
    try {
      final querySnapshot = await _firestore.collection('orders').get();
      return querySnapshot.docs.map((doc) => my_models.Order.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  Future<UserShipmentDetails> getUserShipmentDetails(String userId) async {
    try {
      final doc = await _firestore.collection('users_shipment_details').doc(userId).get();
      if (doc.exists) {
        return UserShipmentDetails.fromJson(doc.data()! as Map<String, dynamic>);
      }
      throw Exception('No shipment details found for user $userId');
    } catch (e) {
      throw Exception('Failed to get shipment details: $e');
    }
  }
}
