import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class SalesSummaryCard extends StatelessWidget {
  final String amount;
  final String label;
  final Color bgColor;

  const SalesSummaryCard({
    super.key,
    required this.amount,
    required this.label,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final res = Responsive.of(context);

    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(res.radiusMedium()),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(res.paddingMedium()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: res.fontMedium(),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: res.height(0.005)),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: res.fontSmall(),
                      color: Colors.white,
                    ),
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
