import 'package:dartz/dartz.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../repos/notification_repository.dart';

class MarkAllNotificationsReadUseCase {
  final NotificationRepository repository;

  MarkAllNotificationsReadUseCase(this.repository);

  Future<Either<ApiErrorHandler, void>> call() async {
    return await repository.markAllAsRead();
  }
}
