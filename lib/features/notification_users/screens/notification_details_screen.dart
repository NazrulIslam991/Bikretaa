import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/products/widgets/copyable_text_widget.dart';
import 'package:bikretaa/features/setting/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final String alertTitle;

  const NotificationDetailsScreen({
    super.key,
    required this.product,
    required this.alertTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alert Details",
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
                product['image'] ?? '',
                width: double.infinity,
                height: responsive.height(0.22),
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: responsive.height(0.22),
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image, size: responsive.iconLarge(), color: Colors.grey),
                  );
                },
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: responsive.width(0.03)),
              color: Colors.redAccent.withOpacity(0.1),
              child: Text(
                alertTitle,
                textAlign: TextAlign.center,
                style: responsive.textStyle(
                  fontSize: responsive.fontMedium(),
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: responsive.height(0.01),
                horizontal: responsive.width(0.03),
              ),
              child: Text(
                product['productName'] ?? '',
                style: responsive.textStyle(
                  fontSize: responsive.fontLarge(),
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.width(0.03)),
              child: Text(
                "${"brand_name".tr} : ${product['brandName']}",
                style: responsive.textStyle(
                  fontSize: responsive.fontSmall(),
                  color: theme.colorScheme.primary,
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
              "${product['quantity']} unit",
              "product_code".tr,
              product['productId'] ?? '',
            ),
            Divider_widget(),
            _buildInfoRow(
              context,
              responsive,
              "purchase_price".tr,
              "${product['purchasePrice']} tk",
              "selling_price".tr,
              '${product['sellingPrice']} tk',
            ),
            Divider_widget(),
            _buildInfoRow(
              context,
              responsive,
              "supplier_name".tr,
              product['supplierName'] ?? '',
              "discount".tr,
              '${product['discountPrice']} tk',
            ),
            Divider_widget(),
            _buildInfoRow(
              context,
              responsive,
              "manufacture_date".tr,
              product['manufactureDate'] ?? '',
              "expiry_date".tr,
              product['expireDate'] ?? '',
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
                product['description'] ?? "No description available",
                textAlign: TextAlign.justify,
                style: responsive.textStyle(
                  fontSize: responsive.fontSmall(),
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Row Builder Helper
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title1, style: responsive.textStyle(fontSize: responsive.fontSmall(), color: Colors.grey.shade700)),
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
                    : Text(value1, style: responsive.textStyle(fontSize: responsive.fontSmall(), color: Colors.blue)),
              ],
            ),
          ),
          SizedBox(width: responsive.width(0.05)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title2, style: responsive.textStyle(fontSize: responsive.fontSmall(), color: Colors.grey.shade700)),
                SizedBox(height: responsive.height(0.008)),
                Text(value2, style: responsive.textStyle(fontSize: responsive.fontSmall(), color: Colors.blue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}