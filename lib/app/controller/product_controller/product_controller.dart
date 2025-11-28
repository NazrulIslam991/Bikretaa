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
