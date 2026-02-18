class AppsModel {
  bool? success;
  Data? data;

  AppsModel({this.success, this.data});

  AppsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class Data {
  List<Apps>? apps;

  Data({this.apps});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['apps'] != null) {
      apps = <Apps>[];
      json['apps'].forEach((v) {
        apps!.add(Apps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (apps != null) {
      json['apps'] = apps!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class Apps {
  String? id;
  String? deviceId;
  String? appName;
  String? packageName;
  String? iconUrl;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;

  Apps({
    this.id,
    this.deviceId,
    this.appName,
    this.packageName,
    this.iconUrl,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
  });

  Apps.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['deviceId'] = deviceId;
    json['appName'] = appName;
    json['packageName'] = packageName;
    json['iconUrl'] = iconUrl;
    json['isBlocked'] = isBlocked;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    return json;
  }
}
