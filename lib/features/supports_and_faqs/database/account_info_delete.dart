import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccountHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  String? get uid => _currentUser?.uid;

  // Delete User Document
  Future<void> deleteUser() async {
    if (uid != null) {
      await _firestore.collection('users').doc(uid).delete();
    }
  }

  // Delete Products
  Future<void> deleteProducts() async {
    if (uid != null) {
      final productsSnapshot = await _firestore
          .collection("Products")
          .doc(uid)
          .collection("products_list")
          .get();

      for (var doc in productsSnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  // Delete Sales
  Future<void> deleteSales() async {
    if (uid != null) {
      final salesSnapshot = await _firestore
          .collection("Sales")
          .doc(uid)
          .collection("sales_list")
          .get();

      for (var doc in salesSnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  // Delete Paid
  Future<void> deletePaid() async {
    if (uid != null) {
      final paidSnapshot = await _firestore
          .collection("Paid")
          .doc(uid)
          .collection("paid_list")
          .get();

      for (var doc in paidSnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  // Delete Due
  Future<void> deleteDue() async {
    if (uid != null) {
      final dueSnapshot = await _firestore
          .collection("Due")
          .doc(uid)
          .collection("due_list")
          .get();

      for (var doc in dueSnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  // Delete Revenue
  Future<void> deleteRevenue() async {
    if (uid != null) {
      final revenueSnapshot = await _firestore
          .collection("Revenue")
          .doc(uid)
          .collection("revenue_list")
          .get();

      for (var doc in revenueSnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  // Delete all collections at once
  Future<void> deleteAll() async {
    await deleteProducts();
    await deleteSales();
    await deletePaid();
    await deleteDue();
    await deleteRevenue();
    await deleteUser();
    if (_currentUser != null) {
      await _currentUser!.delete();
    }
  }
}
