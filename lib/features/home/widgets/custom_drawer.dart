import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Drawer(
          child: FutureBuilder(
            future: SharedPreferencesHelper.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text("No user data found".tr));
              }

              final user = snapshot.data!;
              final shopName = user.shopName;
              final email = user.email;

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: 160.h,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: theme.colorScheme.primary,
                            radius: 25.h,
                            child: Text(
                              shopName.isNotEmpty ? shopName[0] : "S",
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: theme.colorScheme.surface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            shopName,
                            style: TextStyle(
                              fontSize: 14.h,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 10.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home, size: 20.h, color: Colors.black),
                    title: Text(
                      'Home'.tr,
                      style: TextStyle(color: Colors.black, fontSize: 12.h),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.edit, size: 20.h, color: Colors.black),
                    title: Text(
                      'Edit_Profile'.tr,
                      style: TextStyle(color: Colors.black, fontSize: 12.h),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      size: 20.h,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Logout'.tr,
                      style: TextStyle(color: Colors.black, fontSize: 12.h),
                    ),
                    onTap: () async {
                      final confirm = await showConfirmDialog(
                        context: context,
                        title: "Logout".tr,
                        content: "Are_you_sure_you_want_to_logout?".tr,
                        confirmText: "Logout".tr,
                        confirmColor: Colors.red,
                      );

                      if (confirm) {
                        setState(() => _loading = true);
                        await Future.delayed(const Duration(milliseconds: 300));
                        await _logout(context);
                        if (mounted) setState(() => _loading = false);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
        if (_loading) const CircularProgressIndicator2(),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (route) => false,
    );
  }
}
