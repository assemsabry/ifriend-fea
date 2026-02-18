class ParentProfileModel {
  bool? success;
  Data? data;

  ParentProfileModel({this.success, this.data});

  ParentProfileModel.fromJson(Map<String, dynamic> json) {
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
  Profile? profile;

  Data({this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    profile = json['profile'] != null
        ? Profile.fromJson(json['profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  bool? isSubscribed;
  String? phoneNumber;
  String? avatarUrl;
  String? createdAt;
  String? updatedAt;
  User? user;

  Profile({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.isSubscribed,
    this.phoneNumber,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isSubscribed = json['isSubscribed'];
    phoneNumber = json['phoneNumber'];
    avatarUrl = json['avatarUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['isSubscribed'] = isSubscribed;
    data['phoneNumber'] = phoneNumber;
    data['avatarUrl'] = avatarUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? userType;

  User({this.id, this.email, this.userType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['userType'] = userType;
    return data;
  }
}
