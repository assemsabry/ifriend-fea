// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

// Future<NotificationSettings> requestPermissionNotification() async {
//   NotificationSettings notificationsSetting = await FirebaseMessaging.instance
//       .requestPermission();
//   if (kDebugMode) {
//     print(
//       'User granted permission: ${notificationsSetting.authorizationStatus}',
//     );
//   }

//   return notificationsSetting;
// }

// void fsmsconfig() {
//   if (kDebugMode) {
//     print(
//       "Test==============Notifications ========================================",
//     );
//   }
//   FirebaseMessaging.onMessage.listen((message) {
//     if (kDebugMode) {
//       print("================== Notification =================");
//     }
//     if (kDebugMode) {
//       print(message.notification!.title);
//     }
//     if (kDebugMode) {
//       print(message.notification!.body);
//     }
//     FlutterRingtonePlayer().playNotification();
//     // Get.snackbar(message.notification!.title!, message.notification!.body!);
//     // refreshPageNotification(message.data);
//   });
// }

// // void refreshPageNotification(Map<String, dynamic> data) {
// //   if (kDebugMode) {
// //     print("============================= page id ");
// //   }
// //   if (kDebugMode) {
// //     print(data['pageid']);
// //   }
// //   if (kDebugMode) {
// //     print("============================= page name ");
// //   }
// //   if (kDebugMode) {
// //     print(data['pagename']);
// //   }
// //   if (kDebugMode) {
// //     print("================== Current Route");
// //   }
// //   if (kDebugMode) {
// //     print(Get.currentRoute);
// //   }

// //   if (Get.currentRoute == "/splashScreen" &&
// //       data['pagename'] == "refreshorderpending") {}
// // }
