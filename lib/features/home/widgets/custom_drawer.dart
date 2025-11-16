import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    final r = Responsive.of(context);

    return Stack(
      children: [
        Drawer(
          width: r.height(0.3),

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
                    height: r.height(0.25),
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: theme.colorScheme.primary,
                            radius: r.height(0.04),
                            child: Text(
                              shopName.isNotEmpty ? shopName[0] : "S",
                              style: TextStyle(
                                fontSize: r.fontXL(),
                                color: theme.colorScheme.surface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          r.vSpace(0.015),
                          Text(
                            shopName,
                            style: TextStyle(
                              fontSize: r.fontSmall(),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: r.fontSmall() * 0.85,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.home,
                    title: 'Home'.tr,
                    onTap: () => Navigator.pop(context),
                    r: r,
                  ),
                  _drawerItem(
                    icon: Icons.edit,
                    title: 'Edit_Profile'.tr,
                    onTap: () => Navigator.pop(context),
                    r: r,
                  ),
                  _drawerItem(
                    icon: Icons.logout,
                    title: 'Logout'.tr,
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
                    r: r,
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
  }) {
    return ListTile(
      leading: Icon(icon, size: r.iconMedium(), color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: r.fontSmall()),
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
}
