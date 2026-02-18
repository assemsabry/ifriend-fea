import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/config/themes/app_colors.dart';
import 'package:ifriend_app/features/new/coree/constants/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/linked/controller/qrcode_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/linked/model/successscan_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanqrcodeScreen extends StatefulWidget {
  const ScanqrcodeScreen({super.key});

  @override
  State<ScanqrcodeScreen> createState() => _ScanqrcodeScreenState();
}

class _ScanqrcodeScreenState extends State<ScanqrcodeScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
  );
  String? _scannedQrToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller.start();
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

  bool _isProcessing = false;

  void onBarcodeDetected(BarcodeCapture capture) async {
    if (_isProcessing) return; // منع التكرار
    if (capture.barcodes.isEmpty) return;

    final Barcode barcode = capture.barcodes.first;
    final String? raw = barcode.rawValue;
    if (raw == null) return;

    _isProcessing = true; // اقفل الاسكان فوراً
    await _controller.stop(); // وقف الكاميرا مباشرة

    String finalToken = raw;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map && decoded.containsKey('qrToken')) {
        finalToken = decoded['qrToken'];
      }
    } catch (_) {}

    QrCodeCubit.get(context).scanQrLinkDevice(qrCodeData: finalToken);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanSize = size.width * 0.65;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: DefAppbar(
        title: "Scan QR Code",
        color: AppColors.primary,
        backIcon: true,
        textColor: Colors.white,
      ),
      body: BlocListener<QrCodeCubit, QrCodeState>(
        listener: (context, state) {
          if (state is ScanQrCodeSuccess) {
            _controller.stop();
            _showChildConfirmBottomSheet(context, state.scanModel);
          }
          if (state is ScanQrCodeFailure) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                title: const Text('Scan failed'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      QrCodeCubit.get(context).resetScan();

                      _isProcessing = false; // افتح الاسكان من جديد
                      await _controller.start();
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: scanSize,
                  height: scanSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // الكاميرا
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: MobileScanner(
                          controller: _controller,
                          onDetect: onBarcodeDetected,

                          fit: BoxFit.cover,
                        ),
                      ),
                      // الـ overlay
                      CustomPaint(
                        size: Size(scanSize, scanSize),
                        painter: ScannerFramePainter(),
                      ),
                      // خط التحريك
                      ScanningAnimationLine(scanSize: scanSize),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChildConfirmBottomSheet(
    BuildContext context,
    SuccessScanModel res,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (ctx) {
        final child = res.data?.child;
        final avatarUrl = child?.avatar;
        final deviceModel = 'Unknown Device';
        final name = child?.name ?? 'Unknown';
        final battery = 0;
        final requestId = res.data?.requestId;

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
                      onTap: () async {
                        Navigator.of(ctx).pop();
                        QrCodeCubit.get(context).resetScan();

                        _isProcessing = false;
                        await _controller.start();
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
                      QrCodeCubit.get(context).confirmQrLinkDevice(
                        qrCodeData: QrCodeCubit.get(
                          context,
                        ).scannedQrToken.toString(),
                      );
                      // Prefer the scanned QR token when available; otherwise use the server's requestId
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
}

class ScannerOverlayPainter extends CustomPainter {
  final double scanAreaSize;
  ScannerOverlayPainter({required this.scanAreaSize});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: scanAreaSize,
            height: scanAreaSize,
          ),
          const Radius.circular(15),
        ),
      );

    final mainPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    canvas.drawPath(mainPath, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double cornerSize = 40;

    canvas.drawLine(Offset(0, 0), Offset(cornerSize, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerSize), paint);

    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - cornerSize, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerSize),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - cornerSize),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerSize, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - cornerSize, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - cornerSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ScanningAnimationLine extends StatefulWidget {
  final double scanSize;
  const ScanningAnimationLine({super.key, required this.scanSize});

  @override
  State<ScanningAnimationLine> createState() => _ScanningAnimationLineState();
}

class _ScanningAnimationLineState extends State<ScanningAnimationLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop(); // ✅ أوقفه أولاً

    _controller.dispose(); // 🔥 الحل هنا
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: _controller.value * widget.scanSize,
          left: 10,
          right: 10,
          child: Container(height: 2, color: Colors.white),
        );
      },
    );
  }
}
