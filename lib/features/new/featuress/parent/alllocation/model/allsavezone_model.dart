class AllsavezoneModel {
  bool? success;
  Data? data;

  AllsavezoneModel({this.success, this.data});

  AllsavezoneModel.fromJson(Map<String, dynamic> json) {
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
  List<SafeZones>? safeZones;

  Data({this.safeZones});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['safeZones'] != null) {
      safeZones = <SafeZones>[];
      json['safeZones'].forEach((v) {
        safeZones!.add(SafeZones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (safeZones != null) {
      data['safeZones'] = safeZones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SafeZones {
  String? id;
  String? childId;
  String? name;
  String? address;

  num? latitude;
  num? longitude;
  num? radius;
  String? createdAt;
  String? updatedAt;

  SafeZones({
    this.id,
    this.childId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.radius,
    this.createdAt,
    this.updatedAt,
  });

  SafeZones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childId = json['childId'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    radius = json['radius'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['childId'] = childId;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['radius'] = radius;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
