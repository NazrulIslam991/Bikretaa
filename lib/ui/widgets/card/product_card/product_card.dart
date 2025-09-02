import 'package:bikretaa/ui/screens/bottom_nav_bar/products/details_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    final DateTime now = DateTime.now();
    final DateTime? expDate = DateTime.tryParse(expireDate);
    final bool outOfStock = quantity == 0;
    final theme = Theme.of(context);

    return Card(
      color: theme.cardColor,
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
                  Image.network(
                    imagePath,
                    width: double.infinity,
                    height: 80.h,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 80.h,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: Icon(Icons.broken_image, size: 30.h),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: double.infinity,
                        height: 80.h,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  // Overlay only for Out of Stock
                  if (outOfStock)
                    Container(
                      width: double.infinity,
                      height: 80.h,
                      color: Colors.red.withOpacity(0.3),
                      alignment: Alignment.center,
                      child: Text(
                        "OUT OF STOCK",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.h,
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
                      color: theme.colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    productId,
                    style: TextStyle(
                      fontSize: 10.h,
                      color: theme.colorScheme.surface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),

                  _buildStatusWidget(),

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
                      SizedBox(
                        height: 18.h,
                        child: TextButton(
                          onPressed: () {
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
                                color: Colors.blue,
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

  // reusable badge
  Widget _badge(String text, Color borderAndHint, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: borderAndHint.withOpacity(0.15),
        border: Border.all(color: borderAndHint, width: 1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 9.h,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  // return the widget
  Widget _buildStatusWidget() {
    final DateTime now = DateTime.now();
    final DateTime? expDate = DateTime.tryParse(expireDate);

    final bool outOfStock = quantity == 0;
    final bool lowStock = quantity > 0 && quantity <= 5;
    final bool isExpired = expDate != null && expDate.isBefore(now);
    final bool nearExpire =
        expDate != null &&
        expDate.isAfter(now) &&
        expDate.isBefore(now.add(const Duration(days: 30)));

    String formattedDate = expDate != null
        ? DateFormat("dd MMM yyyy").format(expDate)
        : "";

    if (outOfStock) {
      return Text(
        "Out of Stock",
        style: TextStyle(
          fontSize: 12.h,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (lowStock) {
      return _badge("Low Stock ($quantity left)", Colors.orange, Colors.orange);
    }
    if (isExpired) {
      return _badge("Expired ($formattedDate)", Colors.black, Colors.red);
    }
    if (nearExpire) {
      return _badge("Expire Soon ($formattedDate)", Colors.blue, Colors.blue);
    }
    return _badge("In Stock ($quantity)", Colors.green, Colors.green);
  }
}
