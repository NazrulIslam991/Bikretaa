import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/features/supports_and_faqs/database/account_info_delete.dart';
import 'package:bikretaa/features/supports_and_faqs/widgets/expansion_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SupportFaqScreen extends StatefulWidget {
  const SupportFaqScreen({super.key});

  @override
  State<SupportFaqScreen> createState() => _SupportFaqScreenState();
}

class _SupportFaqScreenState extends State<SupportFaqScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("support_faqs".tr, style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(14.w),
            children: [
              Text(
                "support_welcome".tr,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 20.h),

              // FAQ Cards
              ExpansionCard(
                title: "faq_manage_products_title".tr,
                description: "faq_manage_products_desc".tr,
              ),
              ExpansionCard(
                title: "faq_track_sales_title".tr,
                description: "faq_track_sales_desc".tr,
              ),
              ExpansionCard(
                title: "faq_stock_alerts_title".tr,
                description: "faq_stock_alerts_desc".tr,
              ),
              ExpansionCard(
                title: "faq_reset_password_title".tr,
                description: "faq_reset_password_desc".tr,
              ),

              SizedBox(height: 5.h),

              // Account Deletion Section
              Card(
                margin: EdgeInsets.only(bottom: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
                color: theme.cardColor,
                child: ExpansionTile(
                  title: Text(
                    "account_deletion".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.error,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "account_deletion_warning".tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.error,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "account_deletion_desc".tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: theme.colorScheme.primary,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 10.h),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red.shade700,
                              minimumSize: Size(double.infinity, 30.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () async {
                              setState(() => _loading = true);
                              await _deleteAccount(context);
                              if (mounted) setState(() => _loading = false);
                            },
                            child: Text(
                              'delete_account'.tr,
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Help Section
              Text(
                "need_more_help".tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 8.h),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                color: theme.cardColor,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "email_support".tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "support@bikretaa.com",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "email_support_desc".tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final ok = await showConfirmDialog(
      context: context,
      title: "delete_account".tr,
      content: "delete_account_confirm".tr,
      confirmText: "delete_account".tr,
      confirmColor: Colors.red,
    );

    if (!ok) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CircularProgressIndicator2(),
    );

    final _deleteAccountInfo = DeleteAccountHelper();

    try {
      await _deleteAccountInfo.deleteAll();
      await SharedPreferencesHelper.removeUser();

      if (mounted) Navigator.pop(context);

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SigninScreen.name,
          (predicate) => false,
        );
      }
    } catch (e) {
      print("Unexpected error: $e");
      if (mounted) Navigator.pop(context);
    }
  }
}
