import '../../ressources/providers/network_utils/api_response.dart';
import '../../ressources/repositories/notification_repository.dart';
import '../models/notification.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc {
  final _notificationFetcher =
      BehaviorSubject<ApiResponse<List<NotificationModel>>>();
  final _notificationRepository = NotificationRepository();

  Stream<ApiResponse<List<NotificationModel>>> get notifications =>
      _notificationFetcher.stream;

  void fetchAllNotifications() async {
    _notificationFetcher.add(ApiResponse.loading("Loading notifications"));
    try {
      _notificationFetcher.add(ApiResponse.completed(
          await _notificationRepository.fetchAllNotifications()));
    } catch (e) {
      _notificationFetcher.add(ApiResponse.error(e.toString()));
    }
  }
}

final notificationBloc = NotificationBloc();
