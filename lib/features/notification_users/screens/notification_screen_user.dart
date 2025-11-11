import 'package:flutter/material.dart';

class NotificationScreenUser extends StatefulWidget {
  const NotificationScreenUser({super.key});
  static const name = '/notification_screen_user';

  @override
  State<NotificationScreenUser> createState() => _NotificationScreenUserState();
}

class _NotificationScreenUserState extends State<NotificationScreenUser> {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Order Confirmed',
      'content':
          'Your recent order #12345 has been confirmed. We’ll notify you when it ships.',
      'details':
          'Your order #12345 is confirmed and being processed. Expected delivery: 12 Nov 2025. Track your order in the Orders section for updates.',
    },
    {
      'title': 'New Offer!',
      'content':
          'Get 15% off on all electronics this week. Limited time offer!',
      'details':
          'We’re excited to offer you an exclusive 15% discount on all electronics. Offer valid until 15 Nov 2025. Use code: BIK15 at checkout.',
    },
    {
      'title': 'Account Update',
      'content': 'Your profile information has been successfully updated.',
      'details':
          'We noticed you made some changes to your profile. Everything looks good! If this wasn’t you, please contact our support team immediately.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                notification['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  notification['content']!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => NotificationDetailsScreen(
                //       title: notification['title']!,
                //       details: notification['details']!,
                //     ),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
