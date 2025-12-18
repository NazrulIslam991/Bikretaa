import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/sales/screens/update_sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SalesHistoryCard extends StatelessWidget {
  final String customerName;
  final String customerMobile;
  final String customerAddress;
  final String paymentType;
  final int totalItems;
  final double totalCost;
  final double paidAmount;
  final double dueAmount;
  final double grandTotal;
  final String time;
  final String date;
  final String salesID;
  final String customerUID;

  const SalesHistoryCard({
    super.key,
    required this.customerName,
    required this.customerMobile,
    required this.customerAddress,
    required this.paymentType,
    required this.totalItems,
    required this.totalCost,
    required this.paidAmount,
    required this.dueAmount,
    required this.grandTotal,
    required this.time,
    required this.date,
    required this.salesID,
    required this.customerUID,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final res = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: res.height(0.01)),
      child: Container(
        padding: EdgeInsets.all(res.width(0.02)),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(res.radiusMedium()),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: res.width(0.005),
              blurRadius: res.width(0.01),
              offset: Offset(0, res.height(0.005)),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: res.textStyle(
                        fontSize: res.fontSmall(),
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      date,
                      style: res.textStyle(
                        fontSize: res.fontSmall(),
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: res.width(0.02)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        customerName,
                        style: res.textStyle(
                          fontSize: res.fontMedium(),
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        customerMobile,
                        style: res.textStyle(
                          fontSize: res.fontSmall(),
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Address: $customerAddress",
                        style: res.textStyle(
                          fontSize: res.fontSmall(),
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Text(
                  dueAmount == 0
                      ? 'Paid'
                      : 'Due: ${dueAmount.toStringAsFixed(2)} tk',
                  style: res.textStyle(
                    fontSize: res.fontSmall(),
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),

            SizedBox(height: res.height(0.01)),

            // Inner Container
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(res.width(0.015)),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(res.radiusSmall()),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildInfoRow(
                        res,
                        theme,
                        'Total Items',
                        totalItems.toString(),
                      ),
                      _buildInfoRow(
                        res,
                        theme,
                        'Total Cost',
                        'BDT ${totalCost.toStringAsFixed(2)} tk',
                      ),
                      _buildInfoRow(
                        res,
                        theme,
                        'Paid Amount',
                        '${paidAmount.toStringAsFixed(2)} tk',
                      ),
                      _buildInfoRow(
                        res,
                        theme,
                        'Due Amount',
                        'BDT ${dueAmount.toStringAsFixed(2)} tk',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sell ID : ',
                            style: res.textStyle(
                              fontSize: res.fontSmall(),
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            salesID,
                            style: res.textStyle(
                              fontSize: res.fontSmall(),
                              //fontStyle: FontStyle.italic,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(width: res.width(0.01)),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: salesID));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sales ID copied to clipboard'),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.copy,
                              size: res.iconSmall(),
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Edit button
                Positioned(
                  right: res.width(0.02),
                  top: res.height(0.005),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateSalesScreen(
                            salesID: salesID,
                            customerUID: customerUID,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(res.width(0.01)),
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: res.iconSmall(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    Responsive res,
    ThemeData theme,
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label : ',
          style: res.textStyle(
            fontSize: res.fontSmall(),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          value,
          style: res.textStyle(
            fontSize: res.fontSmall(),
            //fontStyle: FontStyle.italic,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
