import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_notification_read_usecase.dart';
import '../../domain/usecases/mark_all_notifications_read_usecase.dart';
import '../../domain/entities/notification_entity.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationReadUseCase markNotificationReadUseCase;
  final MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.markNotificationReadUseCase,
    required this.markAllNotificationsReadUseCase,
  }) : super(const NotificationState()) {
    on<FetchNotifications>(_onFetchNotifications);
    on<MarkNotificationRead>(_onMarkNotificationRead);
    on<MarkAllNotificationsAsRead>(_onMarkAllNotificationsAsRead);
    on<ChangeNotificationTab>(_onChangeNotificationTab);
  }

  List<NotificationEntity> _filter(List<NotificationEntity> list, bool unreadOnly) {
    if (unreadOnly) {
      return list.where((e) => !e.isRead).toList();
    }
    return list;
  }

  Future<void> _onFetchNotifications(FetchNotifications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    final result = await getNotificationsUseCase();
    result.fold(
      (error) => emit(state.copyWith(status: NotificationStatus.error, errorMessage: error.message)),
      (data) {
        emit(state.copyWith(
          status: NotificationStatus.loaded,
          allNotifications: data,
          filteredNotifications: _filter(data, state.isUnreadTab),
        ));
      },
    );
  }

  void _onChangeNotificationTab(ChangeNotificationTab event, Emitter<NotificationState> emit) {
    emit(state.copyWith(
      isUnreadTab: event.isUnreadTab,
      filteredNotifications: _filter(state.allNotifications, event.isUnreadTab),
    ));
  }

  Future<void> _onMarkNotificationRead(MarkNotificationRead event, Emitter<NotificationState> emit) async {
    // Optimistic Update
    final updatedList = state.allNotifications.map((e) {
      if (e.id == event.id) {
        // Create new entity with isRead = true
        // Entity is Equatable (immutable), so we need a copyWith or recreate.
        // Entity doesn't have copyWith in the snippet I wrote. Use manual recreation.
        return NotificationEntity(
             id: e.id,
             type: e.type,
             title: e.title,
             message: e.message,
             isRead: true,
             createdAt: e.createdAt,
        );
      }
      return e;
    }).toList();

    emit(state.copyWith(
      allNotifications: updatedList,
      filteredNotifications: _filter(updatedList, state.isUnreadTab),
    ));

    final result = await markNotificationReadUseCase(event.id);
    result.fold(
      (error) {
        // Revert on error? Or just show error.
        // For now, let's just log or ignore as it's optimistic.
        // We could emit error state but that might flicker UI.
      },
      (success) {},
    );
  }

  Future<void> _onMarkAllNotificationsAsRead(MarkAllNotificationsAsRead event, Emitter<NotificationState> emit) async {
    final updatedList = state.allNotifications.map((e) {
      return NotificationEntity(
             id: e.id,
             type: e.type,
             title: e.title,
             message: e.message,
             isRead: true,
             createdAt: e.createdAt,
      );
    }).toList();

    emit(state.copyWith(
      allNotifications: updatedList,
      filteredNotifications: _filter(updatedList, state.isUnreadTab),
    ));

    final result = await markAllNotificationsReadUseCase();
    result.fold(
      (error) {},
      (success) {},
    );
  }
}
