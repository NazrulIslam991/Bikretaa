import 'package:bikretaa/ui/screens/bottom_nav_bar/products/add_product_screen.dart';
import 'package:bikretaa/ui/widgets/product_card.dart';
import 'package:bikretaa/ui/widgets/search_bar.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SizedBox(
            height: 40.h,
            child: CustomSearchBar(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
                if (value.isNotEmpty) {
                  showSnackbarMessage(context, searchText);
                }
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        child: SingleChildScrollView(
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
                        "25 products found",
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

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 5.h,
                    childAspectRatio: 1.h / 1.3.h,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCardWidget(
                      productName: "Apple",
                      category: "Fruits",
                      totalUnit: "150",
                      unitPrice: 120,
                      imagePath: "assets/images/most_products_sold.jpeg",
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ],
          ),
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
