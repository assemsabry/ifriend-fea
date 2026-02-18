import 'package:dartz/dartz.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<ApiErrorHandler, List<NotificationEntity>>> getNotifications();
  Future<Either<ApiErrorHandler, void>> markAllAsRead();
  Future<Either<ApiErrorHandler, void>> markAsRead(String id);
}
