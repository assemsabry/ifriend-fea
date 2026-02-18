class SuccessScanModel {
  bool? success;
  Data? data;

  SuccessScanModel({this.success, this.data});

  SuccessScanModel.fromJson(Map<String, dynamic> json) {
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
  String? requestId;
  Child? child;
  String? status;
  String? message;

  Data({this.requestId, this.child, this.status, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    child = json['child'] != null ? Child.fromJson(json['child']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    if (child != null) {
      data['child'] = child!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Child {
  String? id;
  String? name;
  String? avatar;
  String? dateOfBirth;
  String? gender;

  Child({this.id, this.name, this.avatar, this.dateOfBirth, this.gender});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    return data;
  }
}
