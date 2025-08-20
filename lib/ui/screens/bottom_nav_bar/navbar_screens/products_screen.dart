import 'package:bikretaa/database/product_database.dart';
import 'package:bikretaa/models/product_model.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/products/add_product_screen.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/product_card.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_filter_sheet.dart';
import 'package:bikretaa/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  static const name = 'Product_Screen';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductDatabase _productDatabase = ProductDatabase();
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  ProductFilter selectedFilter = ProductFilter.all;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        backgroundColor: Colors.white10,
        title: CustomSearchBar(
          controller: searchController,
          onChanged: (value) =>
              setState(() => searchText = value.toLowerCase()),
          hintText: 'Search product',
          prefixIcon: Icons.search,
          fontSize: 12,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        child: StreamBuilder<List<Product>>(
          stream: _productDatabase.getProductsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CenterCircularProgressIndiacator();
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No products found"));
            }

            final products = _applyFilter(snapshot.data!);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                              fontSize: 25.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${products.length} products found",
                            style: GoogleFonts.italianno(
                              textStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: .5,
                                fontSize: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _showFilterSheet,
                        icon: Image.asset(
                          'assets/images/filter_icon.png',
                          width: 25.h,
                          height: 25.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 5.h,
                      childAspectRatio: 1.h / 1.4.h,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCardWidget(
                        productId: product.productId,
                        productName: product.productName,
                        brandName: product.brandName,
                        purchasePrice: product.purchasePrice,
                        sellingPrice: product.sellingPrice,
                        discountPrice: product.discountPrice,
                        quantity: product.quantity,
                        supplierName: product.supplierName,
                        description: product.description,
                        manufactureDate: product.manufactureDate,
                        expireDate: product.expireDate,
                        imagePath: product.image,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.name);
        },
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        child: Icon(Icons.add_box_outlined, size: 25.h),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return ProductFilterSheet(
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
          },
        );
      },
    );
  }

  List<Product> _applyFilter(List<Product> products) {
    List<Product> filtered = products;

    if (searchText.isNotEmpty) {
      filtered = filtered
          .where((p) => p.productName.toLowerCase().contains(searchText))
          .toList();
    }

    switch (selectedFilter) {
      case ProductFilter.lowStock:
        filtered = filtered.where((p) => p.quantity <= 5).toList();
        break;
      case ProductFilter.aToZ:
        filtered.sort((a, b) => a.productName.compareTo(b.productName));
        break;
      case ProductFilter.zToA:
        filtered.sort((a, b) => b.productName.compareTo(a.productName));
        break;
      case ProductFilter.all:
        break;
    }

    return filtered;
  }
}
