import 'package:bikretaa/features/notification_admin/widgets/messege_input_feild_admin.dart';
import 'package:bikretaa/features/notification_admin/widgets/messege_title_input_feild_admin.dart';
import 'package:bikretaa/features/notification_admin/widgets/notification_card_admin.dart';
import 'package:bikretaa/features/notification_admin/widgets/notification_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedAudience = 'All Users';

  List<Map<String, String>> _recentNotifications = [
    {
      "title": "New Shop Verification Process",
      "message": "We have updated our shop verification process",
      "audience": "All Users",
      "time": "2024-11-06 10:15",
      "recipients": "1500",
    },
    {
      "title": "New Shop Verification Process",
      "message": "We have updated our shop verification process",
      "audience": "All Users",
      "time": "2024-11-06 10:15",
      "recipients": "1500",
    },
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications".tr,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send New Notification".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 12.h),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Title Input
                    Container(
                      height: 65.h,
                      child: MessegeTitleInputField_admin(
                        controller: _titleController,
                      ),
                    ),

                    // Message Input
                    SizedBox(
                      width: double.infinity,
                      child: MessageInputField_Admin(
                        controller: _messageController,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    Container(
                      height: 60.h,
                      child: NotificationDropdownField_Admin(
                        value: _selectedAudience,
                        options: [
                          "All Users".tr,
                          "Active Shops".tr,
                          "Deactive Shops".tr,
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedAudience = value!;
                          });
                        },
                        label: "Target Audience".tr,
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: ElevatedButton.icon(
                        onPressed: _sendNotification,
                        icon: Icon(Icons.send, size: 18.sp),
                        label: Text(
                          "Send Notification".tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              Text(
                "Recent Notifications".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: textColor,
                ),
              ),
              SizedBox(height: 10.h),

              // Notification List
              if (_recentNotifications.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: Text(
                      "No notifications yet".tr,
                      style: TextStyle(color: theme.hintColor),
                    ),
                  ),
                )
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _recentNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = _recentNotifications[index];
                    return NotificationCardAdmin(notification: notification);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendNotification() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _recentNotifications.insert(0, {
          "title": _titleController.text,
          "message": _messageController.text,
          "audience": _selectedAudience,
          "time": DateTime.now().toString().substring(0, 16),
          "recipients": "0",
        });
        _titleController.clear();
        _messageController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notification sent successfully!".tr)),
      );
    }
  }
}
