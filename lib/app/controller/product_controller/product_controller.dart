import 'package:bikretaa/features/products/database/product_database.dart';
import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductDatabase _productDatabase = ProductDatabase();

  // Global product lists
  RxList<Product> allProducts = <Product>[].obs;
  RxList<Product> lowStockProducts = <Product>[].obs;
  RxList<Product> outOfStockProducts = <Product>[].obs;
  RxList<Product> expiredProducts = <Product>[].obs;
  RxList<Product> expireSoonProducts = <Product>[].obs;

  /// add new get
  ///Combines various product states into a list of alert strings or objects.
  List<Map<String, String>> get alerts {
    List<Map<String, String>> alertList = [];

    if (outOfStockProducts.isNotEmpty) {
      alertList.add({
        "type": "outOfStock",
        "title": "${outOfStockProducts.length} items out of stock",
        "message": "Customers cannot purchase these items.",
      });
    }

    if (lowStockProducts.isNotEmpty) {
      alertList.add({
        "type": "lowStock",
        "title": "${lowStockProducts.length} items low in stock",
        "message": "Consider reordering these soon.",
      });
    }

    if (expiredProducts.isNotEmpty) {
      alertList.add({
        "type": "expired",
        "title": "${expiredProducts.length} items expired",
        "message": "Remove these from your active inventory.",
      });
    }

    if (expireSoonProducts.isNotEmpty) {
      alertList.add({
        "type": "expiring",
        "title": "${expireSoonProducts.length} items expiring soon",
        "message": "Plan a clearance sale or check quality.",
      });
    }

    return alertList;
  }

  /// end get

  @override
  void onInit() {
    super.onInit();
    _listenProducts();
  }

  void _listenProducts() {
    _productDatabase.getProductsStream().listen((products) {
      allProducts.value = products;

      DateTime now = DateTime.now();

      lowStockProducts.value = products
          .where((p) => p.quantity > 0 && p.quantity <= 5)
          .toList();
      outOfStockProducts.value = products
          .where((p) => p.quantity == 0)
          .toList();
      expiredProducts.value = products.where((p) {
        final expDate = DateTime.tryParse(p.expireDate);
        return expDate != null && expDate.isBefore(now);
      }).toList();
      expireSoonProducts.value = products.where((p) {
        final expDate = DateTime.tryParse(p.expireDate);
        return expDate != null &&
            expDate.isAfter(now) &&
            expDate.isBefore(now.add(Duration(days: 30)));
      }).toList();
    });
  }

  List<Product> searchProducts(String query) {
    return allProducts
        .where((p) => p.productName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
