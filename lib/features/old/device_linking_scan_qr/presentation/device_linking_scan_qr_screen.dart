import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/featuress/parent/home/view/screen/parenthome_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button_back.dart';
import '../domain/usecases/confirm_link_usecase.dart';
import 'cubit/scan_qr_cubit.dart';
import 'cubit/scan_qr_state.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;
import 'package:ifriend_app/features/new/coree/local/hive_helper.dart';

class DeviceLinkingScanQrScreen extends StatelessWidget {
  const DeviceLinkingScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ScanQrCubit>()..checkAndRequestPermission(),
      child: const _DeviceLinkingScanQrScreenContent(),
    );
  }
}

class _DeviceLinkingScanQrScreenContent extends StatefulWidget {
  const _DeviceLinkingScanQrScreenContent();

  @override
  State<_DeviceLinkingScanQrScreenContent> createState() =>
      _DeviceLinkingScanQrScreenContentState();
}

class _DeviceLinkingScanQrScreenContentState
    extends State<_DeviceLinkingScanQrScreenContent>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
  );
  String? _scannedQrToken;

  @override
  void initState() {
    super.initState();
    HiveHelper.addData("isLinked", true);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      _controller.start();
    }
  }

  void _showChildConfirmBottomSheet(BuildContext context, dynamic res) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (ctx) {
        final child = res.child;
        final avatarUrl = child?.avatar;
        final deviceModel = res.deviceModel ?? 'Unknown Device';
        final name = child?.name ?? 'Unknown';
        final battery = res.batteryPercentage ?? 0;
        final requestId = res.requestId;

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            padding: EdgeInsets.fromLTRB(
              20.w,
              24.h,
              20.w,
              MediaQuery.of(ctx).viewInsets.bottom + 24.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.isThisYourChildDevice,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.baseBlack,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(ctx).pop();
                        // Resume scanning
                        _controller.start();
                        context.read<ScanQrCubit>().resetScan();
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsManager.neutral100,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: ColorsManager.baseBlack,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Child Info Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.neutral50,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      if (avatarUrl != null && avatarUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            avatarUrl,
                            width: 60.w,
                            height: 60.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: BoxDecoration(
                                  color: ColorsManager.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 32.sp,
                                  color: ColorsManager.primary,
                                ),
                              );
                            },
                          ),
                        )
                      else
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 32.sp,
                            color: ColorsManager.primary,
                          ),
                        ),
                      SizedBox(width: 12.w),
                      // Name & Model
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.baseBlack,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              deviceModel,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: ColorsManager.neutral600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Battery
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.battery_charging_full,
                              color: ColorsManager.primary,
                              size: 18.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '$battery%',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.primary,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      // Prefer the scanned QR token when available; otherwise use the server's requestId
                      final qrData = _scannedQrToken ?? requestId;
                      if (qrData == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error: Missing QR code data'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      Navigator.of(ctx).pop(); // Close sheet

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );

                      try {
                        final confirmUseCase = di.sl<ConfirmLinkUseCase>();
                        final confirmed = await confirmUseCase.call(
                          qrCodeData: qrData,
                        );

                        if (context.mounted) {
                          Navigator.of(context).pop(); // Close loading

                          if (confirmed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Device linked successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            HiveHelper.addData("isLinked", "true");
                            Get.off(() => ParenthomePage());
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //   Routes.homeLayout,
                            //   (route) => false,
                            // );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Navigator.of(context).pop(); // Close loading

                          // Extract clean message
                          String err = e.toString();
                          if (err.startsWith('Exception: ')) {
                            err = err.substring(11);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(err),
                              backgroundColor: Colors.red,
                            ),
                          );
                          // Resume scanning
                          _controller.start();
                          context.read<ScanQrCubit>().resetScan();
                        }
                      }
                    },
                    child: Text(
                      AppStrings.confirmChildDevice,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (capture.barcodes.isEmpty) return;
    final Barcode barcode = capture.barcodes.first;
    final String? raw = barcode.rawValue;
    if (raw == null) return;

    _controller.stop();

    // Extract token logic
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map && decoded.containsKey('qrToken')) {
        _scannedQrToken = decoded['qrToken'];
      } else {
        _scannedQrToken = raw;
      }
    } catch (_) {
      _scannedQrToken = raw;
    }

    context.read<ScanQrCubit>().onBarcodeDetected(raw);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.scanQRCode,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        leadingWidth: 72.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const CustomButtonBack(),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ScanQrCubit, ScanQrState>(
          listener: (context, state) {
            if (state is ScanQrPermissionGranted) {
              _controller.start();
            }
            if (state is ScanQrPermissionDenied) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Camera permission'),
                  content: const Text(
                    'Camera permission is required to scan QR codes.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        openAppSettings();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Settings'),
                    ),
                  ],
                ),
              );
            }
            if (state is ScanQrSuccess) {
              _showChildConfirmBottomSheet(context, state.response);
            }
            if (state is ScanQrFailure) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Scan failed'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<ScanQrCubit>().resetScan();
                        _controller.start();
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ScanQrPermissionDenied) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt, size: 64.sp, color: Colors.white54),
                    SizedBox(height: 16.h),
                    const Text(
                      'Camera permission denied',
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () => context
                          .read<ScanQrCubit>()
                          .checkAndRequestPermission(),
                      child: const Text(
                        'Request Permission',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                MobileScanner(
                  controller: _controller,
                  fit: BoxFit.cover,
                  onDetect: (capture) {
                    final cur = context.read<ScanQrCubit>().state;
                    if (cur is ScanQrLoading) return;
                    _onDetect(capture);
                  },
                ),

                // Overlay Frame
                Center(
                  child: Container(
                    width: 280.w,
                    height: 280.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Stack(
                      children: [
                        // Corners
                        _buildCorner(top: 0, left: 0),
                        _buildCorner(top: 0, right: 0),
                        _buildCorner(bottom: 0, left: 0),
                        _buildCorner(bottom: 0, right: 0),
                      ],
                    ),
                  ),
                ),
                if (state is ScanQrLoading)
                  Container(
                    color: Colors.black45,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCorner({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: top == 0 && left == 0
                ? Radius.circular(20.r)
                : Radius.zero,
            topRight: top == 0 && right == 0
                ? Radius.circular(20.r)
                : Radius.zero,
            bottomLeft: bottom == 0 && left == 0
                ? Radius.circular(20.r)
                : Radius.zero,
            bottomRight: bottom == 0 && right == 0
                ? Radius.circular(20.r)
                : Radius.zero,
          ),
          border: Border(
            top: top == 0
                ? BorderSide(color: Colors.white, width: 4.w)
                : BorderSide.none,
            bottom: bottom == 0
                ? BorderSide(color: Colors.white, width: 4.w)
                : BorderSide.none,
            left: left == 0
                ? BorderSide(color: Colors.white, width: 4.w)
                : BorderSide.none,
            right: right == 0
                ? BorderSide(color: Colors.white, width: 4.w)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
