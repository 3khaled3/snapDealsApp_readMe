import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/notification_model.dart';
import '../../data/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  final NotificationRepository _repository = NotificationRepository();
  StreamSubscription? _notificationSubscription;

  void fetchNotifications() {
    print("fetchNotifications 11111");
    emit(NotificationLoading());
    print("fetchNotifications 22222");

    // Cancel any existing subscription to avoid multiple streams
    _notificationSubscription?.cancel();
    print("fetchNotifications 33333");

    // Debounce the stream to limit the frequency of emissions
    _notificationSubscription = _repository
        .getNotifications()
        .debounceTime(const Duration(milliseconds: 300))
        .listen(
      (notifications) {
        print("fetchNotifications 44444");
        if (state is! NotificationLoaded ||
            _hasNotificationsChanged(
                (state as NotificationLoaded).notifications, notifications)) {
          print("fetchNotifications 5555");
          emit(NotificationLoaded(notifications));
        }
        print("fetchNotifications 6666");
      },
      onError: (error) {
        print("fetchNotifications 7777");
        emit(NotificationError(error.toString()));
      },
    );
  }

  // Helper method to check if notifications have changed
  bool _hasNotificationsChanged(List<NotificationModel> oldNotifications,
      List<NotificationModel> newNotifications) {
    if (oldNotifications.length != newNotifications.length) return true;
    for (int i = 0; i < oldNotifications.length; i++) {
      if (oldNotifications[i] != newNotifications[i]) return true;
    }
    return false;
  }

  void markAsSeen(String id) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      // Update only the modified notification
      final updatedNotifications =
          currentState.notifications.map((notification) {
        if (notification.id == id) return notification.copyWith(isSeen: true);
        return notification;
      }).toList();

      emit(NotificationLoaded(updatedNotifications));

      // Persist the change
      await _repository.markAsSeen(id);
    }
  }

  void deleteNotification(String id) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      // Remove the deleted notification
      final updatedNotifications = currentState.notifications
          .where((notification) => notification.id != id)
          .toList();

      emit(NotificationLoaded(updatedNotifications));

      // Persist the deletion
      await _repository.deleteNotification(id);
    }
  }

  void markAllAsSeen() async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      emit(NotificationLoading());
      // Mark all as seen
      final updatedNotifications = currentState.notifications
          .map((notification) => notification.copyWith(isSeen: true))
          .toList();

      // Persist the change
      await _repository.markAllAsSeen();
      emit(NotificationLoaded(updatedNotifications));
    }
  }

  void deleteAll() async {
    emit(NotificationLoading());
    await _repository.deleteAllNotifications();
    emit(NotificationLoaded([]));
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}
