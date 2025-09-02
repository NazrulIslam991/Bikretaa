import 'package:bikretaa/app/shared_preferences_helper.dart';
import 'package:bikretaa/database/account_info_delete/account_info_delete.dart';
import 'package:bikretaa/ui/screens/signin_and_signup/signin/signin_screen.dart';
import 'package:bikretaa/ui/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/ui/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/ui/widgets/support_and_faqs/expansion_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text("Support & FAQs", style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(14.w),
            children: [
              Text(
                "Welcome to Bikretaa Support! Here you'll find answers to frequently asked questions and guides on using the app.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 20.h),

              // FAQ Cards
              ExpansionCard(
                title: "How to manage products?",
                description:
                    "Go to the Product screen and tap on 'Add Product' to enter new items. "
                    "You can set purchase price, selling price, stock quantity, expiry date, and discount. "
                    "All added products will be visible in the product screen.",
              ),
              ExpansionCard(
                title: "How to track sales?",
                description:
                    "Every sale is automatically recorded in the sales section. "
                    "You can view daily, weekly, and monthly reports with graphical charts for better analysis.",
              ),
              ExpansionCard(
                title: "How to manage low stock and expiry alerts?",
                description:
                    "Enable notifications from the Settings page. "
                    "The app will alert you whenever stock is low or products are near expiry.",
              ),
              ExpansionCard(
                title: "How to reset password?",
                description:
                    "Go to Settings > Security > Change Password. "
                    "A password reset link will be sent to your registered email.",
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
                    "Account Deletion",
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
                            "Deleting your account will have the following consequences:",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.error,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Your personal account information will be permanently removed. "
                            "All products you added will be deleted. "
                            "All sales history and payment records will be lost. "
                            "Due amounts and revenue data will no longer be accessible. "
                            "This action cannot be undone.",
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
                              'Delete Account',
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
                "Need More Help?",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,color: theme.colorScheme.primary),
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
                      // Title
                      Text(
                        "Email Support",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color:theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      // Email address in blue
                      Text(
                        "support@bikretaa.com",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      // User message / subtitle
                      Text(
                        "Send your queries to this email and our team will respond to you promptly.",
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
      title: "Delete Account",
      content: "Are you sure you want to delete your account?",
      confirmText: "Delete",
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
