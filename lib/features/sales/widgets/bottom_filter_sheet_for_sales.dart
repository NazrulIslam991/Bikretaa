import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            0,
            0,
            0,
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
        startDate = now.subtract(Duration(days: 7));
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
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Filter Sales",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Filter cards
            Column(
              children: SalesFilter.values.map((filter) {
                String title;
                IconData icon;
                Color color;
                switch (filter) {
                  case SalesFilter.fixedDate:
                    title = "Fixed Date";
                    icon = Icons.date_range;
                    color = Colors.blue;
                    break;
                  case SalesFilter.lastWeek:
                    title = "Last Week";
                    icon = Icons.calendar_view_week;
                    color = Colors.green;
                    break;
                  case SalesFilter.lastMonth:
                    title = "Last Month";
                    icon = Icons.calendar_month;
                    color = Colors.orange;
                    break;
                  case SalesFilter.lastYear:
                    title = "Last Year";
                    icon = Icons.calendar_today;
                    color = Colors.red;
                    break;
                }

                return Card(
                  color: theme.cardColor,
                  elevation: 2,
                  shadowColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withOpacity(0.2),
                      child: Icon(icon, color: color, size: 16.h),
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16.h),
                    onTap: () => _handleFilterSelection(context, filter),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
