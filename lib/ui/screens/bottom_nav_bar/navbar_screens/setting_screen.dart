import 'package:bikretaa/database/signin_and_signup/shared_preferences_helper.dart';
import 'package:bikretaa/models/user_model.dart';
import 'package:bikretaa/ui/screens/profile/profile_screen.dart';
import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/widgets/confirm_dialog.dart';
import 'package:bikretaa/ui/widgets/setting_widgets/section_box_widget.dart';
import 'package:bikretaa/ui/widgets/setting_widgets/section_title_widget.dart';
import 'package:bikretaa/ui/widgets/setting_widgets/setting_title_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _pushNotifications = true;
  bool _orderAlerts = true;
  bool _lowStockAlerts = true;
  bool _loading = false;
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 24.sp)),
        centerTitle: true,
      ),
      body: FutureBuilder<UserModel?>(
        future: SharedPreferencesHelper.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          UserModel? user = snapshot.data;

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            children: [
              // User Info Box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      child: Text(
                        user?.shopName.isNotEmpty == true
                            ? user!.shopName[0].toUpperCase()
                            : 'S',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.shopName ?? 'Shop Name',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            user?.email ?? 'Email',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w),
                    FilledButton.tonal(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: Text('Edit', style: TextStyle(fontSize: 10.sp)),
                    ),
                  ],
                ),
              ),

              // ACCOUNT
              SectionTitleWidget(title: 'Account'),
              SectionBoxWidget(
                children: [
                  SettingsTileWidget(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    subtitle: 'Name, phone, address',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // NOTIFICATIONS
              SectionTitleWidget(title: 'Notifications'),
              SectionBoxWidget(
                children: [
                  SettingsTileWidget(
                    icon: Icons.notifications_active_outlined,
                    title: 'Push Notifications',
                    subtitle: 'Enable all notifications',
                    trailing: Switch(
                      value: _pushNotifications,
                      onChanged: (v) => setState(() => _pushNotifications = v),
                    ),
                  ),
                  SettingsTileWidget(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Expire date Alerts',
                    subtitle: 'Get notified before items expire',
                    trailing: Switch(
                      value: _orderAlerts,
                      onChanged: (v) => setState(() => _orderAlerts = v),
                    ),
                  ),
                  SettingsTileWidget(
                    icon: Icons.inventory_2_outlined,
                    title: 'Low Stock Alerts',
                    subtitle: 'Get notified when stock is low',
                    trailing: Switch(
                      value: _lowStockAlerts,
                      onChanged: (v) => setState(() => _lowStockAlerts = v),
                    ),
                  ),
                ],
              ),

              // SECURITY
              SectionTitleWidget(title: 'Security'),
              SectionBoxWidget(
                children: [
                  Visibility(
                    visible: !_loading,
                    child: SettingsTileWidget(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      subtitle: 'Update your account password',
                      onTap: () => _onTapChangePassword(),
                    ),
                  ),
                ],
              ),

              // ABOUT & HELP
              SectionTitleWidget(title: 'About & Help'),
              SectionBoxWidget(
                children: [
                  SettingsTileWidget(
                    icon: Icons.support_agent,
                    title: 'Support & FAQs',
                    subtitle: 'Get help or contact support',
                    onTap: () {},
                  ),
                  SettingsTileWidget(
                    icon: Icons.info,
                    title: 'About Us',
                    subtitle: 'Learn more about Bikretaa',
                    onTap: () {},
                  ),
                  SettingsTileWidget(
                    icon: Icons.info_outline,
                    title: 'App Version',
                    subtitle: _appVersion.isEmpty ? 'Loading...' : _appVersion,
                    onTap: () {},
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              // DANGER ZONE
              Text(
                'DANGER ZONE',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 6.h),
              SectionBoxWidget(
                children: [
                  SettingsTileWidget(
                    icon: Icons.logout,
                    title: 'Log out',
                    onTap: () async {
                      final ok = await showConfirmDialog(
                        context: context,
                        title: "Logout",
                        content: "Are you sure you want to logout?",
                        confirmText: "Logout",
                        confirmColor: Colors.red,
                      );
                      if (ok) {
                        setState(() => _loading = true);
                        await Future.delayed(Duration(milliseconds: 300));
                        await _logout(context);
                        if (mounted) setState(() => _loading = false);
                      }
                    },
                  ),
                  SettingsTileWidget(
                    icon: Icons.delete_forever_outlined,
                    title: 'Delete Account',
                    onTap: () async {
                      final ok = await showConfirmDialog(
                        context: context,
                        title: "Delete Account",
                        content:
                            "Are you sure you want to delete your account?",
                        confirmText: "Delete",
                        confirmColor: Colors.red,
                      );
                      if (ok) {
                        setState(() => _loading = true);
                        await Future.delayed(Duration(milliseconds: 300));
                        await _deleteAccount(context);
                        if (mounted) setState(() => _loading = false);
                      }
                    },
                    danger: true,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await SharedPreferencesHelper.removeUser();
    await FirebaseAuth.instance.signOut();

    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (route) => false,
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          await user.delete();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'requires-recent-login') {
            await FirebaseAuth.instance.signOut();
            await showConfirmDialog(
              context: context,
              title: "Re-login Required",
              content:
                  "Please log in again to delete your account from Firebase Auth.",
              confirmText: "Ok",
              confirmColor: Colors.blue,
            );
            return;
          } else {
            rethrow;
          }
        }

        await SharedPreferencesHelper.removeUser();

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninScreen.name,
            (route) => false,
          );
        }
      }
    } catch (e) {
      print("Unexpected error: $e");
    }
  }

  void _onTapChangePassword() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final ok = await showConfirmDialog(
      context: context,
      title: "Reset Password",
      content: "Do you want to send a password reset link to ${user.email}?",
      confirmText: "Send",
      confirmColor: Colors.blue,
    );

    if (ok) {
      setState(() => _loading = true);

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password reset link sent to ${user.email}"),
              backgroundColor: Colors.green,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed: ${e.message}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _loading = false);
      }
    }
  }

  void _loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }
}
