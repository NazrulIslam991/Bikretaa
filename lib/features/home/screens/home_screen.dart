import 'package:bikretaa/features/dashboard_admin/widgets/section_tile_widget_admin.dart';
import 'package:bikretaa/features/home/widgets/action_card.dart';
import 'package:bikretaa/features/home/widgets/custom_drawer.dart';
import 'package:bikretaa/features/home/widgets/home_banner.dart';
import 'package:bikretaa/features/home/widgets/kpi_widget_cart.dart';
import 'package:bikretaa/features/home/widgets/weather_widgets.dart';
import 'package:bikretaa/features/products/screens/add_product_screen.dart';
import 'package:bikretaa/features/sales/screens/due_collection_screen.dart';
import 'package:bikretaa/features/shared/presentation/widgets/notification_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSlider {
  final String assetPath;
  HomeSlider({required this.assetPath});
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // Sample sliders
  final List<HomeSlider> sliders = [
    HomeSlider(assetPath: 'assets/images/slider_1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        titleSpacing: 16.w,
        toolbarHeight: 52.h,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bikretaa',
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Your smart business partner',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            WeatherChip(),
            NotificationIcon(count: 1),
          ],
        ),
      ),
      drawer: SizedBox(width: 240.w, child: CustomDrawer()),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeBannerSlider(sliders: sliders),
            SizedBox(height: 8.h),
            SectionTitle(title: "Today's Summary"),
            SizedBox(height: 8.h),

            // KPI Cards
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        title: 'Sales',
                        value: '৳45,000',
                        icon: Icons.trending_up,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: KpiCard(
                        title: 'Revenues',
                        value: '৳5,000',
                        icon: Icons.attach_money,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        title: 'Paid',
                        value: '৳35,000',
                        icon: Icons.payment,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: KpiCard(
                        title: 'Due',
                        value: '৳10,000',
                        icon: Icons.account_balance_wallet,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Stock & Inventory Actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Stock & Inventory
                SectionTitle(title: "Stock & Inventory Actions"),
                SizedBox(height: 8.h),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ActionCard(
                            icon: Icons.inventory_2_outlined,
                            title: "All Products",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.add_box_outlined,
                            title: "Add Product",
                            onTap: () => Navigator.pushNamed(
                              context,
                              AddProductScreen.name,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.shopping_bag_outlined,
                            title: "Record Sale",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.money_off,
                            title: "Due Collection",
                            onTap: () => Navigator.pushNamed(
                              context,
                              DueCollectionScreen.name,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: ActionCard(
                            icon: Icons.error_outline,
                            title: "Expired Products",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.warning_amber_rounded,
                            title: "Low Stock",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.schedule,
                            title: "Expire Soon",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.adjust,
                            title: "Stock Adjustment",
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Section 2: Sales & Product History
                SectionTitle(title: "Sales & Product History"),
                SizedBox(height: 8.h),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ActionCard(
                            icon: Icons.history,
                            title: "Last Week Sales",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.calendar_month,
                            title: "Last Month Sales",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.date_range,
                            title: "Fixed Date Sales",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ActionCard(
                            icon: Icons.list_alt,
                            title: "All Products List",
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12.h),
            SectionTitle(title: "Business Tools"),
            SizedBox(height: 8.h),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        icon: Icons.store_mall_directory,
                        title: "Branch Mgmt",
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ActionCard(
                        icon: Icons.schedule_outlined,
                        title: "Expiry Track",
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ActionCard(
                        icon: Icons.backup_outlined,
                        title: "Auto Backup",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        icon: Icons.notifications_active_outlined,
                        title: "Alerts",
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ActionCard(
                        icon: Icons.support_agent_outlined,
                        title: "Support",
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ActionCard(
                        icon: Icons.flash_on_outlined,
                        title: "AI Suggest",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
