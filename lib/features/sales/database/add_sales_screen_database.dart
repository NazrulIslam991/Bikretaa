import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:bikretaa/features/sales/database/customer_info_database.dart';
import 'package:bikretaa/features/sales/model/DueModel.dart';
import 'package:bikretaa/features/sales/model/PaidModel.dart';
import 'package:bikretaa/features/sales/model/RevenueModel.dart';
import 'package:bikretaa/features/sales/model/SalesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSalesScreenDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CustomerDatabase _customerDb = CustomerDatabase();

  Future<void> saveSale({
    required String uid,
    required SalesModel sale,
    required List<Map<String, String>> addedProducts,
    required String customerName,
    required String customerMobile,
    required String customerAddress,
  }) async {
    try {
      //Get or create customer
      final customer = await _customerDb.getOrCreateCustomer(
        shopUID: uid,
        customerName: customerName,
        customerMobile: customerMobile,
        customerAddress: customerAddress,
      );

      //Save Sale with customerUID
      final salesRef = _db
          .collection('Sales')
          .doc(uid)
          .collection('sales_list');
      final newSaleDoc = salesRef.doc();
      final salesID = newSaleDoc.id;

      await newSaleDoc.set({
        ...sale.toMap(),
        'customerUID': customer.customerId,
      });

      //Save Paid
      if (sale.paidAmount > 0) {
        final paidRef = _db
            .collection('Paid')
            .doc(uid)
            .collection('paid_list')
            .doc();
        final paidData = PaidModel(salesID: salesID, amount: sale.paidAmount);
        await paidRef.set(paidData.toMap());
      }

      //Save Due
      if (sale.dueAmount > 0) {
        final dueRef = _db
            .collection('Due')
            .doc(uid)
            .collection('due_list')
            .doc();
        final dueData = DueModel(
          salesID: salesID,
          amount: sale.dueAmount,
          customerUID: customer.customerId,
        );
        await dueRef.set(dueData.toMap());
      }

      //Save Revenue & Update Stock (same as before)
      for (var item in addedProducts) {
        final productId = item['productId']!;
        final quantitySold = int.tryParse(item['quantity'] ?? "0") ?? 0;

        final productRef = _db
            .collection("Products")
            .doc(uid)
            .collection("products_list")
            .doc(productId);

        await _db.runTransaction((transaction) async {
          final snapshot = await transaction.get(productRef);
          if (!snapshot.exists) return;

          int currentQuantity = (snapshot.get('quantity') as num).toInt();
          double sellingPrice = (snapshot.get('sellingPrice') as num)
              .toDouble();
          double purchasePrice = (snapshot.get('purchasePrice') as num)
              .toDouble();

          // Update stock
          transaction.update(productRef, {
            'quantity': currentQuantity - quantitySold,
          });

          // Save revenue
          final revenueRef = _db
              .collection("Revenue")
              .doc(uid)
              .collection("revenue_list")
              .doc();
          final revenueData = RevenueModel(
            salesID: salesID,
            productId: productId,
            productName: snapshot.get('productName'),
            quantitySold: quantitySold,
            totalRevenue: quantitySold * (sellingPrice - purchasePrice),
            totalSellAmount: quantitySold * sellingPrice,
          );
          transaction.set(revenueRef, revenueData.toMap());
        });
      }
    } catch (e) {
      throw Exception("Failed to save sale: $e");
    }
  }

  // Fetch Product by ID
  Future<Product?> fetchProductById(String uid, String productId) async {
    try {
      final docRef = _db
          .collection("Products")
          .doc(uid)
          .collection("products_list")
          .doc(productId);
      final docSnap = await docRef.get();
      if (docSnap.exists) {
        return Product.fromMap(docSnap.data()!);
      }
    } catch (e) {
      throw Exception("Error fetching product: $e");
    }
    return null;
  }
}
