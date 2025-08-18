import 'package:bikretaa/ui/screens/bottom_nav_bar/products/details_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardWidget extends StatelessWidget {
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

  const ProductCardWidget({
    super.key,
    required this.productName,
    required this.imagePath,
    required this.productId,
    required this.brandName,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.discountPrice,
    required this.quantity,
    required this.supplierName,
    required this.description,
    required this.manufactureDate,
    required this.expireDate,
  });

  @override
  Widget build(BuildContext context) {
    final bool outOfStock = quantity == 0;

    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h)),
      child: SizedBox(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.h),
                topRight: Radius.circular(5.h),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                  if (outOfStock)
                    Container(
                      width: double.infinity,
                      height: 80.h,
                      color: Colors.black.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: Text(
                        "OUT OF STOCK",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.h,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.h,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    productId,
                    style: TextStyle(fontSize: 10.h, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    outOfStock ? "Out of Stock" : "Total: $quantity units",
                    style: TextStyle(
                      fontSize: 10.h,
                      color: outOfStock ? Colors.red : Colors.black,
                      fontWeight: outOfStock
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${sellingPrice.toStringAsFixed(2)} tk",
                        style: GoogleFonts.italianno(
                          textStyle: TextStyle(
                            color: Colors.red,
                            letterSpacing: .5,
                            fontSize: 18.h,
                          ),
                        ),
                      ),
                      Container(
                        height: 18.h,
                        child: TextButton(
                          onPressed: () {
                            // Always allow navigation to details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsProductScreen(
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
                                  imagePath: imagePath,
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            "show more...",
                            style: GoogleFonts.abyssinicaSil(
                              textStyle: TextStyle(
                                color: Colors.blue, // always blue
                                letterSpacing: .5,
                                fontSize: 10.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
