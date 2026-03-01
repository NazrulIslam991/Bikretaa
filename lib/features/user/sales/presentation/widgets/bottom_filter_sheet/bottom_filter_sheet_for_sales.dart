import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SalesFilter { fixedDate, lastWeek, lastMonth, lastYear }

typedef FilterCallback = void Function(DateTime? startDate, DateTime? endDate);

class SalesFilterSheet extends StatelessWidget {
  final FilterCallback onFilterSelected;

  const SalesFilterSheet({super.key, required this.onFilterSelected});

  Future<void> _handleFilterSelection(
    BuildContext context,
    SalesFilter filter,
  ) async {
    final now = DateTime.now();
    DateTime? startDate;
    DateTime? endDate;

    switch (filter) {
      case SalesFilter.fixedDate:
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2000),
          lastDate: now,
        );
        if (selectedDate != null) {
          startDate = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
          );
          endDate = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            23,
            59,
            59,
          );
        }
        break;
      case SalesFilter.lastWeek:
        endDate = now;
        startDate = now.subtract(const Duration(days: 7));
        break;
      case SalesFilter.lastMonth:
        endDate = now;
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case SalesFilter.lastYear:
        endDate = now;
        startDate = DateTime(now.year - 1, now.month, now.day);
        break;
    }

    onFilterSelected(startDate, endDate);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: r.height(0.4)),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(r.height(0.01)),
            topRight: Radius.circular(r.height(0.01)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: r.paddingSmall(),
                horizontal: r.paddingSmall(),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: r.width(0.1),
                      height: r.height(0.002),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(r.radiusSmall()),
                      ),
                    ),
                  ),
                  SizedBox(height: r.height(0.02)),
                  Center(
                    child: Text(
                      "filter_sales".tr,
                      style: TextStyle(
                        fontSize: r.fontXL(),
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(height: r.height(0.005)),
                ],
              ),
            ),

            // Filter List
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: r.paddingSmall()),
                child: Column(
                  children: SalesFilter.values.map((filter) {
                    String title;
                    IconData icon;
                    Color color;

                    switch (filter) {
                      case SalesFilter.fixedDate:
                        title = "fixed_date".tr;
                        icon = Icons.date_range;
                        color = Colors.blue;
                        break;
                      case SalesFilter.lastWeek:
                        title = "last_week".tr;
                        icon = Icons.calendar_view_week;
                        color = Colors.green;
                        break;
                      case SalesFilter.lastMonth:
                        title = "last_month".tr;
                        icon = Icons.calendar_month;
                        color = Colors.orange;
                        break;
                      case SalesFilter.lastYear:
                        title = "last_year".tr;
                        icon = Icons.calendar_today;
                        color = Colors.red;
                        break;
                    }

                    return Card(
                      color: theme.cardColor,
                      elevation: 1,
                      shadowColor: Colors.blueAccent.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusSmall()),
                        side: BorderSide(
                          color: theme.brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black54,
                          width: 1,
                        ),
                      ),
                      // ⬇️ Reduced vertical margin (was 0.01)
                      margin: EdgeInsets.symmetric(vertical: r.height(0.005)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: r.height(0.004),
                          horizontal: r.width(0.02),
                        ),
                        leading: CircleAvatar(
                          radius: r.iconMedium(),
                          backgroundColor: color.withOpacity(0.2),
                          child: Icon(icon, color: color, size: r.iconSmall()),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: r.fontMedium(),
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: r.iconSmall(),
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        onTap: () => _handleFilterSelection(context, filter),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // ⬇️ Fixed bottom space
            SizedBox(height: r.height(0.02)),
          ],
        ),
      ),
    );
  }
}
