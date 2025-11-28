import 'package:bikretaa/features/sales/model/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Check existing customer or create new one
  Future<CustomerModel> getOrCreateCustomer({
    required String shopUID,
    required String customerName,
    required String customerMobile,
    required String customerAddress,
  }) async {
    final ref = _db
        .collection("Customers")
        .doc(shopUID)
        .collection("customers_list");

    // Check if customer exists
    final query = await ref
        .where("name", isEqualTo: customerName)
        .where("mobile", isEqualTo: customerMobile)
        .where("address", isEqualTo: customerAddress)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return CustomerModel.fromMap(doc.data(), doc.id);
    }

    // Create new customer
    final newDocRef = ref.doc();
    final newCustomer = CustomerModel(
      customerId: newDocRef.id,
      name: customerName,
      mobile: customerMobile,
      address: customerAddress,
    );

    await newDocRef.set(newCustomer.toMap());
    return newCustomer;
  }

  //Fetch customer by UID
  Future<CustomerModel?> fetchCustomer(
    String shopUID,
    String customerUID,
  ) async {
    final docRef = _db
        .collection("Customers")
        .doc(shopUID)
        .collection("customers_list")
        .doc(customerUID);

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      return CustomerModel.fromMap(snapshot.data()!, snapshot.id);
    }
    return null;
  }

  //////////////////////get update or create customer///////////////////////////
  Future<CustomerModel> getOrUpdateOrCreateCustomer({
    required String shopUID,
    required String? existingCustomerUID,
    required String customerName,
    required String customerMobile,
    required String customerAddress,
  }) async {
    final ref = _db
        .collection("Customers")
        .doc(shopUID)
        .collection("customers_list");

    //Update existing customer
    if (existingCustomerUID != null && existingCustomerUID.isNotEmpty) {
      final docRef = ref.doc(existingCustomerUID);

      await docRef.update({
        'name': customerName,
        'mobile': customerMobile,
        'address': customerAddress,
      });

      final snap = await docRef.get();
      return CustomerModel.fromMap(snap.data()!, snap.id);
    }

    //If exact match exists → return that customer
    final query = await ref
        .where("name", isEqualTo: customerName)
        .where("mobile", isEqualTo: customerMobile)
        .where("address", isEqualTo: customerAddress)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return CustomerModel.fromMap(doc.data(), doc.id);
    }

    //Create new customer
    final newDocRef = ref.doc();
    final newCustomer = CustomerModel(
      customerId: newDocRef.id,
      name: customerName,
      mobile: customerMobile,
      address: customerAddress,
    );

    await newDocRef.set(newCustomer.toMap());
    return newCustomer;
  }

  // /////////////////////////Fetch all customers for list screen////////////////////////////////////////////
  Future<List<CustomerModel>> fetchAllCustomers(String shopUID) async {
    final snapshot = await _db
        .collection('Customers')
        .doc(shopUID)
        .collection('customers_list')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => CustomerModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
