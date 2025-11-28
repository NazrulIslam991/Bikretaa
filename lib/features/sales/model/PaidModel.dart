import 'package:cloud_firestore/cloud_firestore.dart';

class PaidModel {
  final String salesID;
  final double amount;
  final DateTime? timestamp;

  PaidModel({required this.salesID, required this.amount, this.timestamp});

  // Convert PaidModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'salesID': salesID,
      'amount': amount,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}
