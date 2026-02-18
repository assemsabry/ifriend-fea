import 'dart:convert';
import 'dart:typed_data';

class SyncappsModel {
  final String appName;
  final String packageName;
  final Uint8List? icon; // المكتبة تعيد أيقونة كـ Uint8List
  bool isBlocked;

  SyncappsModel({
    required this.appName,
    required this.packageName,
    this.icon,
    this.isBlocked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "appName": appName,
      "packageName": packageName,
      "iconUrl": icon != null ? base64Encode(icon!) : "",
      "isBlocked": isBlocked, // تحويل البوليان إلى String
    };
  }
}
