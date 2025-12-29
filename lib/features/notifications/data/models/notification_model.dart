import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/notification_entity.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required String id,
    required String type,
    required String title,
    required String message,
    @JsonKey(name: 'is_read') required bool isRead,
    @JsonKey(name: 'created_at') required String createdAt,
  }) : super(
         id: id,
         type: type,
         title: title,
         message: message,
         isRead: isRead,
         createdAt: createdAt,
       );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
