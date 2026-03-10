import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer_due_model.dart';

class CustomerDueDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<CustomerDueModel>> fetchCustomerDues({required String shopUID, required String customerUID}) async {
    final snap = await _db.collection('Due').doc(shopUID).collection('due_list')
        .where('customerUID', isEqualTo: customerUID).get();
    return snap.docs.map((doc) => CustomerDueModel.fromMap(doc.data(), doc.id)).toList();
  }

  Future<Map<String, dynamic>?> fetchSaleInfo(String shopUID, String salesID) async {
    final doc = await _db.collection('Sales').doc(shopUID).collection('sales_list').doc(salesID).get();
    return doc.exists ? doc.data() : null;
  }

  Future<List<Map<String, dynamic>>> fetchSaleProducts(String shopUID, String salesID) async {
    final query = await _db.collection("Revenue").doc(shopUID).collection("revenue_list")
        .where("salesID", isEqualTo: salesID).get();
    return query.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> fetchCollectedDues({required String shopUID, required String customerUID}) async {
    final query = await _db.collection('Due_Collections').doc(shopUID).collection('collection_list')
        .where('customerUID', isEqualTo: customerUID)
        .orderBy('date', descending: true).get();
    return query.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  Future<void> processCustomerPayment({
    required String shopUID, required String customerUID, required double amountPaid, required String salesID,
  }) async {
    final WriteBatch batch = _db.batch();

    final colRef = _db.collection('Due_Collections').doc(shopUID).collection('collection_list').doc();
    batch.set(colRef, {'customerUID': customerUID, 'amountPaid': amountPaid, 'salesID': salesID, 'date': FieldValue.serverTimestamp()});

    final dueQuery = await _db.collection('Due').doc(shopUID).collection('due_list').where('salesID', isEqualTo: salesID).get();
    if (dueQuery.docs.isNotEmpty) {
      double current = (dueQuery.docs.first.data()['amount'] as num).toDouble();
      batch.update(dueQuery.docs.first.reference, {'amount': (current - amountPaid).clamp(0, double.infinity)});
    }
    await batch.commit();
  }
}