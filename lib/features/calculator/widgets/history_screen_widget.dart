import 'package:bikretaa/app/controller/calculate_controller/calculator_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final CalculatorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: theme.iconTheme.color,
              size: r.iconMedium(),
            ),
            onPressed: () => controller.clearHistory(),
          ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.historyList.isEmpty) {
          return Center(
            child: Text(
              'No history yet',
              style: TextStyle(
                color: theme.textTheme.titleSmall?.color ?? Colors.grey,
                fontSize: r.fontLarge(),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.historyList.length,
          itemBuilder: (context, index) {
            final historyText = controller.historyList[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: r.paddingMedium(),
                vertical: r.paddingextraSmall(),
              ),
              child: Card(
                color: theme.cardColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: r.paddingMedium(),
                    vertical: r.paddingSmall(),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.secondary,
                    radius: r.iconSmall(),
                    child: Text(
                      '${index + 1}', // numbering
                      style: TextStyle(
                        color: theme.colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: r.fontMedium(),
                      ),
                    ),
                  ),
                  title: Text(
                    historyText,
                    style: TextStyle(
                      color: theme.textTheme.titleLarge?.color ?? Colors.white,
                      fontSize: r.fontLarge(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
