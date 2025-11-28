import 'package:bikretaa/features/sales/database/customer_info_database.dart';
import 'package:bikretaa/features/sales/model/DueModel.dart';
import 'package:bikretaa/features/sales/model/PaidModel.dart';
import 'package:bikretaa/features/sales/model/RevenueModel.dart';
import 'package:bikretaa/features/sales/model/SalesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateSalesDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CustomerDatabase _customerDb = CustomerDatabase();

  // Fetch sale by ID
  Future<Map<String, dynamic>?> fetchSale(String uid, String salesID) async {
    try {
      final doc = await _db
          .collection('Sales')
          .doc(uid)
          .collection('sales_list')
          .doc(salesID)
          .get();
      if (doc.exists) return doc.data();
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Update sale
  Future<void> updateSale({
    required String uid,
    required String salesID,
    required SalesModel updatedSale,
    required List<Map<String, String>> oldProducts,
    required List<Map<String, String>> newProducts,
    required String customerName,
    required String customerMobile,
    required String customerAddress,
    String? existingCustomerUID,
  }) async {
    final saleRef = _db
        .collection('Sales')
        .doc(uid)
        .collection('sales_list')
        .doc(salesID);

    //  If no products remain, delete sale and restore stock
    if (newProducts.isEmpty) {
      // Restore stock for old products
      for (var oldItem in oldProducts) {
        final productRef = _db
            .collection("Products")
            .doc(uid)
            .collection("products_list")
            .doc(oldItem['productId']);
        final qty = int.tryParse(oldItem['quantity'] ?? '0') ?? 0;
        await productRef.update({'quantity': FieldValue.increment(qty)});
      }

      await saleRef.delete();
      await _deletePaidDueRevenue(uid, salesID);
      return; //Skip customer creation
    }

    //Get or create customer ONLY if sale is not being deleted
    final customer = await _customerDb.getOrUpdateOrCreateCustomer(
      shopUID: uid,
      existingCustomerUID: existingCustomerUID,
      customerName: customerName,
      customerMobile: customerMobile,
      customerAddress: customerAddress,
    );

    // Update Sale document
    await saleRef.update({
      ...updatedSale.toMap(),
      'customerUID': customer.customerId,
    });

    //  Update Paid
    final paidQuery = await _db
        .collection('Paid')
        .doc(uid)
        .collection('paid_list')
        .where('salesID', isEqualTo: salesID)
        .get();

    if (paidQuery.docs.isNotEmpty) {
      await paidQuery.docs.first.reference.update({
        'amount': updatedSale.paidAmount,
      });
    } else if (updatedSale.paidAmount > 0) {
      final paidRef = _db
          .collection('Paid')
          .doc(uid)
          .collection('paid_list')
          .doc();
      await paidRef.set(
        PaidModel(salesID: salesID, amount: updatedSale.paidAmount).toMap(),
      );
    }

    //  Update Due
    final dueQuery = await _db
        .collection('Due')
        .doc(uid)
        .collection('due_list')
        .where('salesID', isEqualTo: salesID)
        .get();

    if (dueQuery.docs.isNotEmpty) {
      await dueQuery.docs.first.reference.update({
        'amount': updatedSale.dueAmount,
      });
    } else if (updatedSale.dueAmount > 0) {
      final dueRef = _db
          .collection('Due')
          .doc(uid)
          .collection('due_list')
          .doc();
      await dueRef.set(
        DueModel(
          salesID: salesID,
          amount: updatedSale.dueAmount,
          customerUID: customer.customerId,
        ).toMap(),
      );
    }

    //  Update Stock & Revenue
    await _updateStockAndRevenue(uid, salesID, oldProducts, newProducts);
  }

  // Delete Paid, Due, Revenue of a sale
  Future<void> _deletePaidDueRevenue(String uid, String salesID) async {
    for (var col in ['Paid', 'Due', 'Revenue']) {
      final query = await _db
          .collection(col)
          .doc(uid)
          .collection('${col.toLowerCase()}_list')
          .where('salesID', isEqualTo: salesID)
          .get();
      for (var doc in query.docs) {
        await doc.reference.delete();
      }
    }
  }

  //Stock & Revenue update logic remains unchanged
  Future<void> _updateStockAndRevenue(
    String uid,
    String salesID,
    List<Map<String, String>> oldProducts,
    List<Map<String, String>> newProducts,
  ) async {
    final oldMap = {for (var e in oldProducts) e['productId']!: e};
    final newMap = {for (var e in newProducts) e['productId']!: e};

    // Deleted products
    for (var oldEntry in oldMap.entries) {
      if (!newMap.containsKey(oldEntry.key)) {
        final productRef = _db
            .collection("Products")
            .doc(uid)
            .collection("products_list")
            .doc(oldEntry.key);
        final qty = int.tryParse(oldEntry.value['quantity'] ?? '0') ?? 0;
        await productRef.update({'quantity': FieldValue.increment(qty)});

        final revQuery = await _db
            .collection("Revenue")
            .doc(uid)
            .collection("revenue_list")
            .where('salesID', isEqualTo: salesID)
            .where('productId', isEqualTo: oldEntry.key)
            .get();
        for (var doc in revQuery.docs) await doc.reference.delete();
      }
    }

    // Add or update products
    for (var newEntry in newMap.entries) {
      final productRef = _db
          .collection("Products")
          .doc(uid)
          .collection("products_list")
          .doc(newEntry.key);
      final quantitySoldNew =
          int.tryParse(newEntry.value['quantity'] ?? '0') ?? 0;
      final oldQuantity =
          int.tryParse(oldMap[newEntry.key]?['quantity'] ?? '0') ?? 0;
      final diff = quantitySoldNew - oldQuantity;

      await _db.runTransaction((transaction) async {
        final snapshot = await transaction.get(productRef);
        if (!snapshot.exists) return;

        final currentQuantity = (snapshot.get('quantity') as num).toInt();
        transaction.update(productRef, {'quantity': currentQuantity - diff});

        // Revenue
        final revQuery = await _db
            .collection("Revenue")
            .doc(uid)
            .collection("revenue_list")
            .where('salesID', isEqualTo: salesID)
            .where('productId', isEqualTo: newEntry.key)
            .get();

        if (revQuery.docs.isNotEmpty) {
          final revDoc = revQuery.docs.first;
          transaction.update(revDoc.reference, {
            'quantitySold': quantitySoldNew,
            'totalRevenue':
                quantitySoldNew *
                ((snapshot.get('sellingPrice') as num) -
                    (snapshot.get('purchasePrice') as num)),
            'totalSellAmount':
                quantitySoldNew * (snapshot.get('sellingPrice') as num),
          });
        } else {
          final revenueRef = _db
              .collection("Revenue")
              .doc(uid)
              .collection("revenue_list")
              .doc();
          transaction.set(
            revenueRef,
            RevenueModel(
              salesID: salesID,
              productId: newEntry.key,
              productName: snapshot.get('productName'),
              quantitySold: quantitySoldNew,
              totalRevenue:
                  quantitySoldNew *
                  ((snapshot.get('sellingPrice') as num).toDouble() -
                      (snapshot.get('purchasePrice') as num).toDouble()),
              totalSellAmount:
                  quantitySoldNew *
                  (snapshot.get('sellingPrice') as num).toDouble(),
            ).toMap(),
          );
        }
      });
    }
  }
}
