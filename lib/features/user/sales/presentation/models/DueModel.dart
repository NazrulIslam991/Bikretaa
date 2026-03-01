import 'package:cloud_firestore/cloud_firestore.dart';

class DueModel {
  final String salesID;
  final double amount;
  final String customerUID;
  final DateTime? timestamp;

  DueModel({
    required this.salesID,
    required this.amount,
    required this.customerUID,
    this.timestamp,
  });

  // Convert DueModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'salesID': salesID,
      'amount': amount,
      'customerUID': customerUID,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}
