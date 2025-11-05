import 'package:bikretaa/features/products/database/product_database.dart';
import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:bikretaa/features/products/screens/update_product_screen.dart';
import 'package:bikretaa/features/products/widgets/copyable_text_widget.dart';
import 'package:bikretaa/features/setting/widgets/divider.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("product_details".tr, style: TextStyle(fontSize: 22.h)),
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
                fit: BoxFit.fill,
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
                style: TextStyle(
                  fontSize: 18.h,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
              child: Text(
                "${"brand_name".tr} : $brandName",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: theme.colorScheme.primary,
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
                top: 25.h,
                bottom: 10.h,
              ),
              child: Text(
                "product_information".tr,
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
                        "quantity_in_stock".tr,
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
                        "product_code".tr,
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CopyableText(
                        text: productId,
                        fontSize: 12.h,
                        textColor: Colors.blue,
                        iconSize: 18.h,
                        iconColor: Colors.blueGrey,
                        showSnackBar: true,
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
                        "upplier_name".tr,
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
                        "discount".tr,
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
                        "purchase_price".tr,
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
                        "selling_price".tr,
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
                        "manufacture_date".tr,
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
                        "expiry_date".tr,
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
                "product_description".tr,
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
                textAlign: TextAlign.justify,
                style: GoogleFonts.ibarraRealNova(
                  textStyle: TextStyle(
                    color: theme.colorScheme.primary,
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
                child: Text("edit".tr),
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
                child: Text("delete".tr),
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
      title: "delete_product".tr,
      content: "delete_confirmation".tr,
      confirmText: "delete".tr,
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

        showSnackbarMessage(context, "product_deleted_success".tr);
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        showSnackbarMessage(context, "Failed to delete: $e");
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
