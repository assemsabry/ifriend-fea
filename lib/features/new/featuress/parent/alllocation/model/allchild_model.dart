class AllMyChildModel {
  bool? success;
  Data? data;

  AllMyChildModel({this.success, this.data});

  AllMyChildModel.fromJson(Map<String, dynamic> json) {
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
  List<Children>? children;

  Data({this.children});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? id;
  String? name;
  String? avatar;
  String? dateOfBirth;
  String? gender;
  String? linkedAt;
  String? status;
  List<Devices>? devices;

  Children({
    this.id,
    this.name,
    this.avatar,
    this.dateOfBirth,
    this.gender,
    this.linkedAt,
    this.status,
    this.devices,
  });

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    linkedAt = json['linkedAt'];
    status = json['status'];
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add(Devices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['linkedAt'] = linkedAt;
    data['status'] = status;
    if (devices != null) {
      data['devices'] = devices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Devices {
  String? id;
  String? deviceName;
  String? deviceType;
  String? lastActive;
  String? batteryLevel;

  Devices({
    this.id,
    this.deviceName,
    this.deviceType,
    this.lastActive,
    this.batteryLevel,
  });

  Devices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceName = json['deviceName'];
    deviceType = json['deviceType'];
    lastActive = json['lastActive'];
    batteryLevel = json['batteryLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceName'] = deviceName;
    data['deviceType'] = deviceType;
    data['lastActive'] = lastActive;
    data['batteryLevel'] = batteryLevel;
    return data;
  }
}
