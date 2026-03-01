import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class ProductInfoPage extends StatelessWidget {
  final String productInfo;
  const ProductInfoPage({super.key, required this.productInfo});
  static const name = '/qr_Product_info';

  @override
  Widget build(BuildContext context) {
    final List<String> fields = productInfo.split('\n');
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Information",
          style: r.textStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(r.paddingMedium()),
        child: ListView.builder(
          itemCount: fields.length,
          itemBuilder: (context, index) {
            final field = fields[index];
            final parts = field.split(':');
            final title = parts.first.trim();
            final value = parts.length > 1
                ? parts.sublist(1).join(':').trim()
                : '';

            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: r.paddingSmall()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(r.radiusMedium()),
              ),
              color: theme.cardColor,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: r.paddingMedium(),
                  vertical: r.paddingSmall(),
                ),
                title: Text(
                  title,
                  style: r.textStyle(
                    fontSize: r.fontMedium(),
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                subtitle: Text(
                  value,
                  style: r.textStyle(
                    fontSize: r.fontSmall(),
                    color: theme.textTheme.titleSmall?.color,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
