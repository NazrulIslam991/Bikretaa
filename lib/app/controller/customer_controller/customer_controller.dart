import 'package:bikretaa/features/sales/database/customer_info_database.dart';
import 'package:bikretaa/features/sales/model/customer_model.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  final CustomerDatabase _customerDb = CustomerDatabase();

  final RxMap<String, CustomerModel> _customerCache =
      <String, CustomerModel>{}.obs;

  Map<String, CustomerModel> get customerCache => _customerCache;

  // Fetch single customer
  Future<CustomerModel?> getCustomer(String shopUID, String customerUID) async {
    if (_customerCache.containsKey(customerUID)) {
      return _customerCache[customerUID];
    }

    final customer = await _customerDb.fetchCustomer(shopUID, customerUID);
    if (customer != null) {
      _customerCache[customerUID] = customer;
    }
    return customer;
  }

  // Fetch all customers
  Future<List<CustomerModel>> getAllCustomers(String shopUID) async {
    final customers = await _customerDb.fetchAllCustomers(shopUID);

    for (var c in customers) {
      _customerCache[c.customerId] = c;
    }

    return customers;
  }

  void clearCache() => _customerCache.clear();
}
