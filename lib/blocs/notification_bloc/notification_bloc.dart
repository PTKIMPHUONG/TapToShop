import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationBloc(this._notificationRepository) : super(NotificationsInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
  }

  Future<void> _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationsLoading());
    try {
      final notifications = await _notificationRepository.getNotifications(event.userId);
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationsError(error: e.toString()));
    }
  }
}
