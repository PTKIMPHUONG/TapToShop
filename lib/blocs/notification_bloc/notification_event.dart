import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationEvent {
  final String userId;

  const LoadNotifications({required this.userId});

  @override
  List<Object?> get props => [userId];
}
