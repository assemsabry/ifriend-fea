import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class HiveHelper {
  static String boxName = "data";

  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box<dynamic> getBox() {
    return Hive.box(boxName);
  }

  static void addData(String key, dynamic value) {
    getBox().put(key, jsonEncode(value));
  }

  static dynamic getData(String key) {
    try {
      final box = getBox();
      var data = box.get(key);
      if (data != null) {
        return jsonDecode(data);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<String> getPublicIP() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.ipify.org?format=json'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint(data['ip']);
        HiveHelper.addData("ipAddress", data['ip']);

        return data['ip'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }

  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (kDebugMode) {
        print(androidInfo.id);
      }
      HiveHelper.addData("device_id", androidInfo.id);
      return androidInfo.id;
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      iosInfo.identifierForVendor;
      if (kDebugMode) {
        print(iosInfo.identifierForVendor);
      }

      HiveHelper.addData("device_id", iosInfo.identifierForVendor);

      return iosInfo.identifierForVendor ?? '';
    }
    return '';
  }

  static void remove(String key) {
    getBox().delete(key);
  }

  static void clearAll() {
    getBox().clear();
  }
}
