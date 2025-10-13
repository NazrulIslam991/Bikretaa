import 'package:bikretaa/features/sales/model/DueModel.dart';
import 'package:bikretaa/features/sales/model/PaidModel.dart';
import 'package:bikretaa/features/sales/model/RevenueModel.dart';
import 'package:bikretaa/features/sales/model/SalesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateSalesDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch sale by salesID
  Future<Map<String, dynamic>?> fetchSale(String uid, String salesID) async {
    try {
      final doc = await _firestore
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

  //Fetch product by ID
  Future<Map<String, dynamic>?> fetchProduct(
    String uid,
    String productId,
  ) async {
    try {
      final doc = await _firestore
          .collection('Products')
          .doc(uid)
          .collection('products_list')
          .doc(productId)
          .get();
      if (doc.exists) return doc.data();
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Update the sale, paid, due, stock, and revenue
  Future<void> updateSale({
    required String uid,
    required String salesID,
    required SalesModel updatedSale,
    required List<Map<String, String>> oldProducts,
    required List<Map<String, String>> newProducts,
  }) async {
    final saleRef = _firestore
        .collection('Sales')
        .doc(uid)
        .collection('sales_list')
        .doc(salesID);

    //  If no products remain, delete sale and restore old stock
    if (newProducts.isEmpty) {
      //  Add old products' quantities back to stock
      for (var oldItem in oldProducts) {
        final productId = oldItem['productId']!;
        final quantityToReturn = int.tryParse(oldItem['quantity'] ?? '0') ?? 0;

        final productRef = _firestore
            .collection('Products')
            .doc(uid)
            .collection('products_list')
            .doc(productId);

        await _firestore.runTransaction((transaction) async {
          final snapshot = await transaction.get(productRef);
          if (!snapshot.exists) return;

          int currentQuantity = (snapshot.get('quantity') as num).toInt();
          transaction.update(productRef, {
            'quantity': currentQuantity + quantityToReturn,
          });
        });
      }

      //  Delete sale record
      await saleRef.delete();

      //  Delete all related Paid, Due, and Revenue data
      await _deletePaidDueRevenue(uid, salesID);
      return;
    }

    //  Update Sale
    await saleRef.update(updatedSale.toMap());

    // Update Paid
    final paidQuery = await _firestore
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
      final paidRef = _firestore
          .collection('Paid')
          .doc(uid)
          .collection('paid_list')
          .doc();
      await paidRef.set(
        PaidModel(salesID: salesID, amount: updatedSale.paidAmount).toMap(),
      );
    }

    // Update Due (with customer info)
    final dueQuery = await _firestore
        .collection('Due')
        .doc(uid)
        .collection('due_list')
        .where('salesID', isEqualTo: salesID)
        .get();

    if (dueQuery.docs.isNotEmpty) {
      await dueQuery.docs.first.reference.update({
        'amount': updatedSale.dueAmount,
        'customerName': updatedSale.customerName,
        'customerMobile': updatedSale.customerMobile,
        'customerAddress': updatedSale.customerAddress,
      });
    } else if (updatedSale.dueAmount > 0) {
      final dueRef = _firestore
          .collection('Due')
          .doc(uid)
          .collection('due_list')
          .doc();
      await dueRef.set(
        DueModel(
          salesID: salesID,
          amount: updatedSale.dueAmount,
          customerName: updatedSale.customerName,
          customerMobile: updatedSale.customerMobile,
          customerAddress: updatedSale.customerAddress,
        ).toMap(),
      );
    }

    //  Update Stock & Revenue
    await _updateStockAndRevenue(uid, salesID, oldProducts, newProducts);
  }

  // Delete Paid, Due, Revenue of a sale
  Future<void> _deletePaidDueRevenue(String uid, String salesID) async {
    final paidQuery = await _firestore
        .collection('Paid')
        .doc(uid)
        .collection('paid_list')
        .where('salesID', isEqualTo: salesID)
        .get();
    for (var doc in paidQuery.docs) {
      await doc.reference.delete();
    }

    final dueQuery = await _firestore
        .collection('Due')
        .doc(uid)
        .collection('due_list')
        .where('salesID', isEqualTo: salesID)
        .get();
    for (var doc in dueQuery.docs) {
      await doc.reference.delete();
    }

    final revQuery = await _firestore
        .collection('Revenue')
        .doc(uid)
        .collection('revenue_list')
        .where('salesID', isEqualTo: salesID)
        .get();
    for (var doc in revQuery.docs) {
      await doc.reference.delete();
    }
  }

  // Update stock & revenue for products
  Future<void> _updateStockAndRevenue(
    String uid,
    String salesID,
    List<Map<String, String>> oldProducts,
    List<Map<String, String>> newProducts,
  ) async {
    final oldMap = {for (var e in oldProducts) e['productId']!: e};
    final newMap = {for (var e in newProducts) e['productId']!: e};

    //  deleted products
    for (var oldEntry in oldMap.entries) {
      if (!newMap.containsKey(oldEntry.key)) {
        final productRef = _firestore
            .collection("Products")
            .doc(uid)
            .collection("products_list")
            .doc(oldEntry.key);

        final quantityToReturn =
            int.tryParse(oldEntry.value['quantity'] ?? "0") ?? 0;

        await productRef.update({
          'quantity': FieldValue.increment(quantityToReturn),
        });

        // Delete revenue for removed product
        final revQuery = await _firestore
            .collection("Revenue")
            .doc(uid)
            .collection("revenue_list")
            .where('salesID', isEqualTo: salesID)
            .where('productId', isEqualTo: oldEntry.key)
            .get();

        for (var doc in revQuery.docs) {
          await doc.reference.delete();
        }
      }
    }

    // Update or add products and revenue
    for (var newEntry in newMap.entries) {
      final productId = newEntry.key;
      final quantitySoldNew =
          int.tryParse(newEntry.value['quantity'] ?? "0") ?? 0;
      final oldQuantity =
          int.tryParse(oldMap[productId]?['quantity'] ?? "0") ?? 0;
      final difference = quantitySoldNew - oldQuantity;

      final productRef = _firestore
          .collection("Products")
          .doc(uid)
          .collection("products_list")
          .doc(productId);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(productRef);
        if (!snapshot.exists) return;

        int currentQuantity = (snapshot.get('quantity') as num).toInt();
        transaction.update(productRef, {
          'quantity': currentQuantity - difference,
        });

        // Revenue handling
        final revQuery = await _firestore
            .collection("Revenue")
            .doc(uid)
            .collection("revenue_list")
            .where('salesID', isEqualTo: salesID)
            .where('productId', isEqualTo: productId)
            .get();

        if (revQuery.docs.isNotEmpty) {
          final revDoc = revQuery.docs.first;
          transaction.update(revDoc.reference, {
            'quantitySold': quantitySoldNew,
            'totalRevenue':
                quantitySoldNew *
                ((snapshot.get('sellingPrice') as num).toDouble() -
                    (snapshot.get('purchasePrice') as num).toDouble()),
            'totalSellAmount':
                quantitySoldNew *
                (snapshot.get('sellingPrice') as num).toDouble(),
          });
        } else {
          final revenueRef = _firestore
              .collection("Revenue")
              .doc(uid)
              .collection("revenue_list")
              .doc();

          transaction.set(
            revenueRef,
            RevenueModel(
              salesID: salesID,
              productId: productId,
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
