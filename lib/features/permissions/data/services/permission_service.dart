import 'dart:io';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent_plus/android_intent.dart';

/// Service to handle all permission-related operations
/// Supports Android-specific permissions for parental control app
class PermissionService {
  static const platform = MethodChannel('com.example.ifriend_app/permissions');

  /// Check if notification permission is granted
  Future<bool> isNotificationAccessGranted() async {
    if (!Platform.isAndroid) return false;
    
    // Check standard notification permission (shows popup)
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  /// Check if location permission is granted
  Future<bool> isLocationAccessGranted() async {
    if (!Platform.isAndroid) return false;

    final status = await Permission.location.status;
    final backgroundStatus = await Permission.locationAlways.status;

    // Both foreground and background location must be granted
    return status.isGranted && backgroundStatus.isGranted;
  }

  /// Check if device admin permission is granted
  Future<bool> isDeviceAccessGranted() async {
    if (!Platform.isAndroid) return false;

    // Check for system alert window permission (overlay permission)
    // This is commonly used for parental control apps
    final status = await Permission.systemAlertWindow.status;
    return status.isGranted;
  }

  Future<bool> isUsageAccessGranted() async {
    if (!Platform.isAndroid) return false;

    try {
      final bool granted = await platform.invokeMethod('checkUsagePermission');
      return granted;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Request notification access - opens system settings
  Future<void> requestNotificationAccess() async {
    if (!Platform.isAndroid) return;

    // Simple popup request as requested
    await Permission.notification.request();
  }

  /// Request location permission
  Future<bool> requestLocationAccess() async {
    if (!Platform.isAndroid) return false;

    try {
      // Request fine location first
      var status = await Permission.location.request();

      if (status.isDenied) {
        // If denied, open settings
        await openAppSettings();
        return false;
      }

      if (status.isGranted) {
        // Then request background location
        final backgroundStatus = await Permission.locationAlways.request();

        if (backgroundStatus.isDenied) {
          // Open settings for background location
          await openAppSettings();
          return false;
        }

        return backgroundStatus.isGranted;
      }

      return false;
    } catch (e) {
      await openAppSettings();
      return false;
    }
  }

  /// Request device admin access - opens system settings
  Future<void> requestDeviceAccess() async {
    if (!Platform.isAndroid) return;

    try {
      // Request system alert window permission
      final status = await Permission.systemAlertWindow.request();

      if (!status.isGranted) {
        // Open system settings for device admin
        const intent = AndroidIntent(
          action: 'android.settings.SECURITY_SETTINGS',
        );
        await intent.launch();
      }
    } catch (e) {
      await openAppSettings();
    }
  }

  /// Request usage access - opens system settings
  Future<void> requestUsageAccess() async {
    if (!Platform.isAndroid) return;

    try {
      const intent = AndroidIntent(
        action: 'android.settings.USAGE_ACCESS_SETTINGS',
      );
      await intent.launch();
    } catch (e) {
      // Fallback to app settings
      await openAppSettings();
    }
  }

  /// Check all permissions at once from device
  Future<Map<String, bool>> checkAllPermissions() async {
    if (!Platform.isAndroid) {
      return {
        'notification': false,
        'location': false,
        'device': false,
        'usage': false,
      };
    }

    // Check each permission from actual device
    final notification = await isNotificationAccessGranted();
    final location = await isLocationAccessGranted();
    final device = await isDeviceAccessGranted();
    final usage = await isUsageAccessGranted();

    return {
      'notification': notification,
      'location': location,
      'device': device,
      'usage': usage,
    };
  }
}
