class GeneratecodeModel {
  bool? success;
  Data? data;

  GeneratecodeModel({this.success, this.data});

  GeneratecodeModel.fromJson(Map<String, dynamic> json) {
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
  String? qrCodeImage;
  String? qrCodeData;
  String? expiresAt;

  Data({this.requestId, this.qrCodeImage, this.qrCodeData, this.expiresAt});

  Data.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    qrCodeImage = json['qrCodeImage'];
    qrCodeData = json['qrCodeData'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    data['qrCodeImage'] = qrCodeImage;
    data['qrCodeData'] = qrCodeData;
    data['expiresAt'] = expiresAt;
    return data;
  }
}
