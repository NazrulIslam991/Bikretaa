import 'package:cloud_firestore/cloud_firestore.dart';

class CollectedDueModel {
  final String? id;
  final String customerUID;
  final double amountPaid;
  final Timestamp date;

  CollectedDueModel({
    this.id,
    required this.customerUID,
    required this.amountPaid,
    required this.date,
  });

  factory CollectedDueModel.fromMap(Map<String, dynamic> map, String docId) {
    return CollectedDueModel(
      id: docId,
      customerUID: map['customerUID'] ?? '',
      amountPaid: (map['amountPaid'] as num?)?.toDouble() ?? 0,
      date: map['date'] ?? Timestamp.now(),
    );
  }
}