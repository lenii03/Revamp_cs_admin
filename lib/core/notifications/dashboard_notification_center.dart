import 'package:flutter/foundation.dart';

enum DashboardNotificationType { success, failure }

class DashboardNotificationItem {
  const DashboardNotificationItem({
    required this.message,
    required this.type,
    required this.createdAt,
  });

  final String message;
  final DashboardNotificationType type;
  final DateTime createdAt;
}

class DashboardNotificationCenter {
  DashboardNotificationCenter._();

  static final DashboardNotificationCenter instance =
      DashboardNotificationCenter._();

  final ValueNotifier<List<DashboardNotificationItem>> notifications =
      ValueNotifier<List<DashboardNotificationItem>>(<DashboardNotificationItem>[]);

  void add({required String message, required bool success}) {
    final updated = <DashboardNotificationItem>[
      DashboardNotificationItem(
        message: message,
        type: success
            ? DashboardNotificationType.success
            : DashboardNotificationType.failure,
        createdAt: DateTime.now(),
      ),
      ...notifications.value,
    ];
    notifications.value = List.unmodifiable(updated.take(50));
  }

  void clear() {
    notifications.value = const <DashboardNotificationItem>[];
  }
}
