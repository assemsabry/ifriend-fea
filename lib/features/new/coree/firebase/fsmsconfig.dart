import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/features/new/featuress/child/auth/qrcode/controller/qrcode_cubit.dart';

Future<NotificationSettings> requestPermissionNotification() async {
  NotificationSettings notificationsSetting = await FirebaseMessaging.instance
      .requestPermission();
  if (kDebugMode) {
    print(
      'User granted permission: ${notificationsSetting.authorizationStatus}',
    );
  }

  return notificationsSetting;
}

void fsmsconfig() async {
  final token = await FirebaseMessaging.instance.getToken();

  if (kDebugMode) {
    print(
      "Test==============Notifications ========================================\n$token",
    );
  }
  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification!.title.toString() == "تم تفعيل حسابك بنجاح") {
      QrcodeCubit.get(Get.context!).checkApproval();
      // HiveHelper.addData("status", "active");

      // AuthorProfileCubit.get(Get.context!).getAuthorProfile();
    }
    if (kDebugMode) {
      print("================== Notification =================");
    }
    if (kDebugMode) {
      print(message.notification!.title);
    }
    if (kDebugMode) {
      print(message.notification!.body);
    }
    log('$message');
    FlutterRingtonePlayer().playNotification();
  });
}
