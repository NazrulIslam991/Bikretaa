import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String customerId;
  final String name;
  final String mobile;
  final String address;
  final DateTime? createdAt;

  CustomerModel({
    required this.customerId,
    required this.name,
    required this.mobile,
    required this.address,
    this.createdAt,
  });

  // Convert Firestore document to CustomerModel
  factory CustomerModel.fromMap(Map<String, dynamic> map, String id) {
    return CustomerModel(
      customerId: id,
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      address: map['address'] ?? '',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert CustomerModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile,
      'address': address,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
