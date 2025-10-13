import 'package:cloud_firestore/cloud_firestore.dart';

class DueModel {
  final String salesID;
  final double amount;
  final String customerName;
  final String customerMobile;
  final String customerAddress;
  final DateTime? timestamp;

  DueModel({
    required this.salesID,
    required this.amount,
    required this.customerName,
    required this.customerMobile,
    required this.customerAddress,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'salesID': salesID,
      'amount': amount,
      'customerName': customerName,
      'customerMobile': customerMobile,
      'customerAddress': customerAddress,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}
