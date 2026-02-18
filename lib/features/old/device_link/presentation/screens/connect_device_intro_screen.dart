import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/styles_manager.dart';
import '../../../../../core/theme/color_manager.dart';
import '../bloc/device_link_bloc.dart';
import '../bloc/device_link_event.dart';
import '../bloc/device_link_state.dart';

class ConnectDeviceIntroScreen extends StatelessWidget {
  const ConnectDeviceIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DeviceLinkBloc>(),
      child: BlocConsumer<DeviceLinkBloc, DeviceLinkState>(
        listener: (context, state) {
          if (state is DeviceLinkQrLoaded) {
            Navigator.pushNamed(
              context,
              Routes.showQrCodeScreen,
              arguments: state.qrCode,
            );
          } else if (state is DeviceLinkError) {
            print(state.message);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'Let’s Connect Your Device!',
                        style: TextStyles.font26Black600Weight,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Your parent will scan a QR code from their phone to link your device safely.',
                        style: TextStyles.font16Grey500Weight.copyWith(
                          fontWeight: FontWeight.normal,
                          color: ColorsManager.neutral500,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      _buildStep(
                        '01',
                        'Ready to Scan',
                        'Make sure your parent’s phone is nearby. When you’re ready, tap the button below to show your QR code.',
                      ),
                      SizedBox(height: 24.h),
                      _buildStep(
                        '02',
                        'Show the QR Code',
                        'Hold your phone steady and show this code to your parent’s camera.',
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<DeviceLinkBloc>().add(
                              GenerateQrToken(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Show My QR Code',
                            style: TextStyles.font16White400Weight.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
                if (state is DeviceLinkLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: ColorsManager.primary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: ColorsManager.baseWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorsManager.baseBlack,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  color: ColorsManager.neutral600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
