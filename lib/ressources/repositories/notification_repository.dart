import '../../models/notification.dart';

import '../../ressources/providers/notification_list_provider.dart';

class NotificationRepository {
  final _notificationListProvider = NotificationListProvider();

  Future<List<NotificationModel>> fetchAllNotifications() async {
    final response = await _notificationListProvider.fetchNotifications();
    return response.map((value) => NotificationModel.fromMap(value)).toList();
  }
}
