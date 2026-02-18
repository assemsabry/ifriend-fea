class LoginModel {
  bool? success;
  Data? data;

  LoginModel({this.success, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  String? refreshToken;
  bool? isNewUser;
  User? user;

  Data({this.accessToken, this.refreshToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    isNewUser = json['isNewUser'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['isNewUser'] = isNewUser;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? authProvider;
  String? userType;
  String? firstName;
  String? lastName;
  String? avatarUrl;

  User({
    this.id,
    this.email,
    this.authProvider,
    this.userType,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    authProvider = json['authProvider'];
    userType = json['userType'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['authProvider'] = authProvider;
    data['userType'] = userType;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}
