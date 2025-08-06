import 'package:bikretaa/ui/screens/bottom_nav_bar/products/add_product_screen.dart';
import 'package:bikretaa/ui/widgets/product_card.dart';
import 'package:bikretaa/ui/widgets/search_bar.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:flutter/material.dart';
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
        title: CustomSearchBar(
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProductScreen.name);
            },
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "25 products found",
                        style: GoogleFonts.italianno(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_alt_rounded),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    childAspectRatio: 2 / 2.6,
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
    );
  }
}
