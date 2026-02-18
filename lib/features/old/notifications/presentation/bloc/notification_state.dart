import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';

enum NotificationStatus { initial, loading, loaded, error }

class NotificationState extends Equatable {
  final NotificationStatus status;
  final List<NotificationEntity> allNotifications;
  final List<NotificationEntity> filteredNotifications;
  final bool isUnreadTab;
  final String errorMessage;

  const NotificationState({
    this.status = NotificationStatus.initial,
    this.allNotifications = const [],
    this.filteredNotifications = const [],
    this.isUnreadTab = false,
    this.errorMessage = '',
  });

  int get unreadCount => allNotifications.where((e) => !e.isRead).length;

  NotificationState copyWith({
    NotificationStatus? status,
    List<NotificationEntity>? allNotifications,
    List<NotificationEntity>? filteredNotifications,
    bool? isUnreadTab,
    String? errorMessage,
  }) {
    return NotificationState(
      status: status ?? this.status,
      allNotifications: allNotifications ?? this.allNotifications,
      filteredNotifications:
          filteredNotifications ?? this.filteredNotifications,
      isUnreadTab: isUnreadTab ?? this.isUnreadTab,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allNotifications,
    filteredNotifications,
    isUnreadTab,
    errorMessage,
  ];
}
