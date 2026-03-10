class CustomerDueModel {
  final String? id;
  final String salesID;
  final double amount;
  final double grandTotal;
  final double paidAmount;
  final String customerUID;

  CustomerDueModel({
    this.id,
    required this.salesID,
    required this.amount,
    required this.grandTotal,
    required this.paidAmount,
    required this.customerUID,
  });

  factory CustomerDueModel.fromMap(Map<String, dynamic> map, [String? docId]) {
    return CustomerDueModel(
      id: docId,
      salesID: map['salesID'] ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      grandTotal: (map['grandTotal'] as num?)?.toDouble() ?? 0.0,
      paidAmount: (map['paidAmount'] as num?)?.toDouble() ?? 0.0,
      customerUID: map['customerUID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'salesID': salesID,
      'amount': amount,
      'grandTotal': grandTotal,
      'paidAmount': paidAmount,
      'customerUID': customerUID,
    };
  }
}