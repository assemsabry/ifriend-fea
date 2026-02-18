import 'package:dartz/dartz.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../entities/notification_entity.dart';
import '../repos/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<Either<ApiErrorHandler, List<NotificationEntity>>> call() async {
    return await repository.getNotifications();
  }
}
