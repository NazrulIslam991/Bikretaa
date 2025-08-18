import 'package:bikretaa/models/product_model.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/products/add_product_screen.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
  static const name = 'Product_Screen';
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: SizedBox(
          height: 40.h,
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value.toLowerCase();
              });
              if (value.isNotEmpty) {
                //showSnackbarMessage(context, searchText);
              }
            },
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 16.sp),
            textInputAction: TextInputAction.search,
          ),
        ),
        backgroundColor: Colors.white10,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        child: uid == null
            ? Center(child: Text("User not logged in"))
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Products")
                    .doc(uid)
                    .collection("products_list")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CenterCircularProgressIndiacator();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No products found"));
                  }

                  final products = snapshot.data!.docs
                      .map(
                        (doc) =>
                            Product.fromMap(doc.data() as Map<String, dynamic>),
                      )
                      .where(
                        (product) => product.productName.toLowerCase().contains(
                          searchText.toLowerCase(),
                        ),
                      )
                      .toList();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/filter_icon.png',
                                width: 25.h,
                                height: 25.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                imagePath:
                                    "assets/images/most_products_sold.jpeg",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddProductScreen.name);
          },
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          child: Icon(Icons.add_box_outlined, size: 25.h),
        ),
      ),
    );
  }
}
