import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotifications extends NotificationEvent {}

class MarkNotificationRead extends NotificationEvent {
  final String id;
  const MarkNotificationRead(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkAllNotificationsAsRead extends NotificationEvent {}

class ChangeNotificationTab extends NotificationEvent {
  final bool isUnreadTab;
  const ChangeNotificationTab({required this.isUnreadTab});

  @override
  List<Object?> get props => [isUnreadTab];
}
