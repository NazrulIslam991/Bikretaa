import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/products/database/product_database.dart';
import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:bikretaa/features/products/screens/update_product_screen.dart';
import 'package:bikretaa/features/products/widgets/copyable_text_widget.dart';
import 'package:bikretaa/features/setting/widgets/divider.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    //final ProductDatabase _deleteProduct = ProductDatabase();
    final theme = Theme.of(context);
    final responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "product_details".tr,
          style: responsive.textStyle(fontSize: responsive.fontXL()),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(responsive.radiusSmall()),
              child: Image.network(
                imagePath,
                width: double.infinity,
                height: responsive.height(0.22),
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: double.infinity,
                    height: responsive.height(0.22),
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
                    height: responsive.height(0.22),
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image,
                      size: responsive.iconLarge(),
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: responsive.height(0.01),
                horizontal: responsive.width(0.03),
              ),
              child: Text(
                productName,
                style: responsive.textStyle(
                  fontSize: responsive.fontLarge(),
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: responsive.width(0.03),
              ),
              child: Text(
                "${"brand_name".tr} : $brandName",
                style: responsive.textStyle(
                  fontSize: responsive.fontSmall(),
                  color: theme.colorScheme.primary,
                  //fontStyle: FontStyle.italic,
                  //letterSpacing: 0.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: responsive.width(0.05),
                left: responsive.width(0.05),
                top: responsive.height(0.03),
                bottom: responsive.height(0.015),
              ),
              child: Text(
                "product_information".tr,
                style: responsive.textStyle(
                  fontSize: responsive.fontMedium(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider_widget(),
            _buildInfoRow(
              context,
              responsive,
              "quantity_in_stock".tr,
              "$quantity unit",
              "product_code".tr,
              productId,
            ),
            Divider_widget(),
            _buildInfoRow(
              context,
              responsive,
              "purchase_price".tr,
              "$purchasePrice tk",
              "selling_price".tr,
              '$sellingPrice tk',
            ),
            Divider_widget(),

            _buildInfoRow(
              context,
              responsive,
              "supplier_name".tr,
              supplierName,
              "discount".tr,
              '$discountPrice tk',
            ),
            Divider_widget(),
            _buildInfoRow(
              context,
              responsive,
              "manufacture_date".tr,
              manufactureDate,
              "expiry_date".tr,
              expireDate,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: responsive.width(0.05),
                left: responsive.width(0.05),
                top: responsive.height(0.02),
                bottom: responsive.height(0.01),
              ),
              child: Text(
                "product_description".tr,
                style: responsive.textStyle(
                  fontSize: responsive.fontMedium(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.width(0.05),
                vertical: responsive.height(0.005),
              ),
              child: Text(
                description,
                textAlign: TextAlign.justify,
                style: responsive.textStyle(
                  fontSize: responsive.fontSmall(),
                  color: theme.colorScheme.primary,
                  // letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(responsive.width(0.03)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              //height: responsive.height(0.06),
              width: responsive.width(0.25),
              child: ElevatedButton(
                onPressed: () {
                  _onTapEdit(context);
                },
                child: Text(
                  "edit".tr,
                  style: responsive.textStyle(
                    fontSize: responsive.fontMedium(),
                  ),
                ),
              ),
            ),
            SizedBox(
              //height: responsive.height(0.06),
              width: responsive.width(0.25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _onTapDelete(context);
                },
                child: Text(
                  "delete".tr,
                  style: responsive.textStyle(
                    fontSize: responsive.fontMedium(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    Responsive responsive,
    String title1,
    String value1,
    String title2,
    String value2,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.width(0.05),
        vertical: responsive.height(0.012),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title1,
                  style: responsive.textStyle(
                    fontSize: responsive.fontSmall(),
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: responsive.height(0.008)),
                title1 == "product_code".tr
                    ? CopyableText(
                        text: value1,
                        fontSize: responsive.fontSmall(),
                        textColor: Colors.blue,
                        iconSize: responsive.iconSmall(),
                        iconColor: Colors.blueGrey,
                        showSnackBar: true,
                      )
                    : Text(
                        value1,
                        style: responsive.textStyle(
                          fontSize: responsive.fontSmall(),
                          color: Colors.blue,
                        ),
                      ),
              ],
            ),
          ),

          // Vertical divider between the two sides
          SizedBox(width: responsive.width(0.05)),

          // Right side info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title2,
                  style: responsive.textStyle(
                    fontSize: responsive.fontSmall(),
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: responsive.height(0.008)),
                Text(
                  value2,
                  style: responsive.textStyle(
                    fontSize: responsive.fontSmall(),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
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
