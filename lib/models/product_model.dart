import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String productName;
  final String brandName;
  final double purchasePrice;
  final double sellingPrice;
  final double discountPrice;
  final int quantity;
  final String supplierName;
  final String description;
  final String manufactureDate;
  final String expireDate;
  final DateTime? createdAt;

  Product({
    required this.productId,
    required this.productName,
    required this.brandName,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.discountPrice,
    required this.quantity,
    required this.supplierName,
    required this.description,
    required this.manufactureDate,
    required this.expireDate,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'brandName': brandName,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'discountPrice': discountPrice,
      'quantity': quantity,
      'supplierName': supplierName,
      'description': description,
      'manufactureDate': manufactureDate,
      'expireDate': expireDate,
      'createdAt': createdAt?.toIso8601String() ?? FieldValue.serverTimestamp(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      brandName: map['brandName'] ?? '',
      purchasePrice: (map['purchasePrice'] ?? 0).toDouble(),
      sellingPrice: (map['sellingPrice'] ?? 0).toDouble(),
      discountPrice: (map['discountPrice'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 0,
      supplierName: map['supplierName'] ?? '',
      description: map['description'] ?? '',
      manufactureDate: map['manufactureDate'] ?? '',
      expireDate: map['expireDate'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])
          : null,
    );
  }
}
