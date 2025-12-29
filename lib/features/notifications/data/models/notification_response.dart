import 'package:json_annotation/json_annotation.dart';
import 'notification_model.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  final List<NotificationModel> notifications;

  NotificationResponse({required this.notifications});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);
}
