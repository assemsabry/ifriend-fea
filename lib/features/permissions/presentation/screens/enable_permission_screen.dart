import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/di/injection.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/permissions/presentation/bloc/permission_bloc.dart';
import 'package:ifriend_app/features/permissions/presentation/bloc/permission_event.dart';
import 'package:ifriend_app/features/permissions/presentation/bloc/permission_state.dart';
import 'package:ifriend_app/features/permissions/presentation/widgets/permission_card.dart';
import 'package:ifriend_app/core/routing/routes.dart';

class EnablePermissionScreen extends StatelessWidget {
  const EnablePermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PermissionBloc>()..add(const CheckPermissions()),
      child: const _EnablePermissionContent(),
    );
  }
}

class _EnablePermissionContent extends StatefulWidget {
  const _EnablePermissionContent();

  @override
  State<_EnablePermissionContent> createState() =>
      _EnablePermissionContentState();
}

class _EnablePermissionContentState extends State<_EnablePermissionContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Add observer to detect when app resumes from settings
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When app resumes, refresh permissions
    if (state == AppLifecycleState.resumed) {
      context.read<PermissionBloc>().add(const RefreshPermissions());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.baseWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: ColorsManager.baseWhite,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              color: ColorsManager.baseBlack,
              size: 24.sp,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<PermissionBloc, PermissionState>(
        listener: (context, state) {
          // Show error message if any
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        // Illustration icon
                        Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsManager.primary.withOpacity(0.1),
                            border: Border.all(
                              color: ColorsManager.primary.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.verified_user_outlined,
                            size: 60.sp,
                            color: ColorsManager.primary,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Title
                        Text(
                          'Enable Permission',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.baseBlack,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Subtitle
                        Text(
                          'Allow access to enhance functionality and improve experience.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorsManager.neutral500,
                            fontFamily: 'Poppins',
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        // Permission cards
                        PermissionCard(
                          icon: Icons.notifications_outlined,
                          title: 'Enable Notification Access',
                          description:
                              'This helps us monitor notifications for safety and parental alerts.',
                          isGranted: state.notificationGranted,
                          onTap: () {
                            context.read<PermissionBloc>().add(
                                  const RequestNotificationPermission(),
                                );
                          },
                        ),
                        PermissionCard(
                          icon: Icons.location_on_outlined,
                          title: 'Allow Location Access',
                          description:
                              'Used to show your child\'s location and keep them safe.',
                          isGranted: state.locationGranted,
                          onTap: () {
                            context.read<PermissionBloc>().add(
                                  const RequestLocationPermission(),
                                );
                          },
                        ),
                        PermissionCard(
                          icon: Icons.phone_android_outlined,
                          title: 'Allow Device Access',
                          description:
                              'We need access to your device settings to manage screen time and app use.',
                          isGranted: state.deviceGranted,
                          onTap: () {
                            context.read<PermissionBloc>().add(
                                  const RequestDevicePermission(),
                                );
                          },
                        ),
                        PermissionCard(
                          icon: Icons.bar_chart_outlined,
                          title: 'Grant Usage Access',
                          description:
                              'We use this permission to track which apps are used and for how long.',
                          isGranted: state.usageGranted,
                          onTap: () {
                            context.read<PermissionBloc>().add(
                                  const RequestUsagePermission(),
                                );
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
                // Bottom button
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  decoration: BoxDecoration(
                    color: ColorsManager.baseWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: state.allGranted
                            ? () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.connectDeviceIntroScreen,
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primary,
                          disabledBackgroundColor:
                              ColorsManager.primary.withOpacity(0.4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          'Enable Permission',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
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
}
