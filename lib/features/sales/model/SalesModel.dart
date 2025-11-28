import 'package:cloud_firestore/cloud_firestore.dart';

class SalesModel {
  final String customerUID;
  final double grandTotal;
  final double paidAmount;
  final double dueAmount;
  final List<Map<String, String>> products;
  final DateTime? timestamp;

  SalesModel({
    required this.customerUID,
    required this.grandTotal,
    required this.paidAmount,
    required this.dueAmount,
    required this.products,
    this.timestamp,
  });

  // Convert SalesModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'customerUID': customerUID,
      'grandTotal': grandTotal,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'products': products,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}
