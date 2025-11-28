import 'package:bikretaa/app/controller/quick_action_controller.dart';
import 'package:bikretaa/app/controller/sales_summary_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/dashboard_admin/widgets/section_tile_widget_admin.dart';
import 'package:bikretaa/features/home/widgets/action_button.dart';
import 'package:bikretaa/features/home/widgets/custom_drawer.dart';
import 'package:bikretaa/features/home/widgets/expire_noties_widgets.dart';
import 'package:bikretaa/features/home/widgets/summary_card.dart';
import 'package:bikretaa/features/home/widgets/weather_widgets.dart';
import 'package:bikretaa/features/shared/presentation/widgets/notification_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/get_business_tools_action_screen.dart';
import '../widgets/get_quick_action_screen.dart';
import '../widgets/home_banner.dart' show HomeBannerSlider;
import '../widgets/report_item.dart';

class HomeSlider {
  final String assetPath;
  HomeSlider({required this.assetPath});
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HomeSlider> sliders = [
    HomeSlider(assetPath: 'assets/images/slider_1.png'),
  ];

  final QuickActionController quickActionController = Get.put(
    QuickActionController(),
  );

  final List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.add_box, "title": "Add Product"},
    {"icon": Icons.inventory_2, "title": "All Products"},
    {"icon": Icons.event_busy, "title": "Expired Date"},
    {"icon": Icons.access_time_filled, "title": "Expire Soon"},
    {"icon": Icons.point_of_sale, "title": "Record Sale"},
    {"icon": Icons.warning_amber_rounded, "title": "Low Stock"},
    {"icon": Icons.stacked_line_chart, "title": "Last Month Sales"},
    {"icon": Icons.bar_chart, "title": "Last Week Sales"},
    {"icon": Icons.build_circle_outlined, "title": "Stock Adjust"},
    {"icon": Icons.account_balance_wallet, "title": "Due Collection"},
  ];

  final List<Map<String, dynamic>> businessTools = [
    {"icon": Icons.smart_toy_outlined, "title": "AI ChatBot"},
    {"icon": Icons.calculate_outlined, "title": "Calculator"},
    {"icon": Icons.calendar_month_outlined, "title": "Calender"},
    {"icon": Icons.support_agent, "title": "Customer Support"},
    {"icon": Icons.notes_outlined, "title": "Notes"},
    {"icon": Icons.print_outlined, "title": "Print"},
    {"icon": Icons.qr_code, "title": "QR Generator"},
    {"icon": Icons.qr_code_scanner, "title": "QR Scanner"},
    {"icon": Icons.description_outlined, "title": "Statement"},
    {"icon": Icons.swap_horiz_outlined, "title": "Unit Converter"},
  ];

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final summary = Get.find<SalesSummaryController>();

    Color containerBg(Color light, Color dark) => isDark ? dark : light;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        titleSpacing: r.width(0.04),
        toolbarHeight: r.height(0.09),
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
                      fontSize: r.fontXL(),
                      fontWeight: FontWeight.w700,
                      color: theme.textTheme.titleLarge!.color,
                    ),
                  ),
                  SizedBox(height: r.height(0.005)),
                  Text(
                    'Your smart business partner',
                    style: TextStyle(
                      fontSize: r.fontMedium(),
                      fontWeight: FontWeight.w300,
                      color: theme.textTheme.titleSmall!.color,
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
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: containerBg(Color(0xffF5F9F4), Colors.black),
          padding: EdgeInsets.all(r.paddingMedium()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeBannerSlider(sliders: sliders),
              SizedBox(height: r.height(0.015)),

              SectionTitle(title: "Today's Summary"),
              SizedBox(height: r.height(0.01)),

              /// ---------------- SUMMARY CARDS ----------------
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => SummaryCard(
                        r: r,
                        icon: Icons.trending_up,
                        color: Color(0xff2DBE79),
                        title: "Sales",
                        value:
                            "৳${summary.todaySales.value.toStringAsFixed(2)}",
                      ),
                    ),
                  ),
                  SizedBox(width: r.width(0.03)),
                  Expanded(
                    child: Obx(
                      () => SummaryCard(
                        r: r,
                        icon: Icons.trending_down,
                        color: Colors.red,
                        title: "Revenue",
                        value:
                            "৳${summary.todayRevenue.value.toStringAsFixed(2)}",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.height(0.02)),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => SummaryCard(
                        r: r,
                        icon: Icons.bar_chart,
                        color: Color(0xff5CC0FF),
                        title: "Paid",
                        value: "৳${summary.todayPaid.value.toStringAsFixed(2)}",
                      ),
                    ),
                  ),
                  SizedBox(width: r.width(0.03)),
                  Expanded(
                    child: Obx(
                      () => SummaryCard(
                        r: r,
                        icon: Icons.attach_money,
                        color: Color(0xff66D0FF),
                        title: "Due",
                        value: "৳${summary.todayDue.value.toStringAsFixed(2)}",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.height(0.02)),

              SectionTitle(title: "Expiration Alerts"),
              SizedBox(height: r.height(0.01)),

              /// -------- Expiry Notice --------
              ExpiryNotice(
                r: r,
                message: "৫টি পণ্য মেয়াদ উত্তীর্ণ হয়েছে! এখনই দেখুন",
                onViewTap: () {},
              ),
              SizedBox(height: r.height(0.02)),

              /// ---------- Quick Actions ----------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.width(0.02)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionTitle(title: "Quick Actions"),
                    Container(
                      height: r.width(0.06),
                      width: r.width(0.06),
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {
                            openEditPopup();
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: r.iconSmall(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: r.height(0.01)),

              /// ---------- Quick Actions Grid ----------
              Container(
                padding: EdgeInsets.only(
                  top: r.paddingXLarge(),
                  bottom: r.paddingMedium(),
                  left: r.paddingMedium(),
                  right: r.paddingMedium(),
                ),
                decoration: BoxDecoration(
                  color: containerBg(Colors.white, Colors.grey.shade900),
                  borderRadius: BorderRadius.circular(r.radiusLarge()),
                ),
                child: Obx(() {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemCount: quickActionController.selectedIndexes.length,
                    itemBuilder: (context, index) {
                      final selectedIndex =
                          quickActionController.selectedIndexes[index];
                      final tool = quickActions[selectedIndex];
                      return ActionButton(
                        r: r,
                        icon: tool['icon'],
                        title: tool['title'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  getQuickActionScreenByTitle(tool['title']),
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ),

              SizedBox(height: r.height(0.02)),

              /// ---------- Sales & Reports ----------
              SectionTitle(title: "Sales & Reports"),
              SizedBox(height: r.height(0.01)),
              ReportItem(r: r, title: "Last Week Sales"),
              ReportItem(r: r, title: "Last Month Sales"),
              ReportItem(r: r, title: "Fixed Date Sales"),
              ReportItem(r: r, title: "All Products Report"),
              SizedBox(height: r.height(0.03)),

              /// ---------- Business Tools ----------
              SectionTitle(title: "Business Tools"),
              SizedBox(height: r.height(0.01)),

              Container(
                padding: EdgeInsets.only(
                  top: r.paddingXLarge(),
                  bottom: r.paddingMedium(),
                  left: r.paddingMedium(),
                  right: r.paddingMedium(),
                ),
                decoration: BoxDecoration(
                  color: containerBg(Colors.white, Colors.grey.shade900),
                  borderRadius: BorderRadius.circular(r.radiusLarge()),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemCount: businessTools.length,
                  itemBuilder: (context, index) {
                    final tool = businessTools[index];
                    return ActionButton(
                      r: r,
                      icon: tool['icon'],
                      title: tool['title'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                getBusinessToolScreenByTitle(tool['title']),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openEditPopup() {
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bgColor = isDark ? Colors.grey.shade900 : Colors.white;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color buttonColor = isDark ? Colors.lightBlueAccent : Colors.blue;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: bgColor,
      builder: (context) {
        List<int> tempSelected = List.from(
          quickActionController.selectedIndexes,
        );

        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Padding(
              padding: EdgeInsets.all(r.paddingMedium()),
              child: SizedBox(
                height: r.height(0.5),
                child: Column(
                  children: [
                    Text(
                      "Select Quick Actions",
                      style: TextStyle(
                        fontSize: r.fontLarge(),
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: r.height(0.015)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: quickActions.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            title: Text(
                              quickActions[index]["title"],
                              style: TextStyle(color: textColor),
                            ),
                            value: tempSelected.contains(index),
                            activeColor: buttonColor,
                            checkColor: Colors.white,
                            onChanged: (value) {
                              setStateSheet(() {
                                if (value == true) {
                                  tempSelected.add(index);
                                } else {
                                  tempSelected.remove(index);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          quickActionController.updateSelection(tempSelected);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Done",
                          style: TextStyle(fontSize: r.fontMedium()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
