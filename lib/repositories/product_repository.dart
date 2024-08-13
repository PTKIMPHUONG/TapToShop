import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';
import '../models/product.dart';

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository(this._firebaseFirestore);

  Stream<List<Product>> getProducts({
    required String query,
    required bool sortAscending,
    required String category,
  }) {
    Query<Product> queryRef = _firebaseFirestore.collection('products').withConverter(
      fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
      toFirestore: (product, _) => product.toJson(),
    );

    if (category.isNotEmpty && category != 'all') {
      queryRef = queryRef.where('categoryId', isEqualTo: category);
    }

    if (query.isNotEmpty) {
      queryRef = queryRef.where('name', isGreaterThanOrEqualTo: query)
                         .where('name', isLessThanOrEqualTo: '$query\uf8ff');
    }

    queryRef = queryRef.orderBy('price', descending: !sortAscending);

    return queryRef.snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Product>> getProductsByCategory(String categoryId) {
    return _firebaseFirestore
        .collection('products')
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }

  Stream<List<Category>> getCategories() {
    return _firebaseFirestore
        .collection('categories') 
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());
  }

  Stream<List<Product>> getProductsSortedByPrice(String sortOrder) {
    return _firebaseFirestore
        .collection('products')
        .orderBy('price', descending: sortOrder == 'desc')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }
}
