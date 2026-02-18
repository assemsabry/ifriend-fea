import 'dart:convert';

import 'package:flutter/foundation.dart';

class AllappsModel {
  final String appName;
  final String packageName;
  final Uint8List? icon;
  final bool isBlocked;

  AllappsModel({
    required this.appName,
    required this.packageName,
    this.icon,
    required this.isBlocked,
  });

  AllappsModel copyWith({bool? isBlocked}) {
    return AllappsModel(
      appName: appName,
      packageName: packageName,
      icon: icon,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }

  // تحويل الكائن لـ Map بسيط
  Map<String, dynamic> toMap() {
    return {
      "appName": appName,
      "packageName": packageName,
      "iconBase64": icon != null ? base64Encode(icon!) : "",
      "isBlocked": isBlocked,
    };
  }
}
