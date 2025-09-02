import 'package:bikretaa/app/shared_preferences_helper.dart';
import 'package:bikretaa/app/theme_controller.dart';
import 'package:bikretaa/models/user/user_model.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/about_and_help/about_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/about_and_help/support_and_faqs_screen.dart';
import 'package:bikretaa/ui/screens/profile/profile_screen.dart';
import 'package:bikretaa/ui/screens/profile/update_profile.dart';
import 'package:bikretaa/ui/screens/signin_and_signup/signin/signin_screen.dart';
import 'package:bikretaa/ui/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/ui/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/ui/widgets/setting_widgets/section_box_widget.dart';
import 'package:bikretaa/ui/widgets/setting_widgets/section_title_widget.dart';
import 'package:bikretaa/ui/widgets/setting_widgets/setting_title_widget.dart';
import 'package:bikretaa/ui/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
  static const name = 'Setting_screen';
}

class _SettingScreenState extends State<SettingScreen> {
  final ThemeController _themeController = Get.find<ThemeController>();
  bool _pushNotifications = true;
  bool _orderAlerts = true;
  bool _lowStockAlerts = true;
  bool _language = true;
  bool _loading = false;
  String _appVersion = '';
  UserModel? _user;
  bool _userLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 24.sp)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        children: [
          // User Info Box
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: EdgeInsets.all(12.w),
            child: _userLoading
                ? Center(
                    child: SizedBox(
                      height: 24.h,
                      width: 24.h,
                      child: CenterCircularProgressIndiacator(),
                    ),
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: theme.colorScheme.secondary,
                        child: Text(
                          _user?.shopName.isNotEmpty == true
                              ? _user!.shopName[0].toUpperCase()
                              : 'S',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user?.shopName ?? 'Shop Name',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              _user?.email ?? 'Email',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: theme.colorScheme.primary,
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
                              builder: (context) => UpdateProfileScreen(),
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
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
              SettingsTileWidget(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your account password',
                onTap: () => _onTapChangePassword(),
              ),
            ],
          ),

          SectionTitleWidget(title: 'Language & Theme'),
          SectionBoxWidget(
            children: [
              SettingsTileWidget(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'Select your preferred app language',
                trailing: Switch(
                  value: _language,
                  onChanged: (v) => setState(() => _language = v),
                ),
              ),
              SettingsTileWidget(
                icon: Icons.dark_mode,
                title: 'Theme',
                subtitle: 'Switch between light and dark mode',
                trailing: Obx(() {
                  return Switch(
                    value: _themeController.isDarkMode.value,
                    onChanged: (value) {
                      _themeController.toggleTheme();
                    },
                  );
                }),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          // ABOUT & HELP
          SectionTitleWidget(title: 'About & Help'),
          SectionBoxWidget(
            children: [
              SettingsTileWidget(
                icon: Icons.support_agent,
                title: 'Support & FAQs',
                subtitle: 'Get help or contact support',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportFaqScreen()),
                  );
                },
              ),
              SettingsTileWidget(
                icon: Icons.info,
                title: 'About Us',
                subtitle: 'Learn more about Bikretaa',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                },
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
                  setState(() => _loading = true);
                  await _logout(context);
                  if (mounted) setState(() => _loading = false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // logout
  Future<void> _logout(BuildContext context) async {
    final ok = await showConfirmDialog(
      context: context,
      title: "Logout",
      content: "Are you sure you want to Logout?",
      confirmText: "Logout",
      confirmColor: Colors.red,
    );

    if (!ok) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CircularProgressIndicator2(),
    );

    try {
      await Future.delayed(const Duration(seconds: 2));

      await SharedPreferencesHelper.removeUser();
      await FirebaseAuth.instance.signOut();

      if (mounted) Navigator.pop(context);

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SigninScreen.name,
          (predicate) => false,
        );
      }
    } catch (e) {
      print("Logout error: $e");
      if (mounted) Navigator.pop(context);
    }
  }

  // password change
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
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);

        if (mounted) {
          showSnackbarMessage(
            context,
            "Password reset link sent to ${user.email}",
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          showSnackbarMessage(context, "Failed: ${e.message}");
        }
      } finally {}
    }
  }

  // app version
  void _loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  // load user information
  Future<void> _loadUser() async {
    UserModel? user = await SharedPreferencesHelper.getUser();
    if (mounted) {
      setState(() {
        _user = user;
        _userLoading = false;
      });
    }
  }
}
