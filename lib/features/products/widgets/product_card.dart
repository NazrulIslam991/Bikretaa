import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/products/screens/details_product_screen.dart';
import 'package:bikretaa/features/products/widgets/copyable_text_widget.dart';
import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    final DateTime now = DateTime.now();
    final DateTime? expDate = DateTime.tryParse(expireDate);
    final bool outOfStock = quantity == 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: theme.cardColor,
          elevation: 3,
          shadowColor: Colors.blueAccent.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.radiusMedium()),
          ),
          child: Padding(
            padding: EdgeInsets.all(r.paddingMedium()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(r.radiusSmall()),
                  child: Stack(
                    children: [
                      Image.network(
                        imagePath,
                        width: double.infinity,
                        height: r.height(0.12),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          height: r.height(0.12),
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: Icon(Icons.broken_image, size: r.iconMedium()),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: double.infinity,
                            height: r.height(0.12),
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

                      // Out of stock overlay
                      if (outOfStock)
                        Container(
                          width: double.infinity,
                          height: r.height(0.12),
                          color: Colors.red.withOpacity(0.35),
                          alignment: Alignment.center,
                          child: Text(
                            "OUT OF STOCK",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: r.fontLarge(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                r.vSpace(0.01),

                // Product Info
                Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: r.fontMedium(),
                    color: theme.colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                CopyableText(
                  text: productId,
                  fontSize: r.fontSmall(),
                  textColor: Colors.grey,
                  iconSize: r.iconSmall(),
                  iconColor: Colors.blue,
                ),

                r.vSpace(0.008),
                _buildStatusWidget(r),
                r.vSpace(0.008),

                // Price and Details
                // Price and Details Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Selling Price with fixed width
                    Flexible(
                      child: Text(
                        "${sellingPrice.toStringAsFixed(2)} tk",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: r.fontMedium(),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // "Show more..." button with fixed width
                    Flexible(
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
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, r.height(0.02)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Show more...",
                          style: GoogleFonts.abyssinicaSil(
                            textStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: r.fontSmall(),
                              letterSpacing: 0.3,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---- Badge Widget ----
  Widget _badge(String text, Color color, double fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fontSize * 0.8,
        vertical: fontSize * 0.3,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(fontSize),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // ---- Status Widget ----
  Widget _buildStatusWidget(Responsive r) {
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

    final double fontSmall = r.fontSmall();

    if (outOfStock) {
      return Text(
        "Out of Stock",
        style: TextStyle(
          fontSize: fontSmall,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (lowStock) {
      return _badge("Low Stock ($quantity left)", Colors.orange, fontSmall);
    }
    if (isExpired) {
      return _badge("Expired ($formattedDate)", Colors.red, fontSmall);
    }
    if (nearExpire) {
      return _badge("Expire Soon ($formattedDate)", Colors.blue, fontSmall);
    }
    return _badge("In Stock ($quantity)", Colors.green, fontSmall);
  }
}
