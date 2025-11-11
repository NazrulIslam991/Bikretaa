import 'package:bikretaa/app/controller/language_controller.dart';
import 'package:bikretaa/app/controller/theme_controller.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/dashboard_admin/widgets/activities_card_widget_admin.dart';
import 'package:bikretaa/features/dashboard_admin/widgets/info_card_admin.dart';
import 'package:bikretaa/features/dashboard_admin/widgets/kpi_admin_widget.dart';
import 'package:bikretaa/features/dashboard_admin/widgets/quick_action_card_admin.dart';
import 'package:bikretaa/features/dashboard_admin/widgets/section_tile_widget_admin.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final theme = Theme.of(context);

    final ThemeController themeController = Get.find<ThemeController>();

    // Logout helper used by the profile button
    Future<void> _handleLogout() async {
      final confirm = await showConfirmDialog(
        context: context,
        title: 'Logout'.tr,
        content: 'Are_you_sure_you_want_to_logout?'.tr,
        confirmText: 'Logout'.tr,
        confirmColor: Colors.red,
      );

      if (!confirm) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const CircularProgressIndicator2(),
      );

      try {
        await Future.delayed(const Duration(milliseconds: 300));

        await SharedPreferencesHelper.removeUser();
        await FirebaseAuth.instance.signOut();

        Navigator.pop(context);

        Navigator.pushNamedAndRemoveUntil(
          context,
          SigninScreen.name,
          (route) => false,
        );
      } catch (e) {
        try {
          Navigator.pop(context);
        } catch (_) {}
        Get.snackbar('Error', 'Logout_failed'.tr);
      }
    }

    final kpiItems = [
      {
        "icon": Icons.shop,
        "label": "Shop",
        "value": "1.2k",
        "color": theme.colorScheme.primary,
      },
      {
        "icon": Icons.task,
        "label": "Active Shop",
        "value": "342",
        "color": Colors.green,
      },
      {
        "icon": Icons.report,
        "label": "Deactive Shop",
        "value": "27",
        "color": Colors.redAccent,
      },
      {
        "icon": Icons.insights,
        "label": "Analytics",
        "value": "95%",
        "color": Colors.orange,
      },
    ];

    final activities = [
      {
        "icon": Icons.verified,
        "text": "New admin approved",
        "time": "2 hours ago",
        "color": Colors.green,
      },
      {
        "icon": Icons.block,
        "text": "User john@email.com suspended",
        "time": "4 hours ago",
        "color": Colors.red,
      },
      {
        "icon": Icons.check_circle,
        "text": "Settings updated",
        "time": "6 hours ago",
        "color": Colors.blue,
      },
      {
        "icon": Icons.report,
        "text": "New system report received",
        "time": "8 hours ago",
        "color": Colors.orange,
      },
    ];

    final quickActions = [
      {"icon": Icons.person, "label": "Shop", "color": Colors.blue},
      {"icon": Icons.analytics, "label": "Analytics", "color": Colors.green},
      {"icon": Icons.report, "label": "Reports", "color": Colors.orange},
      {"icon": Icons.settings, "label": "Settings", "color": Colors.purple},
      {"icon": Icons.message, "label": "Messages", "color": Colors.red},
      {
        "icon": Icons.notifications,
        "label": "Notifications",
        "color": Colors.teal,
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  "Admin Dashboard",
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w700,
                    color: theme.textTheme.titleLarge?.color,
                  ),
                ),
                // Optional Subtitle
                Text(
                  "Overview & insights",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            actions: [
              GetBuilder<LanguageController>(
                builder: (lc) {
                  final isBn = lc.currentLocale.languageCode == 'bn';
                  return GestureDetector(
                    onTap: () {
                      lc.changeLocale(
                        isBn
                            ? const Locale('en', 'US')
                            : const Locale('bn', 'BD'),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: theme.dividerColor.withAlpha(
                            (0.2 * 255).round(),
                          ),
                        ),
                      ),
                      child: Text(
                        isBn ? 'BN' : 'EN',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 6.w),

              Obx(() {
                return IconButton(
                  onPressed: () => themeController.toggleTheme(),
                  icon: Icon(
                    themeController.isDarkMode.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: theme.textTheme.bodyLarge?.color,
                    size: 20.sp,
                  ),
                );
              }),
              // Profile / Logout
              IconButton(
                onPressed: _handleLogout,
                icon: Icon(
                  Icons.person_outline,
                  color: theme.textTheme.bodyLarge?.color,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KPI Section
              SectionTitle(title: "Key Performance Indicators"),
              SizedBox(height: 8.h),
              SizedBox(
                height: 52.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: kpiItems.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (context, index) {
                    final item = kpiItems[index];
                    return KPIWidget(
                      icon: item['icon'] as IconData,
                      label: item['label'] as String,
                      value: item['value'] as String,
                      color: item['color'] as Color,
                    );
                  },
                ),
              ),
              SizedBox(height: 14.h),

              // Quick Actions
              SectionTitle(title: "Quick Actions"),
              SizedBox(height: 8.h),
              SizedBox(
                height: 55.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: quickActions.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (context, index) {
                    final action = quickActions[index];
                    return QuickActionCard(
                      icon: action['icon'] as IconData,
                      label: action['label'] as String,
                      color: action['color'] as Color,
                      onTap: () {},
                    );
                  },
                ),
              ),

              SizedBox(height: 14.h),
              SectionTitle(title: "Monitoring"),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      icon: Icons.speed,
                      title: 'App Performance',
                      subtitle: 'Avg load 1.2s • DB 120ms',
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.bug_report,
                      title: 'Crash & Errors',
                      subtitle: '2 crashes • 5 errors today',
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              InfoCard(
                icon: Icons.insights,
                title: 'Performance & Activity Analytics',
                subtitle: 'User activity, retention & usage',
                color: Colors.orange,
                isFullWidth: true,
              ),

              SizedBox(height: 14.h),
              SectionTitle(title: "Recent Activities"),
              SizedBox(height: 8.h),
              ActivitiesCard(activities: activities),
            ],
          ),
        ),
      ),
    );
  }
}
