class UserModel {
  final String shopName;
  final String email;
  final String phone;
  final String? shopType;
  final DateTime? createdAt;

  UserModel({
    required this.shopName,
    required this.email,
    required this.phone,
    this.shopType,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'email': email,
      'phone': phone,
      'shopType': shopType,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      shopName: map['shopName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      shopType: map['shopType'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }
}
