class ChildProfileModel {
  bool? success;
  Data? data;

  ChildProfileModel({this.success, this.data});

  ChildProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? parentId;
  String? firstName;
  String? lastName;
  int? coins;
  // List<Null>? reports;
  String? avatarUrl;
  String? birthDate;
  String? gender;
  String? createdAt;
  String? updatedAt;
  User? user;

  Profile({
    this.id,
    this.userId,
    this.parentId,
    this.firstName,
    this.lastName,
    this.coins,
    // this.reports,
    this.avatarUrl,
    this.birthDate,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    parentId = json['parentId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    coins = json['coins'];
    // if (json['reports'] != null) {
    //   reports = <Null>[];
    //   json['reports'].forEach((v) {
    //     reports!.add(Null.fromJson(v));
    //   });
    // }
    avatarUrl = json['avatarUrl'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['parentId'] = parentId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['coins'] = coins;
    // if (reports != null) {
    //   data['reports'] = reports!.map((v) => v.toJson()).toList();
    // }
    data['avatarUrl'] = avatarUrl;
    data['birthDate'] = birthDate;
    data['gender'] = gender;
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
