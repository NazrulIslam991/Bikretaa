import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDeletionCard extends StatelessWidget {
  final ThemeData theme;
  final VoidCallback onDelete;

  const AccountDeletionCard({
    super.key,
    required this.theme,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      color: theme.cardColor,
      child: ExpansionTile(
        title: Text(
          "account_deletion".tr,
          style: r.textStyle(
            fontSize: r.fontMedium(),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.error,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(r.paddingMedium()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "account_deletion_warning".tr,
                  style: r.textStyle(
                    fontSize: r.fontSmall(),
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.error,
                  ),
                ),
                r.vSpace(0.01),
                Text(
                  "account_deletion_desc".tr,
                  style: r
                      .textStyle(
                        fontSize: r.fontMedium(),
                        color: theme.colorScheme.primary,
                      )
                      .copyWith(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.justify,
                ),
                r.vSpace(0.015),
                ElevatedButton.icon(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    minimumSize: Size(double.infinity, r.height(0.06)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(r.radiusSmall()),
                    ),
                  ),
                  icon: Icon(Icons.delete_forever, size: r.iconMedium()),
                  label: Text(
                    'delete_account'.tr,
                    style: r.textStyle(
                      fontSize: r.fontMedium(),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
