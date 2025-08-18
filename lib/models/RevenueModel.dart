import 'package:cloud_firestore/cloud_firestore.dart';

class RevenueModel {
  final String salesID;
  final String productId;
  final String productName;
  final int quantitySold;
  final double totalRevenue;
  final double totalSellAmount;
  final DateTime? timestamp;

  RevenueModel({
    required this.salesID,
    required this.productId,
    required this.productName,
    required this.quantitySold,
    required this.totalRevenue,
    required this.totalSellAmount,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'salesID': salesID,
      'productId': productId,
      'productName': productName,
      'quantitySold': quantitySold,
      'totalRevenue': totalRevenue,
      'totalSellAmount': totalSellAmount,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}
