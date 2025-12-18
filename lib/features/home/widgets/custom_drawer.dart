import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/notification_users/screens/notification_screen_user.dart';
import 'package:bikretaa/features/setting/screens/setting_screen.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import '../../supports_and_faqs/screens/support_and_faqs_screen.dart';

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
    final isDark = theme.brightness == Brightness.dark;
    final r = Responsive.of(context);

    // Dynamic colors
    final drawerBgColor = isDark ? Colors.grey.shade900 : Colors.white;
    final headerBgColor = isDark
        ? Colors.grey.shade800
        : theme.colorScheme.surface;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[300] : Colors.grey[700];
    final iconColor = isDark ? Colors.white : Colors.black;

    return Stack(
      children: [
        Drawer(
          backgroundColor: drawerBgColor,
          width: r.height(0.26),
          child: FutureBuilder(
            future: SharedPreferencesHelper.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text(
                    "No user data found".tr,
                    style: TextStyle(color: textColor),
                  ),
                );
              }

              final user = snapshot.data!;
              final shopName = user.shopName;
              final email = user.email;

              return Column(
                children: [
                  // Drawer Header
                  SizedBox(
                    height: r.height(0.25),
                    width: r.height(0.26),
                    child: DrawerHeader(
                      decoration: BoxDecoration(color: headerBgColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: theme.colorScheme.primary,
                              radius: r.height(0.04),
                              child: Text(
                                shopName.isNotEmpty ? shopName[0] : "S",
                                style: TextStyle(
                                  fontSize: r.fontXL(),
                                  color: headerBgColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          r.vSpace(0.015),
                          Center(
                            child: Text(
                              shopName,
                              style: TextStyle(
                                fontSize: r.fontSmall(),
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              email,
                              style: TextStyle(
                                color: subTextColor,
                                fontSize: r.fontSmall() * 0.85,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Divider(color: isDark ? Colors.grey : Colors.black12),

                  // Drawer Menu Items (top)
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _drawerItem(
                          icon: Icons.home,
                          title: 'Home'.tr,
                          onTap: () => Navigator.pop(context),
                          r: r,
                          textColor: textColor,
                          iconColor: iconColor,
                        ),
                        _drawerItem(
                          icon: Icons.notifications,
                          title: 'notification'.tr,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreenUser(),
                              ),
                            );
                          },
                          r: r,
                          textColor: textColor,
                          iconColor: iconColor,
                        ),
                        _drawerItem(
                          icon: Icons.settings,
                          title: 'setting'.tr,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingScreen(),
                              ),
                            );
                          },
                          r: r,
                          textColor: textColor,
                          iconColor: iconColor,
                        ),
                        _drawerItem(
                          icon: Icons.help,
                          title: 'help'.tr,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupportFaqScreen(),
                              ),
                            );
                          },
                          r: r,
                          textColor: textColor,
                          iconColor: iconColor,
                        ),
                        _drawerItem(
                          icon: Icons.privacy_tip,
                          title: 'privacy_policy'.tr,
                          onTap: () => Navigator.pop(context),
                          r: r,
                          textColor: textColor,
                          iconColor: iconColor,
                        ),
                      ],
                    ),
                  ),

                  // Drawer Bottom Items
                  Column(
                    children: [
                      Divider(color: isDark ? Colors.grey : Colors.black12),
                      _drawerItem(
                        icon: Icons.lock,
                        title: 'change_password'.tr,
                        onTap: _onTapChangePassword,

                        r: r,
                        textColor: textColor,
                        iconColor: iconColor,
                      ),
                      Divider(color: isDark ? Colors.grey : Colors.black12),

                      _drawerItem(
                        icon: Icons.logout,
                        title: 'Logout'.tr,
                        onTap: () async {
                          //Navigator.pop(context);
                          final confirm = await showConfirmDialog(
                            context: context,
                            title: "Logout".tr,
                            content: "Are_you_sure_you_want_to_logout?".tr,
                            confirmText: "Logout".tr,
                            confirmColor: Colors.red,
                          );

                          if (confirm) {
                            setState(() => _loading = true);
                            await Future.delayed(
                              const Duration(milliseconds: 300),
                            );
                            await _logout(context);
                            if (mounted) setState(() => _loading = false);
                          }
                        },
                        r: r,
                        textColor: textColor,
                        iconColor: iconColor,
                      ),

                      SizedBox(height: r.height(0.01)),
                    ],
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

  ListTile _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Responsive r,
    required Color textColor,
    required Color iconColor,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon, size: r.iconMedium(), color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: r.fontSmall()),
      ),
      onTap: onTap,
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

  void _onTapChangePassword() async {
    Navigator.pop(context);
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final ok = await showConfirmDialog(
      context: context,
      title: "Reset_Password".tr,
      content: "${'Reset_Password_Message'.tr} ${user.email}?",
      confirmText: 'Send'.tr,
      confirmColor: Colors.blue,
    );

    if (ok) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);

        if (mounted) {
          showSnackbarMessage(
            context,
            "${"Password_Reset_Success".tr} ${user.email}",
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          showSnackbarMessage(context, "Failed: ${e.message}");
        }
      } finally {}
    }
  }
}
