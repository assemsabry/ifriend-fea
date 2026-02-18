class MyTasksModel {
  bool? success;
  Data? data;

  MyTasksModel({this.success, this.data});

  MyTasksModel.fromJson(Map<String, dynamic> json) {
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
  List<Tasks>? tasks;

  Data({this.tasks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  String? id;
  String? childId;
  String? title;
  String? description;
  int? coins;
  String? status;
  bool? isDefault;
  bool? isActive;
  String? lastCompletedAt;
  String? createdAt;
  String? updatedAt;

  Tasks({
    this.id,
    this.childId,
    this.title,
    this.description,
    this.coins,
    this.status,
    this.isDefault,
    this.isActive,
    this.lastCompletedAt,
    this.createdAt,
    this.updatedAt,
  });

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childId = json['childId'];
    title = json['title'];
    description = json['description'];
    coins = json['coins'];
    status = json['status'];
    isDefault = json['isDefault'];
    isActive = json['isActive'];
    lastCompletedAt = json['lastCompletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['childId'] = childId;
    data['title'] = title;
    data['description'] = description;
    data['coins'] = coins;
    data['status'] = status;
    data['isDefault'] = isDefault;
    data['isActive'] = isActive;
    data['lastCompletedAt'] = lastCompletedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
