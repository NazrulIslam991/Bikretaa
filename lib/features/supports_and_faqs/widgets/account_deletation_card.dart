import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: theme.cardColor,
      child: ExpansionTile(
        title: Text(
          "account_deletion".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.error,
            fontSize: 15.sp,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "account_deletion_warning".tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "account_deletion_desc".tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: theme.colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 12.h),
                ElevatedButton.icon(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    minimumSize: Size(double.infinity, 22.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  icon: const Icon(Icons.delete_forever),
                  label: Text(
                    'delete_account'.tr,
                    style: TextStyle(fontSize: 14.sp),
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
