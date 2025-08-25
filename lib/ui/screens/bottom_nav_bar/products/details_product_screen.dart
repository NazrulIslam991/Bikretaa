import 'package:bikretaa/database/product_database.dart';
import 'package:bikretaa/models/product_model.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/products/update_product_screen.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior_2.dart';
import 'package:bikretaa/ui/widgets/confirm_dialog.dart';
import 'package:bikretaa/ui/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsProductScreen extends StatelessWidget {
  final String productId;
  final String productName;
  final String brandName;
  final double purchasePrice;
  final double sellingPrice;
  final double discountPrice;
  final int quantity;
  final String supplierName;
  final String description;
  final String manufactureDate;
  final String expireDate;
  final String imagePath;

  const DetailsProductScreen({
    super.key,
    required this.productId,
    required this.productName,
    required this.brandName,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.discountPrice,
    required this.quantity,
    required this.supplierName,
    required this.description,
    required this.manufactureDate,
    required this.expireDate,
    required this.imagePath,
  });

  static const String name = 'DetailsProductScreen';

  @override
  Widget build(BuildContext context) {
    final ProductDatabase _deleteProduct = ProductDatabase();

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(fontSize: 22.h)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0.h),
              child: Image.network(
                imagePath,
                width: double.infinity,
                height: 170.h,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: double.infinity,
                    height: 170.h,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 170.h,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image,
                      size: 50.h,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Text(
                productName,
                style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
              child: Text(
                "Brand Name : $brandName",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: .5,
                    fontSize: 12.h,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 25.h,
                left: 25.h,
                top: 15.h,
                bottom: 10.h,
              ),
              child: Text(
                "Product information",
                style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
              ),
            ),
            Divider_widget(),
            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Quantity in Stock",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "$quantity unit",
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Product Code",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            productId,
                            style: TextStyle(
                              fontSize: 12.h,
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: productId));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Product ID copied to clipboard',
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.copy,
                              size: 18.h,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider_widget(),
            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Suppier Name",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        supplierName,
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Discount",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$discountPrice tk',
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider_widget(),
            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Purchase Price",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "$purchasePrice tk",
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Selling Price",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$sellingPrice tk',
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider_widget(),
            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Manufacture Date",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        manufactureDate,
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Expiry Date",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        expireDate,
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 15.h,
                bottom: 10.h,
              ),
              child: Text(
                "Product Description",
                style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 0.h,
                bottom: 10.h,
              ),
              child: Text(
                description,
                style: GoogleFonts.ibarraRealNova(
                  textStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: .5,
                    fontSize: 14.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40.h,
              width: 90.w,
              child: ElevatedButton(
                onPressed: () {
                  _onTapEdit(context);
                },
                child: const Text("Edit"),
              ),
            ),

            SizedBox(
              height: 40.h,
              width: 90.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _onTapDelete(context);
                },
                child: const Text("Delete"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapDelete(BuildContext context) async {
    final ProductDatabase _deleteProductDatabase = ProductDatabase();

    final confirm = await showConfirmDialog(
      context: context,
      title: "Delete Product",
      content: "Are you sure you want to delete this product?",
      confirmText: "Delete",
      confirmColor: Colors.red,
    );

    if (confirm) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CircularProgressIndicator2(),
      );

      try {
        await _deleteProductDatabase.deleteProduct(productId);

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product deleted successfully")),
        );
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to delete: $e")));
      }
    }
  }

  void _onTapEdit(BuildContext context) {
    final product = Product(
      productId: productId,
      productName: productName,
      brandName: brandName,
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      discountPrice: discountPrice,
      quantity: quantity,
      supplierName: supplierName,
      description: description,
      manufactureDate: manufactureDate,
      expireDate: expireDate,
      image: imagePath,
      createdAt: DateTime.now(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProductScreen(product: product),
      ),
    );
  }
}
