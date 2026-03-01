import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class HomePageSalesSummaryCard extends StatelessWidget {
  final String label;
  final double amount;

  const HomePageSalesSummaryCard({
    super.key,
    required this.label,
    required this.amount,
  });

  // Assign card colors based on label
  Color get bgColor {
    switch (label.toLowerCase()) {
      case 'sales':
        return const Color(0xFFFFC727);
      case 'revenue':
        return const Color(0xFF10B981);
      case 'paid':
        return const Color(0xFFFFC727);
      case 'due':
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '৳ ${amount.toStringAsFixed(2)}',
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
