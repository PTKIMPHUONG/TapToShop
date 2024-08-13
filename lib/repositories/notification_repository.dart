import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getNotifications(String userId) async {
    try {
      final querySnapshot = await _firestore.collection('notifications').where('userId', isEqualTo: userId).get();
      return querySnapshot.docs.map((doc) => doc.id).toList(); // Assuming document ID is the order ID
    } catch (e) {
      throw Exception('Failed to get notifications: $e');
    }
  }
}
