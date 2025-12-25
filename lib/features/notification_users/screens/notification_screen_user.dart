import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import '../../shared/presentation/get_storeage_helper/get_storage_helper.dart';
import '../../shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'notification_details_screen.dart';

class NotificationScreenUser extends StatefulWidget {
  const NotificationScreenUser({super.key});
  static const name = '/notification_screen_user';

  @override
  State<NotificationScreenUser> createState() =>
      _NotificationScreenUserState();
}

class _NotificationScreenUserState extends State<NotificationScreenUser> {
  List<dynamic> notificationList = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    setState(() {
      notificationList =
          NotificationStorageService.getHistory();
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      NotificationStorageService.removeNotificationAt(index);
      notificationList =
          NotificationStorageService.getHistory();
    });
  }

  void _clearAllNotifications() {
    setState(() {
      NotificationStorageService.clearAll();
      notificationList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications history',
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        actions: [
          if (notificationList.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
              onPressed: () => _showDeleteConfirmation(context),
            ),
        ],
      ),
      body: notificationList.isEmpty
          ? const Center(child: Text("No history available"))
          : ListView.builder(
        padding: EdgeInsets.symmetric(vertical: r.height(0.01)),
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          final item = notificationList[index];

          return Dismissible(
            key: Key(item['time']),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              _deleteNotification(index);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Notification deleted"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.redAccent,
              padding: EdgeInsets.only(right: r.width(0.05)),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotificationDetailsScreen(
                      product: item['product'],
                      alertTitle: item['title'],
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: r.width(0.04),
                  vertical: r.height(0.008),
                ),
                padding: EdgeInsets.all(r.paddingMedium()),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: r.width(0.18),
                      height: r.width(0.13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(r.radiusSmall()),
                        color: Colors.grey.shade200,
                        image: item['product']['image'] != null
                            && item['product']['image'].isNotEmpty
                            ? DecorationImage(
                          image: NetworkImage(
                              item['product']['image']),
                          fit: BoxFit.cover, ) : null, ),
                      child: item['product']['image'] == null || item['product']['image'].isEmpty
                          ? Icon(Icons.broken_image,
                          size: r.iconLarge(),
                          color: Colors.grey) : null,
                    ),
                    SizedBox(width: r.width(0.04)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] ?? '',
                            style: TextStyle(
                              fontSize: r.fontSmall(),
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(height: r.height(0.005)),
                          Text(
                            item['body'] ?? '',
                            style: TextStyle(
                              fontSize: r.fontSmall(),
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: r.iconSmall(),
                      color: theme.dividerColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) async {
    final confirm = await showConfirmDialog(
      context: context,
      title: "Clear All?",
      content: "Are you sure you want to delete all notification history?",
      confirmText: "Delete",
      cancelText: "Cancel",
      confirmColor: Colors.redAccent,
    );

    if (confirm) {
      _clearAllNotifications();
    }
  }
}
