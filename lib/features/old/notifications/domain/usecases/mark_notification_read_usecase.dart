import 'package:dartz/dartz.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../repos/notification_repository.dart';

class MarkNotificationReadUseCase {
  final NotificationRepository repository;

  MarkNotificationReadUseCase(this.repository);

  Future<Either<ApiErrorHandler, void>> call(String id) async {
    return await repository.markAsRead(id);
  }
}
