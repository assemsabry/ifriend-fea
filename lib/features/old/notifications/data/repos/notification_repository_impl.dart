import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repos/notification_repository.dart';
import '../sources/notification_api_service.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiService _apiService;

  NotificationRepositoryImpl(this._apiService);

  @override
  Future<Either<ApiErrorHandler, List<NotificationEntity>>>
  getNotifications() async {
    try {
      final response = await _apiService.getNotifications();
      return Right(response.notifications);
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorHandler, void>> markAllAsRead() async {
    try {
      await _apiService.markAllAsRead();
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiErrorHandler, void>> markAsRead(String id) async {
    try {
      await _apiService.markAsRead(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiErrorHandler.fromDioError(e));
    } catch (e) {
      return Left(ApiErrorHandler(message: e.toString()));
    }
  }
}
