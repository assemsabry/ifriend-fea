import 'package:dio/dio.dart';
import 'package:ifriend_app/core/networking/api_constants.dart';
import 'package:ifriend_app/features/old/device_management/data/models/linked_device.dart';

class DeviceManagementRemoteDataSource {
  final Dio dio;

  DeviceManagementRemoteDataSource({required this.dio});

  /// Fetch all devices linked to the parent account
  Future<List<LinkedDevice>> getLinkedDevices() async {
    try {
      print('🔍 Fetching linked devices from API...');
      final response = await dio.get(ApiConstants.getLinkedDevices);

      print('✅ API Response Status: ${response.statusCode}');
      print('✅ API Response Data: ${response.data}');

      final responseData = LinkedDeviceResponse.fromJson(response.data);

      if (responseData.success && responseData.data != null) {
        final devices = responseData.data!.devices;
        print('✅ Found ${devices.length} linked devices');
        return devices;
      } else {
        // If backend returns error message like "No linked children found", return empty list
        print('⚠️ No devices found (success=false or data=null)');
        return [];
      }
    } on DioException catch (e) {
      print('❌ DioException caught:');
      print('   Status Code: ${e.response?.statusCode}');
      print('   Response Data: ${e.response?.data}');

      // Check if it's a "no devices" error (should return empty list, not throw)
      final errorCode = e.response?.data?['error']?['code']?.toString();
      final errorMessage =
          e.response?.data?['error']?['message']?.toString() ??
          e.response?.data?['message']?.toString() ??
          '';

      print('   Error Code: $errorCode');
      print('   Error Message: $errorMessage');

      // Handle "No linked children" scenarios (403 with ACCESS_DENIED or 404)
      if (e.response?.statusCode == 403 && errorCode == 'ACCESS_DENIED') {
        // This is actually "no devices found", not a permission error
        print('✅ Confirmed: NO DEVICES LINKED (403 + ACCESS_DENIED)');
        return [];
      }

      if (e.response?.statusCode == 404 ||
          errorMessage.toLowerCase().contains('no linked') ||
          errorMessage.toLowerCase().contains('not found')) {
        print(
          '✅ Confirmed: NO DEVICES LINKED (404 or message contains "no linked")',
        );
        return [];
      }

      final message = errorMessage.isNotEmpty
          ? errorMessage
          : (e.message ?? 'Failed to fetch linked devices');
      print('❌ Throwing exception: $message');
      throw Exception(message);
    } catch (e) {
      // JSON parsing errors or unexpected errors
      print('❌ Unexpected error in getLinkedDevices: $e');
      return [];
    }
  }

  /// Remove a device from the parent account
  Future<bool> removeDevice(String deviceId) async {
    try {
      final response = await dio.delete(
        "${ApiConstants.removeDevice}?deviceId=$deviceId",
      );

      final responseData = RemoveDeviceResponse.fromJson(response.data);

      if (responseData.success) {
        return true;
      } else {
        throw Exception(responseData.message ?? 'Failed to remove device');
      }
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ??
          e.response?.data?['error']?['message'] ??
          e.message ??
          'Failed to remove device';
      throw Exception(message);
    }
  }
}
