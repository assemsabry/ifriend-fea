/// success : true
/// data : {"profile":{"id":"aabfb6df-37f1-4732-9475-c408af4ed9b5","userId":"1bebe2ec-b3a7-4f4e-94dd-4c48bda66f64","firstName":"435","lastName":"345345","phoneNumber":"01111111111","avatarUrl":null,"createdAt":"2025-12-24T20:54:04.587Z","updatedAt":"2025-12-24T23:10:07.103Z","user":{"id":"1bebe2ec-b3a7-4f4e-94dd-4c48bda66f64","email":"mostafaelshrbeeny98@gmail.com","userType":"PARENT"}}}

class ResponseProfileModel {
  ResponseProfileModel({
      bool? success, 
      Data? data,}){
    _success = success;
    _data = data;
}

  ResponseProfileModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  Data? _data;
ResponseProfileModel copyWith({  bool? success,
  Data? data,
}) => ResponseProfileModel(  success: success ?? _success,
  data: data ?? _data,
);
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// profile : {"id":"aabfb6df-37f1-4732-9475-c408af4ed9b5","userId":"1bebe2ec-b3a7-4f4e-94dd-4c48bda66f64","firstName":"435","lastName":"345345","phoneNumber":"01111111111","avatarUrl":null,"createdAt":"2025-12-24T20:54:04.587Z","updatedAt":"2025-12-24T23:10:07.103Z","user":{"id":"1bebe2ec-b3a7-4f4e-94dd-4c48bda66f64","email":"mostafaelshrbeeny98@gmail.com","userType":"PARENT"}}

class Data {
  Data({
      Profile? profile,}){
    _profile = profile;
}

  Data.fromJson(dynamic json) {
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  Profile? _profile;
Data copyWith({  Profile? profile,
}) => Data(  profile: profile ?? _profile,
);
  Profile? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }

}

/// id : "aabfb6df-37f1-4732-9475-c408af4ed9b5"
/// userId : "1bebe2ec-b3a7-4f4e-94dd-4c48bda66f64"
/// firstName : "435"
/// lastName : "345345"
/// phoneNumber : "01111111111"
/// avatarUrl : null
/// createdAt : "2025-12-24T20:54:04.587Z"
/// updatedAt : "2025-12-24T23:10:07.103Z"
/// user : {"id":"1bebe2ec-b3a7-4f4e-94dd-4c48bda66f64","email":"mostafaelshrbeeny98@gmail.com","userType":"PARENT"}

class Profile {
  Profile({
      String? id, 
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? phoneNumber, 
      dynamic avatarUrl, 
      String? createdAt, 
      String? updatedAt, 
      User? user,}){
    _id = id;
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _avatarUrl = avatarUrl;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _phoneNumber = json['phoneNumber'];
    _avatarUrl = json['avatarUrl'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _id;
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _phoneNumber;
  dynamic _avatarUrl;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
Profile copyWith({  String? id,
  String? userId,
  String? firstName,
  String? lastName,
  String? phoneNumber,
  dynamic avatarUrl,
  String? createdAt,
  String? updatedAt,
  User? user,
}) => Profile(  id: id ?? _id,
  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  phoneNumber: phoneNumber ?? _phoneNumber,
  avatarUrl: avatarUrl ?? _avatarUrl,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  user: user ?? _user,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get phoneNumber => _phoneNumber;
  dynamic get avatarUrl => _avatarUrl;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['phoneNumber'] = _phoneNumber;
    map['avatarUrl'] = _avatarUrl;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : "1bebe2ec-b3a7-4f4e-94dd-4c48bda66f64"
/// email : "mostafaelshrbeeny98@gmail.com"
/// userType : "PARENT"

class User {
  User({
      String? id, 
      String? email, 
      String? userType,}){
    _id = id;
    _email = email;
    _userType = userType;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _userType = json['userType'];
  }
  String? _id;
  String? _email;
  String? _userType;
User copyWith({  String? id,
  String? email,
  String? userType,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  userType: userType ?? _userType,
);
  String? get id => _id;
  String? get email => _email;
  String? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['userType'] = _userType;
    return map;
  }

}