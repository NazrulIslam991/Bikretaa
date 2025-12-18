import 'package:bikretaa/features/notification_admin/widgets/messege_input_feild_admin.dart';
import 'package:bikretaa/features/notification_admin/widgets/messege_title_input_feild_admin.dart';
import 'package:bikretaa/features/notification_admin/widgets/notification_card_admin.dart';
import 'package:bikretaa/features/notification_admin/widgets/notification_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/responsive.dart';

class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({super.key});

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedAudience = 'All Users';

  final List<Map<String, String>> _recentNotifications = [
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
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications".tr,
          style: TextStyle(fontSize: r.fontXL(), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: r.height(0.015),
          left: r.width(0.025),
          right: r.width(0.025),
          bottom: r.height(0.008),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send New Notification".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: r.fontLarge(),
                  color: primaryColor,
                ),
              ),
              SizedBox(height: r.height(0.015)),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Title Input
                    SizedBox(
                      height: r.height(0.065),
                      child: MessegeTitleInputFieldadmin(
                        controller: _titleController,
                      ),
                    ),

                    SizedBox(height: r.height(0.015)),

                    // Message Input
                    SizedBox(
                      width: double.infinity,
                      child: MessageInputFieldAdmin(
                        controller: _messageController,
                      ),
                    ),

                    SizedBox(height: r.height(0.02)),

                    // Audience Dropdown
                    SizedBox(
                      height: r.height(0.06),
                      child: NotificationDropdownFieldAdmin(
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

                    SizedBox(height: r.height(0.02)),

                    // Send Button
                    SizedBox(
                      width: double.infinity,
                      height: r.height(0.055),
                      child: ElevatedButton(
                        onPressed: _sendNotification,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send, size: r.iconMedium()),
                            SizedBox(width: r.width(0.02)),
                            Text(
                              "Send Notification".tr,
                              style: TextStyle(
                                fontSize: r.fontMedium(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: r.height(0.025)),

              Text(
                "Recent Notifications".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: r.fontMedium(),
                  color: textColor,
                ),
              ),
              SizedBox(height: r.height(0.012)),

              // Notification List
              if (_recentNotifications.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: r.height(0.02)),
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
