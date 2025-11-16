import 'package:bikretaa/app/controller/theme_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/about_us/screens/about_screen.dart';
import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/profile/screens/profile_screen.dart';
import 'package:bikretaa/features/profile/screens/update_profile.dart';
import 'package:bikretaa/features/setting/widgets/setting_widgets/section_box_widget.dart';
import 'package:bikretaa/features/setting/widgets/setting_widgets/section_title_widget.dart';
import 'package:bikretaa/features/setting/widgets/setting_widgets/setting_title_widget.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:bikretaa/features/supports_and_faqs/screens/support_and_faqs_screen.dart';
import 'package:bikretaa/utils/app_version_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controller/language_controller.dart';

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
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: r.height(0.055),
        title: Text(
          'Settings'.tr,
          style: r.textStyle(fontSize: r.fontXL(), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: r.width(0.025),
          vertical: r.height(0.01),
        ),
        children: [
          // User Info Box
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(r.radiusMedium()),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: EdgeInsets.all(r.width(0.03)),
            child: _userLoading
                ? Center(
                    child: SizedBox(
                      height: r.height(0.03),
                      width: r.height(0.03),
                      child: const CenterCircularProgressIndiacator(),
                    ),
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        radius: r.width(0.05),
                        backgroundColor: theme.colorScheme.secondary,
                        child: Text(
                          _user?.shopName.isNotEmpty == true
                              ? _user!.shopName[0].toUpperCase()
                              : 'S',
                          style: r.textStyle(
                            fontSize: r.fontMedium(),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: r.width(0.03)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user?.shopName ?? 'Shop Name',
                              style: r.textStyle(
                                fontSize: r.fontLarge(),
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: r.height(0.005)),
                            Text(
                              _user?.email ?? 'Email',
                              style: r.textStyle(
                                fontSize: r.fontSmall(),
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: r.width(0.015)),
                      FilledButton.tonal(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProfileScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Edit'.tr,
                          style: r.textStyle(fontSize: r.fontSmall()),
                        ),
                      ),
                    ],
                  ),
          ),

          //SizedBox(height: r.height(0)),

          // ACCOUNT
          SectionTitleWidget(title: 'Account'.tr),
          SectionBoxWidget(
            children: [
              SettingsTileWidget(
                icon: Icons.person_outline,
                title: 'Profile'.tr,
                subtitle: 'Name_phone_address'.tr,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ],
          ),

          // SECURITY
          SectionTitleWidget(title: 'Security'.tr),
          SectionBoxWidget(
            children: [
              SettingsTileWidget(
                icon: Icons.lock_outline,
                title: 'Change_Password'.tr,
                subtitle: 'Update_your_account_password'.tr,
                onTap: () => _onTapChangePassword(),
              ),
            ],
          ),

          // NOTIFICATIONS
          SectionTitleWidget(title: 'Notifications'.tr),
          SectionBoxWidget(
            children: [
              SettingsTileWidget(
                icon: Icons.notifications_active_outlined,
                title: 'Push_Notifications'.tr,
                subtitle: 'Enable_all_notifications'.tr,
                trailing: Switch(
                  value: _pushNotifications,
                  onChanged: (v) => setState(() => _pushNotifications = v),
                ),
              ),
            ],
          ),

          // LANGUAGE & THEME
          SectionTitleWidget(title: 'Language_Theme'.tr),
          SectionBoxWidget(
            children: [
              GetBuilder<LanguageController>(
                builder: (langController) {
                  bool isBangla =
                      langController.currentLocale.languageCode == 'bn';
                  return SettingsTileWidget(
                    icon: Icons.language,
                    title: 'Language'.tr,
                    subtitle: isBangla ? 'বাংলা' : 'English',
                    trailing: Switch(
                      value: isBangla,
                      onChanged: (v) {
                        langController.changeLocale(
                          v
                              ? const Locale('bn', 'BD')
                              : const Locale('en', 'US'),
                        );
                      },
                    ),
                  );
                },
              ),
              // THEME SWITCH
              Obx(() {
                bool isDark = _themeController.isDarkMode.value;
                return SettingsTileWidget(
                  icon: isDark ? Icons.dark_mode : Icons.light_mode,
                  title: 'Theme'.tr,
                  subtitle: isDark
                      ? 'Dark_mode_is_active'.tr
                      : 'Light_mode_is_active'.tr,
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      _themeController.toggleTheme();
                    },
                  ),
                );
              }),
            ],
          ),

          //SizedBox(height: r.height(0.02)),

          // ABOUT & HELP
          SectionTitleWidget(title: 'About_Help'.tr),
          SectionBoxWidget(
            children: [
              SettingsTileWidget(
                icon: Icons.support_agent,
                title: 'Support_FAQs'.tr,
                subtitle: 'Get_help_or_contact_support'.tr,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportFaqScreen()),
                  );
                },
              ),
              SettingsTileWidget(
                icon: Icons.info,
                title: 'About_Us'.tr,
                subtitle: 'Learn_more_about_Bikretaa'.tr,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                },
              ),
              SettingsTileWidget(
                icon: Icons.info_outline,
                title: 'App_Version'.tr,
                subtitle:
                    "${'version'.tr}: ${AppVersionServces.currentAppVersion}",
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: r.height(0.02)),

          // DANGER ZONE
          Text(
            'DANGER_ZONE'.tr,
            style: r.textStyle(
              fontSize: r.fontSmall(),
              fontWeight: FontWeight.w700,
              color: Colors.red,
              height: 1.2,
            ),
          ),
          SizedBox(height: r.height(0.01)),
          SectionBoxWidget(
            children: [
              SettingsTileWidget(
                icon: Icons.logout,
                title: 'Log_out'.tr,
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
      title: "Logout".tr,
      content: 'Are_you_sure_you_want_to_Logout'.tr,
      confirmText: "Logout".tr,
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
