import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:bikretaa/features/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/controller/product_controller/product_controller.dart';

class ProductsFilterScreen extends StatefulWidget {
  final String title;

  const ProductsFilterScreen({required this.title, Key? key}) : super(key: key);

  @override
  State<ProductsFilterScreen> createState() => _ProductsFilterScreenState();
}

class _ProductsFilterScreenState extends State<ProductsFilterScreen> {
  final ProductController productController = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  bool isSearching = false;

  RxList<Product> getFilteredList() {
    switch (widget.title) {
      case "All Products":
        return productController.allProducts;
      case "Low Stock":
        return productController.lowStockProducts;
      case "Expired Date":
        return productController.expiredProducts;
      case "Expire Soon":
        return productController.expireSoonProducts;
      case "Out of Stock":
        return productController.outOfStockProducts;
      default:
        return productController.allProducts;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: r.height(0.09),
        title: isSearching
            ? _buildSearchBar(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
                onCancel: () {
                  setState(() {
                    isSearching = false;
                    searchText = "";
                    searchController.clear();
                  });
                },
                height: r.height(0.06),
              )
            : Obx(() {
                final productsCount = getFilteredList()
                    .where(
                      (p) => p.productName.toLowerCase().contains(searchText),
                    )
                    .length;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: r.fontXL(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: r.height(0.005)),
                    Text(
                      "$productsCount products found",
                      style: GoogleFonts.abhayaLibre(
                        textStyle: TextStyle(
                          fontSize: r.fontMedium(),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                );
              }),
        actions: [
          if (!isSearching)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: r.height(0),
          horizontal: r.width(0.03),
        ),
        child: Obx(() {
          final products = getFilteredList()
              .where((p) => p.productName.toLowerCase().contains(searchText))
              .toList();

          if (products.isEmpty) {
            return Center(
              child: Text(
                "No products found!",
                style: TextStyle(
                  fontSize: r.fontLarge(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: r.height(0.02),
              crossAxisSpacing: r.width(0.03),
              childAspectRatio: 1.w / 1.18.h,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ProductCardWidget(
                productId: p.productId,
                productName: p.productName,
                brandName: p.brandName,
                purchasePrice: p.purchasePrice,
                sellingPrice: p.sellingPrice,
                discountPrice: p.discountPrice,
                quantity: p.quantity,
                supplierName: p.supplierName,
                description: p.description,
                manufactureDate: p.manufactureDate,
                expireDate: p.expireDate,
                imagePath: p.image,
              );
            },
          );
        }),
      ),
    );
  }

  // Reusable search bar widget
  Widget _buildSearchBar({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required VoidCallback onCancel,
    required double height,
  }) {
    final r = Responsive.of(context);
    return Container(
      height: height,
      child: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search product...',
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(icon: Icon(Icons.close), onPressed: onCancel),
          contentPadding: EdgeInsets.symmetric(vertical: r.height(0.015)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
