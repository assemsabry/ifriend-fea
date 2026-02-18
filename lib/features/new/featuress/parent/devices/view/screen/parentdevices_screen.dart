import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ifriend_app/core/di/injection.dart' as di;
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/features/new/coree/constants/def_appbar.dart';
import 'package:ifriend_app/features/new/featuress/parent/devices/controller/parentdevices_cubit.dart';
import 'package:ifriend_app/features/new/featuress/parent/devices/model/parentdevices_model.dart';
import 'package:ifriend_app/features/new/featuress/parent/linked/view/screen/scanqrcode_screen.dart';
import 'package:ifriend_app/features/old/device_management/domain/entities/device_entity.dart';
import 'package:ifriend_app/features/old/device_management/presentation/bloc/device_management_bloc.dart';
import 'package:ifriend_app/features/old/device_management/presentation/bloc/device_management_event.dart';
import 'package:ifriend_app/features/old/device_management/presentation/bloc/device_management_state.dart';
import 'package:ifriend_app/core/routing/routes.dart';

class ParentDevicesScreen extends StatelessWidget {
  const ParentDevicesScreen({super.key});

  void _showRemoveDeviceDialog(BuildContext context, DeviceEntity device) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.smartphone, size: 40.sp, color: Colors.red),
              ),
              SizedBox(height: 24.h),
              // Title
              Text(
                'Remove Device !',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.baseBlack,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 12.h),
              // Description
              Text(
                'Once deleted, monitoring, screen time control, and location tracking for this device will stop immediately.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorsManager.neutral600,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32.h),
              // Remove Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.read<DeviceManagementBloc>().add(
                      RemoveDevice(device.userId!),
                    );
                  },
                  child: Text(
                    'Remove Device',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.baseBlack,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(ctx).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentDevicesCubit()..getDevices(),
      child: BlocBuilder<ParentDevicesCubit, ParentDevicesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorsManager.baseWhite,
            appBar: DefAppbar(
              title: 'Child\'s Devices',
              color: ColorsManager.baseWhite,
              backIcon: true,
            ),

            body: BlocBuilder<ParentDevicesCubit, ParentDevicesState>(
              buildWhen: (previous, current) =>
                  current is ParentDevicesSuccessStates,
              builder: (context, state) {
                // BlocConsumer<ParentDevicesCubit, ParentDevicesState>(
                //   listener: (context, state) {
                //     if (state is DeviceRemoved) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text('Device removed successfully'),
                //           backgroundColor: Colors.green,
                //         ),
                //       );
                //     }
                //     if (state is DeviceRemovalError) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(state.error),
                //           backgroundColor: Colors.red,
                //         ),
                //       );
                //     }
                //   },
                //   builder: (context, state) {
                //     if (state is DeviceManagementLoading) {
                //       return const Center(
                //         child: CircularProgressIndicator(
                //           color: ColorsManager.primary,
                //         ),
                //       );
                //     }

                //     if (state is DeviceManagementError) {
                //       return Center(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.error_outline,
                //               size: 64.sp,
                //               color: Colors.red,
                //             ),
                //             SizedBox(height: 16.h),
                //             Text(
                //               state.message,
                //               style: TextStyle(
                //                 fontSize: 16.sp,
                //                 color: ColorsManager.neutral600,
                //                 fontFamily: 'Poppins',
                //               ),
                //             ),
                //             SizedBox(height: 24.h),
                //             ElevatedButton(
                //               onPressed: () => context
                //                   .read<DeviceManagementBloc>()
                //                   .add(const LoadLinkedDevices()),
                //               child: const Text('Retry'),
                //             ),
                //           ],
                //         ),
                //       );
                //     }
                if (state is ParentDevicesLoadingStates) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.primary,
                    ),
                  );
                }

                if (state is ParentDevicesErrorStates) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64.sp,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          state.error,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorsManager.neutral600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<ParentDevicesCubit>().getDevices(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state is ParentDevicesSuccessStates) {
                  if (state.parentDevicesModel.data!.devices!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.devices_other,
                            size: 80.sp,
                            color: ColorsManager.neutral400,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No devices linked yet',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorsManager.baseBlack,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Add a child device to get started',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorsManager.neutral600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(20.w),
                          itemCount:
                              state.parentDevicesModel.data!.devices!.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            final device =
                                state.parentDevicesModel.data!.devices![index];
                            return _DeviceCard(
                              device: device,
                              onRemove: () {},
                              //  () =>
                              //     _showRemoveDeviceDialog(context, device.id!),
                            );
                          },
                        ),
                      ),
                      // Add New Device Button
                      Container(
                        padding: EdgeInsets.all(20.w),
                        child: SizedBox(
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
                            onPressed: () {
                              Get.to(() => ScanqrcodeScreen());
                            },
                            child: Text(
                              'Add new devices',
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
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final Devices device;
  final VoidCallback onRemove;

  const _DeviceCard({required this.device, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.baseWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.neutral200, width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          // if (device. != null && device.childAvatar!.isNotEmpty)
          //   ClipRRect(
          //     borderRadius: BorderRadius.circular(12.r),
          //     child: Image.network(
          //       device.childAvatar!,
          //       width: 48.w,
          //       height: 48.w,
          //       fit: BoxFit.cover,
          //       errorBuilder: (context, error, stackTrace) {
          //         return
          //         _buildDefaultAvatar();
          //       },
          //     ),
          //   )
          // else
          _buildDefaultAvatar(),
          SizedBox(width: 12.w),
          // Name & Model
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.deviceName ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.baseBlack,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  device.deviceType ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorsManager.neutral600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          // Remove Button
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete_outline, size: 18.sp, color: Colors.red),
                  SizedBox(width: 4.w),
                  Text(
                    'Remove device',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: ColorsManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(Icons.person, size: 28.sp, color: ColorsManager.primary),
    );
  }
}
