class ChildDeviceModel {
  bool? success;
  Data? data;

  ChildDeviceModel({this.success, this.data});

  ChildDeviceModel.fromJson(Map<String, dynamic> json) {
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
  Device? device;

  Data({this.device});

  Data.fromJson(Map<String, dynamic> json) {
    device = json['device'] != null ? Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (device != null) {
      data['device'] = device!.toJson();
    }
    return data;
  }
}

class Device {
  String? id;
  String? userId;
  String? deviceName;
  String? deviceType;
  String? deviceIdentifier;
  String? fcmToken;
  String? deviceStatus;
  Null batteryLevel;
  String? lastActive;
  String? createdAt;
  String? updatedAt;

  Device({
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

  Device.fromJson(Map<String, dynamic> json) {
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
