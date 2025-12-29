import 'package:equatable/equatable.dart';

class PermissionState extends Equatable {
  final bool notificationGranted;
  final bool locationGranted;
  final bool deviceGranted;
  final bool usageGranted;
  final bool isLoading;
  final String? errorMessage;

  const PermissionState({
    this.notificationGranted = false,
    this.locationGranted = false,
    this.deviceGranted = false,
    this.usageGranted = false,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Check if all required permissions are granted
  bool get allGranted =>
      notificationGranted &&
      locationGranted &&
      deviceGranted &&
      usageGranted;

  /// Copy with method for state updates
  PermissionState copyWith({
    bool? notificationGranted,
    bool? locationGranted,
    bool? deviceGranted,
    bool? usageGranted,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PermissionState(
      notificationGranted: notificationGranted ?? this.notificationGranted,
      locationGranted: locationGranted ?? this.locationGranted,
      deviceGranted: deviceGranted ?? this.deviceGranted,
      usageGranted: usageGranted ?? this.usageGranted,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        notificationGranted,
        locationGranted,
        deviceGranted,
        usageGranted,
        isLoading,
        errorMessage,
      ];
}
