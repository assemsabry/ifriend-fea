import 'package:json_annotation/json_annotation.dart';

part 'generate_qr_request.g.dart';

@JsonSerializable()
class GenerateQrRequest {
  final String deviceId;
  final String? deviceModel;
  final int? batteryPercentage;

  const GenerateQrRequest({
    required this.deviceId,
    this.deviceModel,
    this.batteryPercentage,
  });

  Map<String, dynamic> toJson() => _$GenerateQrRequestToJson(this);
}
