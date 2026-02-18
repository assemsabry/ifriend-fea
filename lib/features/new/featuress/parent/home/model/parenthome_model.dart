class HomeParentModel {
  bool? success;
  Data? data;
  List<AllChildren>? allChildren;

  HomeParentModel({this.success, this.data, this.allChildren});

  HomeParentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['allChildren'] != null) {
      allChildren = <AllChildren>[];
      json['allChildren'].forEach((v) {
        allChildren!.add(AllChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (allChildren != null) {
      data['allChildren'] = allChildren!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Child? child;
  ActiveMode? activeMode;
  Usage? usage;
  Location? location;
  int? pendingTasksCount;
  //List<Null>? onlineActivity;

  Data({
    this.child,
    this.activeMode,
    this.usage,
    this.location,
    this.pendingTasksCount,
    //this.onlineActivity
  });

  Data.fromJson(Map<String, dynamic> json) {
    child = json['child'] != null ? Child.fromJson(json['child']) : null;
    activeMode = json['activeMode'] != null
        ? ActiveMode.fromJson(json['activeMode'])
        : null;
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    pendingTasksCount = json['pendingTasksCount'];
    // if (json['onlineActivity'] != null) {
    //   onlineActivity = <Null>[];
    //   json['onlineActivity'].forEach((v) {
    //     onlineActivity!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (child != null) {
      data['child'] = child!.toJson();
    }
    if (activeMode != null) {
      data['activeMode'] = activeMode!.toJson();
    }
    if (usage != null) {
      data['usage'] = usage!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['pendingTasksCount'] = pendingTasksCount;
    // if (onlineActivity != null) {
    //   data['onlineActivity'] =
    //       onlineActivity!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Child {
  String? id;
  String? firstName;
  String? lastName;
  String? avatarUrl;
  String? batteryLevel;
  String? lastActive;
  String? fcmToken;
  String? deviceIdentifier;
  String? deviceId;

  Child({
    this.id,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.batteryLevel,
    this.lastActive,
    this.fcmToken,
    this.deviceIdentifier,
    this.deviceId,
  });

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatarUrl = json['avatarUrl'];
    batteryLevel = json['batteryLevel'];
    lastActive = json['lastActive'];
    fcmToken = json['fcmToken'];
    deviceIdentifier = json['deviceIdentifier'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['avatarUrl'] = avatarUrl;
    data['batteryLevel'] = batteryLevel;
    data['lastActive'] = lastActive;
    data['fcmToken'] = fcmToken;
    data['deviceIdentifier'] = deviceIdentifier;
    data['deviceId'] = deviceId;
    return data;
  }
}

class Usage {
  int? totalMinutes;
  // List<Null>? topApps;

  Usage({this.totalMinutes /*this.topApps*/});

  Usage.fromJson(Map<String, dynamic> json) {
    totalMinutes = json['totalMinutes'];
    // if (json['topApps'] != null) {
    //   topApps = <Null>[];
    //   json['topApps'].forEach((v) {
    //     topApps!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMinutes'] = totalMinutes;
    // if (topApps != null) {
    //   data['topApps'] = topApps!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Location {
  int? latitude;
  int? longitude;
  String? lastUpdated;
  bool? isInSafeZone;

  Location({
    this.latitude,
    this.longitude,
    this.lastUpdated,
    this.isInSafeZone,
  });

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    lastUpdated = json['lastUpdated'];
    isInSafeZone = json['isInSafeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['lastUpdated'] = lastUpdated;
    data['isInSafeZone'] = isInSafeZone;
    return data;
  }
}

class AllChildren {
  String? id;
  String? firstName;
  String? lastName;
  String? avatarUrl;

  AllChildren({this.id, this.firstName, this.lastName, this.avatarUrl});

  AllChildren.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}

class ActiveMode {
  String? id;
  String? type;
  String? startTime;
  String? endTime;

  ActiveMode({this.id, this.type, this.startTime, this.endTime});

  ActiveMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
