import 'package:bikretaa/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

  // Stream of products
  Stream<List<Product>> getProductsStream() {
    final uid = currentUid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection("Products")
        .doc(uid)
        .collection("products_list")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  /// Add a new product
  Future<bool> addProduct(Product product) async {
    if (uid == null) throw Exception("User not logged in");

    final docRef = _firestore
        .collection("Products")
        .doc(uid)
        .collection("products_list")
        .doc(product.productId);

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      return false;
    } else {
      await docRef.set(product.toMap());
      return true;
    }
  }

  /// Update an existing product
  Future<void> updateProduct(Product product) async {
    if (uid == null) throw Exception("User not logged in");

    final docRef = _firestore
        .collection("Products")
        .doc(uid)
        .collection("products_list")
        .doc(product.productId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      throw Exception("Product does not exist");
    }

    await docRef.update(product.toMap());
  }

  /// Delete a product
  Future<void> deleteProduct(String productId) async {
    if (uid == null) throw Exception("User not logged in");

    final docRef = _firestore
        .collection("Products")
        .doc(uid)
        .collection("products_list")
        .doc(productId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      throw Exception("Product does not exist");
    }

    await docRef.delete();
  }
}
