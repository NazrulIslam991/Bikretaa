import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "about_bikretaa".tr,
          style: TextStyle(fontSize: r.fontXL()),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.width(0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo & Name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: r.width(0.1),
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: AssetImage(AssetPaths.logo),
                  ),
                  SizedBox(height: r.height(0.015)),
                  Text(
                    "Bikretaa",
                    style: TextStyle(
                      fontSize: r.fontXL(),
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: r.height(0.01)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: r.width(0.015)),
                    child: Text(
                      "bikretaa_description".tr,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: r.fontMedium(),
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: r.height(0.025)),

            // Why Bikretaa
            Padding(
              padding: EdgeInsets.only(left: r.width(0.01)),
              child: Text(
                "why_bikretaa".tr,
                style: TextStyle(
                  fontSize: r.fontLarge(),
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: r.height(0.005)),

            _featureTile(r, theme, Icons.speed, "fast_product_management".tr),
            _featureTile(
              r,
              theme,
              Icons.inventory,
              "stock_and_expiry_tracking".tr,
            ),
            _featureTile(
              r,
              theme,
              Icons.notifications_active,
              "low_stock_alerts".tr,
            ),
            _featureTile(r, theme, Icons.bar_chart, "sales_reports".tr),
            _featureTile(r, theme, Icons.security, "secure_login".tr),

            SizedBox(height: r.height(0.03)),

            // Team Section
            Padding(
              padding: EdgeInsets.only(left: r.width(0.01)),
              child: Text(
                "developed_by".tr,
                style: TextStyle(
                  fontSize: r.fontLarge(),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: r.height(0.012)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _teamMember(r, "Md N.I. Nayon", AssetPaths.nayon),
                _teamMember(r, "Md Nasim", AssetPaths.logo),
                _teamMember(r, "Toha Fardin", AssetPaths.fardin),
              ],
            ),
            SizedBox(height: r.height(0.03)),

            // Footer
            Center(
              child: Text(
                "footer_text".tr,
                style: TextStyle(
                  fontSize: r.fontSmall(),
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureTile(
    Responsive r,
    ThemeData theme,
    IconData icon,
    String title,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.blue, size: r.iconMedium()),
      title: Text(
        title,
        style: TextStyle(
          fontSize: r.fontMedium(),
          color: theme.colorScheme.primary,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _teamMember(Responsive r, String name, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: r.width(0.05),
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: r.height(0.007)),
        SizedBox(
          width: r.width(0.2),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: r.fontSmall(),
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
