class ModesModel {
  bool? success;
  Data? data;

  ModesModel({this.success, this.data});

  ModesModel.fromJson(Map<String, dynamic> json) {
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
  List<Modes>? modes;

  Data({this.modes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['modes'] != null) {
      modes = <Modes>[];
      json['modes'].forEach((v) {
        modes!.add(Modes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modes != null) {
      data['modes'] = modes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modes {
  String? id;
  String? deviceId;
  String? type;
  bool? isActive;
  String? startTime;
  String? endTime;
  String? days;
  String? createdAt;
  String? updatedAt;
  List<ModeApps>? modeApps;

  Modes({
    this.id,
    this.deviceId,
    this.type,
    this.isActive,
    this.startTime,
    this.endTime,
    this.days,
    this.createdAt,
    this.updatedAt,
    this.modeApps,
  });

  Modes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    type = json['type'];
    isActive = json['isActive'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    days = json['days'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['modeApps'] != null) {
      modeApps = <ModeApps>[];
      json['modeApps'].forEach((v) {
        modeApps!.add(ModeApps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceId'] = deviceId;
    data['type'] = type;
    data['isActive'] = isActive;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['days'] = days;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (modeApps != null) {
      data['modeApps'] = modeApps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModeApps {
  String? id;
  String? modeId;
  String? appId;
  int? timeLimit;
  String? createdAt;
  String? updatedAt;
  App? app;

  ModeApps({
    this.id,
    this.modeId,
    this.appId,
    this.timeLimit,
    this.createdAt,
    this.updatedAt,
    this.app,
  });

  ModeApps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modeId = json['modeId'];
    appId = json['appId'];
    timeLimit = json['timeLimit'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    app = json['app'] != null ? App.fromJson(json['app']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['modeId'] = modeId;
    data['appId'] = appId;
    data['timeLimit'] = timeLimit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (app != null) {
      data['app'] = app!.toJson();
    }
    return data;
  }
}

class App {
  String? id;
  String? deviceId;
  String? appName;
  String? packageName;
  String? iconUrl;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;

  App({
    this.id,
    this.deviceId,
    this.appName,
    this.packageName,
    this.iconUrl,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
  });

  App.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    appName = json['appName'];
    packageName = json['packageName'];
    iconUrl = json['iconUrl'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceId'] = deviceId;
    data['appName'] = appName;
    data['packageName'] = packageName;
    data['iconUrl'] = iconUrl;
    data['isBlocked'] = isBlocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

const Map<String, int> dayIndexMap = {
  'SUN': 0,
  'MON': 1,
  'TUE': 2,
  'WED': 3,
  'THU': 4,
  'FRI': 5,
  'SAT': 6,
};
