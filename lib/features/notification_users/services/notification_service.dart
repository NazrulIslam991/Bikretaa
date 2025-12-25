import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../screens/notification_screen_user.dart';
import '../../shared/presentation/get_storeage_helper/get_storage_helper.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings();

    await _notificationsPlugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (_) {
        navigatorKey.currentState
            ?.pushNamed(NotificationScreenUser.name);
      },
    );
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required Map<String, dynamic> productData,
  }) async {
    // STORAGE SAVE (moved)
    NotificationStorageService.saveNotification(
      title: title,
      body: body,
      product: productData,
    );

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'inventory_alerts',
      'Inventory Alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(productData),
    );
  }
}
