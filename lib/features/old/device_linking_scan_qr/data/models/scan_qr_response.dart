class ScanQrResponse {
  final bool success;
  final String? requestId;
  final Child? child;
  final String? status;
  final String? message;
  final String? deviceModel;
  final int? batteryPercentage;
  final ScanQrError? error;

  ScanQrResponse({
    required this.success,
    this.requestId,
    this.child,
    this.status,
    this.message,
    this.deviceModel,
    this.batteryPercentage,
    this.error,
  });

  factory ScanQrResponse.fromJson(Map<String, dynamic> json) {
    // Be defensive: `data` may be Map, List, or null. Normalize to a Map if possible.
    final dynamic rawData = json['data'];
    Map<String, dynamic>? data;
    if (rawData is Map<String, dynamic>) {
      data = rawData;
    } else if (rawData is List &&
        rawData.isNotEmpty &&
        rawData.first is Map<String, dynamic>) {
      data = Map<String, dynamic>.from(rawData.first as Map);
    } else {
      data = null;
    }

    return ScanQrResponse(
      success: json['success'] == true,
      requestId: data != null ? data['requestId'] as String? : null,
      child:
          data != null &&
              data['child'] != null &&
              data['child'] is Map<String, dynamic>
          ? Child.fromJson(Map<String, dynamic>.from(data['child']))
          : null,
      status: data != null ? data['status'] as String? : null,
      message: data != null ? data['message'] as String? : null,
      deviceModel: data != null ? data['deviceModel'] as String? : null,
      batteryPercentage: data != null
          ? (data['batteryPercentage'] is int
                ? data['batteryPercentage'] as int
                : (int.tryParse('${data['batteryPercentage']}')))
          : null,
      error: json['error'] != null && json['error'] is Map<String, dynamic>
          ? ScanQrError.fromJson(Map<String, dynamic>.from(json['error']))
          : null,
    );
  }
}

class Child {
  final String id;
  final String name;
  final String? avatar;
  final String? dateOfBirth;
  final String? gender;

  Child({
    required this.id,
    required this.name,
    this.avatar,
    this.dateOfBirth,
    this.gender,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
    );
  }
}

class Avatar {
  final String id;
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final String? birthDate;
  final String? gender;

  Avatar({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    this.birthDate,
    this.gender,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatarUrl: json['avatarUrl'],
      birthDate: json['birthDate'],
      gender: json['gender'],
    );
  }
}

class ScanQrError {
  final String message;
  final String code;

  ScanQrError({required this.message, required this.code});

  factory ScanQrError.fromJson(Map<String, dynamic> json) {
    return ScanQrError(message: json['message'], code: json['code']);
  }
}
