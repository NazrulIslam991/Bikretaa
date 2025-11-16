import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProductFilter { all, lowStock, expired, expireSoon, aToZ, zToA }

typedef ProductFilterCallback = void Function(ProductFilter filter);

class ProductFilterSheet extends StatelessWidget {
  final ProductFilterCallback onFilterSelected;

  const ProductFilterSheet({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: r.height(0.45)),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(r.height(0.01)),
            topRight: Radius.circular(r.height(0.01)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: r.paddingMedium(),
                horizontal: r.paddingMedium(),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: r.width(0.1),
                      height: r.height(0.008),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(r.radiusSmall()),
                      ),
                    ),
                  ),
                  SizedBox(height: r.height(0.02)),
                  Center(
                    child: Text(
                      "filter_products".tr,
                      style: TextStyle(
                        fontSize: r.fontXL(),
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(height: r.height(0.015)),
                ],
              ),
            ),

            // Filter Options
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: r.paddingMedium()),
                child: Column(
                  children: ProductFilter.values.map((filter) {
                    String title;
                    IconData icon;
                    Color color;

                    switch (filter) {
                      case ProductFilter.all:
                        title = "all_products".tr;
                        icon = Icons.all_inbox;
                        color = Colors.blue;
                        break;
                      case ProductFilter.lowStock:
                        title = "low_stock".tr;
                        icon = Icons.warning;
                        color = Colors.orange;
                        break;
                      case ProductFilter.expired:
                        title = "expired".tr;
                        icon = Icons.block;
                        color = Colors.red;
                        break;
                      case ProductFilter.expireSoon:
                        title = "expire_soon".tr;
                        icon = Icons.timer;
                        color = Colors.purple;
                        break;
                      case ProductFilter.aToZ:
                        title = "a_to_z".tr;
                        icon = Icons.sort_by_alpha;
                        color = Colors.green;
                        break;
                      case ProductFilter.zToA:
                        title = "z_to_a".tr;
                        icon = Icons.sort_by_alpha;
                        color = Colors.indigo;
                        break;
                    }

                    return Card(
                      color: theme.cardColor,
                      elevation: 1,
                      shadowColor: Colors.blueAccent.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusMedium()),
                        side: BorderSide(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black54,
                          width: 1,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: r.height(0.008)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: r.height(0.001),
                          horizontal: r.width(0.02),
                        ),
                        leading: CircleAvatar(
                          radius: r.iconSmall(),
                          backgroundColor: color.withOpacity(0.15),
                          child: Icon(icon, color: color, size: r.iconSmall()),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: r.fontMedium(),
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: r.iconSmall(),
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        onTap: () {
                          onFilterSelected(filter);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
