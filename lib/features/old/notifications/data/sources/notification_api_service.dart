import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/notification_response.dart';

part 'notification_api_service.g.dart';

@RestApi()
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio) = _NotificationApiService;

  @GET("/notifications/get-all-notifications")
  Future<NotificationResponse> getNotifications();

  @PATCH("/notifications/mark-all-as-read")
  Future<void> markAllAsRead();

  @PATCH("/notifications/mark-as-read/{id}")
  Future<void> markAsRead(@Path("id") String id);

  @DELETE("/notifications/delete-notification/{id}")
  Future<void> deleteNotification(@Path("id") String id);
}
