class AllMyChildLocationModel {
  bool? success;
  Data? data;

  AllMyChildLocationModel({this.success, this.data});

  AllMyChildLocationModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? avatarUrl;
  CurrentLocation? currentLocation;

  Children({
    this.id,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.currentLocation,
  });

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatarUrl = json['avatarUrl'];
    currentLocation = json['currentLocation'] != null
        ? CurrentLocation.fromJson(json['currentLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['avatarUrl'] = avatarUrl;
    if (currentLocation != null) {
      data['currentLocation'] = currentLocation!.toJson();
    }
    return data;
  }
}

class CurrentLocation {
  int? latitude;
  int? longitude;
  String? lastUpdated;
  bool? isInSafeZone;
  String? address;

  CurrentLocation({
    this.latitude,
    this.longitude,
    this.lastUpdated,
    this.isInSafeZone,
    this.address,
  });

  CurrentLocation.fromJson(Map<String, dynamic> json) {
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
