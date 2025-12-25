import 'package:bikretaa/features/products/database/product_database.dart';
import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:get/get.dart';
import '../../../features/shared/presentation/get_storeage_helper/get_storage_helper.dart';
import '../../../features/notification_users/services/notification_service.dart';

class ProductController extends GetxController {
  final ProductDatabase _productDatabase = ProductDatabase();

  // Global product lists
  RxList<Product> allProducts = <Product>[].obs;
  RxList<Product> lowStockProducts = <Product>[].obs;
  RxList<Product> outOfStockProducts = <Product>[].obs;
  RxList<Product> expiredProducts = <Product>[].obs;
  RxList<Product> expireSoonProducts = <Product>[].obs;

  Set<String> _notifiedIds = {};

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
    _notifiedIds = NotificationStorageService.getNotifiedIds();

    _listenProducts();
  }

  void _saveNotifiedId(String key) {
    NotificationStorageService.saveNotifiedId(key);
    _notifiedIds.add(key);
    update();
  }

  void _removeNotifiedId(String key) {
    NotificationStorageService.removeNotifiedId(key);
    _notifiedIds.remove(key);
    update();
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
      // notification logic start
      for (var product in products) {
        final expDate = DateTime.tryParse(product.expireDate);
        bool isExpired = expDate != null && expDate.isBefore(now);
        bool isOutOfStock = product.quantity == 0;

        String outOfStockKey = "${product.productId}_oos";
        String expiredKey = "${product.productId}_exp";

        // Out of Stock
        if (isOutOfStock) {
          if (!_notifiedIds.contains(outOfStockKey)) {
            NotificationService.showNotification(
              id: product.productId.hashCode + 1,
              title: "Out of Stock!",
              body: "${product.productName} এর স্টক শেষ হয়ে গেছে।",
              productData: product.toMap(),
            );
            _saveNotifiedId(outOfStockKey);
          }
        } else {
          _removeNotifiedId(outOfStockKey);
        }

        // Expired
        if (isExpired) {
          if (!_notifiedIds.contains(expiredKey)) {
            NotificationService.showNotification(
              id: product.productId.hashCode + 2,
              title: "Product Expired!",
              body: "${product.productName} এর মেয়াদ শেষ হয়ে গেছে।",
              productData: product.toMap(),
            );
            _saveNotifiedId(expiredKey);
          }
        }
      } // notification logic end
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
