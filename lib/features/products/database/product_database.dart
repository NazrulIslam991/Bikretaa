import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

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

  Future<bool> addProduct(Product product) async {
    final uid = currentUid;
    if (uid == null) throw Exception("User not logged in");

    final docRef = _firestore
        .collection("Products")
        .doc(uid)
        .collection("products_list")
        .doc(product.productId);

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) return false;

    await docRef.set(product.toMap());
    return true;
  }

  Future<void> updateProduct(Product product) async {
    final uid = currentUid;
    if (uid == null) throw Exception("User not logged in");

    final docRef = _firestore
        .collection("Products")
        .doc(uid)
        .collection("products_list")
        .doc(product.productId);

    await docRef.update(product.toMap());
  }

  Future<void> deleteProduct(String productId) async {
    final uid = currentUid;
    if (uid == null) throw Exception("User not logged in");

    final docRef = _firestore
        .collection("Products")
        .doc(uid)
        .collection("products_list")
        .doc(productId);

    await docRef.delete();
  }
}
