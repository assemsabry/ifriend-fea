class ParentdevicesModel {
  bool? success;
  Data? data;

  ParentdevicesModel({this.success, this.data});

  ParentdevicesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Devices>? devices;

  Data({this.devices});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add(Devices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (devices != null) {
      data['devices'] = devices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Devices {
  String? id;
  String? userId;
  String? deviceName;
  String? deviceType;
  String? deviceIdentifier;
  String? fcmToken;
  String? deviceStatus;
  String? batteryLevel;
  String? lastActive;
  String? createdAt;
  String? updatedAt;

  Devices({
    this.id,
    this.userId,
    this.deviceName,
    this.deviceType,
    this.deviceIdentifier,
    this.fcmToken,
    this.deviceStatus,
    this.batteryLevel,
    this.lastActive,
    this.createdAt,
    this.updatedAt,
  });

  Devices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    deviceName = json['deviceName'];
    deviceType = json['deviceType'];
    deviceIdentifier = json['deviceIdentifier'];
    fcmToken = json['fcmToken'];
    deviceStatus = json['deviceStatus'];
    batteryLevel = json['batteryLevel'];
    lastActive = json['lastActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['deviceName'] = deviceName;
    data['deviceType'] = deviceType;
    data['deviceIdentifier'] = deviceIdentifier;
    data['fcmToken'] = fcmToken;
    data['deviceStatus'] = deviceStatus;
    data['batteryLevel'] = batteryLevel;
    data['lastActive'] = lastActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
