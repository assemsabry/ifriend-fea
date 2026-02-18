class ChildlocationModel {
  bool? success;
  Data? data;

  ChildlocationModel({this.success, this.data});

  ChildlocationModel.fromJson(Map<String, dynamic> json) {
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
  Location? location;

  Data({this.location});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  String? id;
  String? childId;
  int? latitude;
  int? longitude;
  String? lastUpdated;
  bool? isInSafeZone;
  String? createdAt;
  String? updatedAt;

  Location({
    this.id,
    this.childId,
    this.latitude,
    this.longitude,
    this.lastUpdated,
    this.isInSafeZone,
    this.createdAt,
    this.updatedAt,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childId = json['childId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    lastUpdated = json['lastUpdated'];
    isInSafeZone = json['isInSafeZone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['childId'] = childId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['lastUpdated'] = lastUpdated;
    data['isInSafeZone'] = isInSafeZone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
