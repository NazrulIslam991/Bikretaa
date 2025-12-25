import 'package:get_storage/get_storage.dart';

class NotificationStorageService {
  static final GetStorage _box = GetStorage();

  static const String _historyKey = 'notification_history';
  static const String _notifiedIdsKey = 'notified_ids';

  // ---------- Notification History ----------
  static List<Map<String, dynamic>> getHistory() {
    final data = _box.read<List<dynamic>>(_historyKey) ?? [];
    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static void saveNotification({
    required String title,
    required String body,
    required Map<String, dynamic> product,
  }) {
    final history = getHistory();

    history.insert(0, {
      'title': title,
      'body': body,
      'product': product,
      'time': DateTime.now().toString(),
    });

    _box.write(_historyKey, history);
  }

  static void removeNotificationAt(int index) {
    final history = getHistory();
    history.removeAt(index);
    _box.write(_historyKey, history);
  }

  static void clearAll() {
    _box.remove(_historyKey);
  }

  // ---------- Notified Product IDs ----------
  static Set<String> getNotifiedIds() {
    final list = _box.read<List<dynamic>>(_notifiedIdsKey) ?? [];
    return list.map((e) => e.toString()).toSet();
  }

  static void saveNotifiedId(String id) {
    final ids = getNotifiedIds();
    ids.add(id);
    _box.write(_notifiedIdsKey, ids.toList());
  }

  static void removeNotifiedId(String id) {
    final ids = getNotifiedIds();
    ids.remove(id);
    _box.write(_notifiedIdsKey, ids.toList());
  }
}
